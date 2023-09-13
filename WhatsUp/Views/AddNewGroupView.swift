//
//  AddNewGroupView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-10.
//

import SwiftUI

struct AddNewGroupView: View {
    // MARK: - PROPERTY
    @State private var groupSubject: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: Model
    private var isFormValid: Bool {
        !groupSubject.isEmptyOrWhiteSpace
    }
    
    // MARK: - FUNCTION
    private func saveGroup() {
        let group = Group(subject: groupSubject)
        model.saveGroup(group: group) { error in
            if let error {
                print(error.localizedDescription)
            }
            dismiss()
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Group Subject", text: $groupSubject)
                } //: HSTACK
                Spacer()
            }//: VSTACK
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("New Group")
                        .bold()
                } //: TOOLBARITEM
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                } //: TOOLBARITEM
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create"){
                        saveGroup()
                    }.disabled(!isFormValid)
                } //: TOOLBARITEM
            } //: TOOLBAR
        } //: NAVIGATIONSTACK
        .padding()
    }
}

struct AddNewGroupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddNewGroupView()
                .environmentObject(Model())
        }
    }
}
