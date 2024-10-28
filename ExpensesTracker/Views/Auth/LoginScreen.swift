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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("login")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(text: $viewModel.username) {
                Label("email", systemImage: "envelope")
            }
            
            TextField(text: $viewModel.password) {
                Label("password", systemImage: "key")
            }
            
            Button("login") {}
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
}

#Preview {
    @Previewable @State var viewModel = AuthenticationViewModel()
    LoginScreen(viewModel: viewModel)
}
