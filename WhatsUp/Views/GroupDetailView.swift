//
//  SwiftUIView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-10.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
struct GroupDetailView: View {
    // MARK: - PROPERTY
    let group: Group
    @State private var chatText: String = ""
    @State private var groupDetailConfig = GroupDetailConfig()
    @EnvironmentObject private var model: Model
    @FocusState private var isChatTextFieldFocused: Bool
    
    // MARK: - FUNCTION
    private func sendMessage() async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        var chatMessage = ChatMessage(text: chatText, uid: currentUser.uid, displayName: currentUser.displayName ?? "Guest", profilePhotoURL: currentUser.photoURL == nil ? "" : currentUser.photoURL!.absoluteString)
        if let selectedImage = groupDetailConfig.selectedImage {
            guard let resizedImage = selectedImage.resize(to: CGSize(width: 600, height: 600)),
                  let imageData = resizedImage.pngData()
            else { return }
            
            let url = try await Storage.storage().updateData(for: UUID().uuidString, data: imageData, bucket: .attachments)
            chatMessage.attachmentPhotoURL = url.absoluteString
        }
        try await model.saveChatMessageToGroup(chatMessage: chatMessage, group: group)
        //
    }
    
    var body: some View {
        VStack {
            
            ScrollViewReader { proxy in
                ChatMessageListView(chatMessages: model.chatMessages)
                    .onChange(of: model.chatMessages) { newValue in
                        if !model.chatMessages.isEmpty {
                            let lastChatMessage = model.chatMessages[model.chatMessages.endIndex - 1]
                            withAnimation{
                                proxy.scrollTo(lastChatMessage.id , anchor: .bottom)
                            }
                        } //: CONDITION
                    }
            } //: SCROLLVIEW
            Spacer()
        } //: VSTACK
        .frame(maxWidth: .infinity)
        .padding()
        .confirmationDialog("Options", isPresented: $groupDetailConfig.showOptions, actions: {
            Button("Camera") {
                groupDetailConfig.sourceType = .camera
            }
            Button("Photo Library") {
                groupDetailConfig.sourceType = .photoLibrary
            }
        })
        .sheet(item: $groupDetailConfig.sourceType, content: { sourceType in
            ImagePicker(image: $groupDetailConfig.selectedImage, sourceType: sourceType)
        })
        .overlay(alignment: .bottom, content: {
            ChatMessageInputView(groupDetailConfig: $groupDetailConfig, onSendMessage:  {
                // send Message
                Task {
                    do {
                        try await sendMessage()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }, isChatTextFieldFocused: _isChatTextFieldFocused)
            .padding()
        })
        .onDisappear {
            model.detachFirebaseListener()
        }
        .onAppear{
            model.listenForChatMessages(in: group)
        }
    }
}

struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailView(group: Group(subject: "Movies"))
            .environmentObject(Model())
    }
}
