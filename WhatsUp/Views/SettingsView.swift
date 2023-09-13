//
//  SettingsView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-11.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct SettingsConfig {
    var showPhotoOptions: Bool = false
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var displayName: String = ""
}
struct SettingsView: View {
    // MARK: - PROPERTY
    @State private var settingConfig = SettingsConfig()
    @FocusState var isEditing: Bool
    var displayName: String {
        guard let currentUser = Auth.auth().currentUser else { return "Guest" }
        return currentUser.displayName ?? "Guest"
    }
    @EnvironmentObject private var model: Model
    @State private var currentPhotoURL: URL? = Auth.auth().currentUser!.photoURL
    // MARK: - BODY
    var body: some View {
        VStack{
            AsyncImage(url: currentPhotoURL) { image in
                image.rounded()
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .rounded()
            }
            .onTapGesture {
                settingConfig.showPhotoOptions = true
            }
            .confirmationDialog("Select", isPresented: $settingConfig.showPhotoOptions) {
                Button("Camera") {
                    settingConfig.sourceType = .camera
                }
                Button("Photo Library") {
                    settingConfig.sourceType = .photoLibrary
                }
                
            } //: CONFIRMATIONDIALOG
            TextField(settingConfig.displayName, text: $settingConfig.displayName)
                .textFieldStyle(.roundedBorder)
                .focused($isEditing)
                .textInputAutocapitalization(.never)
            
            Spacer()
            Button("SignOut") {
                //
            }
        }//: VSTACK
        .sheet(item: $settingConfig.sourceType, content: { sourceType in
            ImagePicker(image: $settingConfig.selectedImage, sourceType: sourceType)
        })
        .onChange(of: settingConfig.selectedImage, perform: { image in
            // resize the image
            guard let img = image,
                  let resizedImage = img.resize(to: CGSize(width: 100, height: 100)),
                  let imageData = resizedImage.pngData()
            else {return}
            
            // upload the image to Firebase Storage to get the url
            Task {
                guard let currentUser = Auth.auth().currentUser else {return}
                let filename = "\(currentUser.uid).png"
                do {
                    let url = try await Storage.storage().updateData(for: filename, data: imageData, bucket: .photos)
                    try await model.updatePhotoURL(for: currentUser, photoURL: url)
                    currentPhotoURL = url
                } catch {
                    print(error)
                }
            }
            
        })
        .padding()
        .onAppear{
            settingConfig.displayName = displayName
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    guard let currentUser = Auth.auth().currentUser else {return}
                    Task {
                        do {
                            try await model.updateDisplayName(for: currentUser, displayName: settingConfig.displayName)
                        } catch {
                            print(error)
                        }
                    } //: TASK
                } //: BUTTON
            } //: TOOLBARITEM
        } //: TOOLBAR
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Model())
    }
}
