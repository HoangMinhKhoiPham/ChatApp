//
//  SignUpView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-09.
//

import SwiftUI
import FirebaseAuth
struct SignUpView: View {
    // MARK: - PROPERTY
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""

    @EnvironmentObject private var model: Model
    @EnvironmentObject private var appState: AppState
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
    }
    // MARK: - FUNCTION
    private func signUp() async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await model.updateDisplayName(for: result.user, displayName: displayName)
            appState.routes.append(.login)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - BODY
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            TextField("Display name", text: $displayName)
            
            HStack {
                Spacer()
                Button {
                    Task {
                      await signUp()
                    }
                } label: {
                    Text("SignUp")
                }
                .disabled(!isFormValid)
                    .buttonStyle(.borderless)
                Button {
                    // Take user to loginView()
                    appState.routes.append(.login)
                } label: {
                    Text("Login")
                }
                .buttonStyle(.borderless)
                
                Spacer()

            }
            Text(errorMessage)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(Model())
            .environmentObject(AppState())
    }
}
