//
//  LoginScreen.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import SwiftUI
import AuthenticationServices

struct LoginScreen: View {
    @Bindable var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.settings) private var settings
    
    var body: some View {
        VStack {
            Text("login")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(text: $viewModel.username) {
                Label("email", systemImage: "envelope")
            }
            .textFieldStyle(RoundedTextFieldStyle())
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .textInputAutocapitalization(.never)
            
            HStack {
                if viewModel.isShowingPassword {
                    TextField(text: $viewModel.password) {
                        Label("password", systemImage: "key")
                    }
                } else {
                    SecureField(text: $viewModel.password) {
                        Label("password", systemImage: "key")
                    }
                }
            }
            .textFieldStyle(RoundedTextFieldStyle())
            .textContentType(.password)
            .textInputAutocapitalization(.never)
            
            
            LoginButton()
            
            Divider()
            HStack {
                SignInWithAppleButton(.signIn) { request in
                    
                } onCompletion: { result in
                    
                }
                .signInWithAppleButtonStyle(.black)
                .frame(maxHeight: 50)
            }
            
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder func LoginButton() -> some View {
        if self.viewModel.isBusy {
            ProgressView()
        } else {
            Button(action: {
                Task {
                    await viewModel.login()
                }
            }, label: {
                Text("login")
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .buttonStyle(PrimaryRoundedButtonStyle(color: settings.selectedAccentColor))
            .disabled(!viewModel.isValid)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = AuthenticationViewModel()
    LoginScreen(viewModel: viewModel)
}
