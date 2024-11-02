//
//  RegistrationScreen.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 02/11/24.
//

import SwiftUI

struct RegistrationScreen: View {
    @Bindable var viewModel: AuthenticationViewModel
    @Environment(\.settings) private var settings
    
    var body: some View {
        VStack {
            Text("register")
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
            
            RegisterButton()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder private func RegisterButton() -> some View {
        if self.viewModel.isBusy {
            ProgressView()
        } else {
            Button(action: {
                Task {
                    await viewModel.register()
                }
            }, label: {
                Text("register")
                    .frame(maxWidth: .infinity)
                
            })
            .buttonStyle(PrimaryRoundedButtonStyle(color: settings.selectedAccentColor))
            .disabled(!viewModel.isValid)
        }
    }
}

#Preview {
    @Previewable @State var viewModel: AuthenticationViewModel = .init()
    RegistrationScreen(viewModel: viewModel)
}
