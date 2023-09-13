//
//  LoginView.swift
//  WhatsUp
//
//  Created by Hoang Minh Khoi Pham on 2023-09-10.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    // MARK: - PROPERTY
    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject private var appState: AppState
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func login() async {
        do {
            let _ = try await Auth.auth().signIn(withEmail: email, password: password)
            appState.routes.append(.main)
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: - BODY
    var body: some View {
        Form {
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            
            HStack {
                Spacer()
                Button {
                    //Login
                    Task {
                        await login()
                    }
                } label: {
                    Text("Login")
                }
                .disabled(!isFormValid)
                    .buttonStyle(.borderless)
                Button {
                    // go to the signUp page
                    appState.routes.append(.signUp)
                } label: {
                    Text("SignUp")
                }
                .buttonStyle(.borderless)
                
                Spacer()

            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppState())
    }
}
