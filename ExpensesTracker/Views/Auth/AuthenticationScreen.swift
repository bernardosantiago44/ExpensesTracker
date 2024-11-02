//
//  AuthenticationScreen.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import SwiftUI

struct AuthenticationScreen: View {
    @Environment(\.settings) var settings
    @Bindable var viewModel: AuthenticationViewModel
    @Namespace var transitionNamespace
    
    var body: some View {
        VStack {
            Text("hello")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .fontWeight(.semibold)
            Text("welcomeMessage")
                .multilineTextAlignment(.center)
            
            VStack {
                loginButton
                signupButton
            }
            .frame(minWidth: 150)
            .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
    }
    
    var loginButton: some View {
        NavigationLink {
            LoginScreen(viewModel: viewModel)
                .navigationBarBackButtonHidden()
                .navigationTransition(.zoom(sourceID: "loginButtonLabel", in: transitionNamespace))
        } label: {
            Text("login")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(settings.selectedAccentColor)
                .clipShape(Capsule())
                .matchedTransitionSource(id: "loginButtonLabel", in: transitionNamespace)
        }
    }
    
    var signupButton: some View {
        NavigationLink {
            RegistrationScreen(viewModel: viewModel)
                .navigationBarBackButtonHidden()
                .navigationTransition(.zoom(sourceID: "signupButtonLabel", in: transitionNamespace))
        } label: {
            Text("signup")
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .stroke(settings.selectedAccentColor, style: StrokeStyle(lineWidth: 2))
                        .padding(1)
                )
                .matchedTransitionSource(id: "signupButtonLabel", in: transitionNamespace)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = AuthenticationViewModel()
    NavigationStack {
        AuthenticationScreen(viewModel: viewModel)
    }
}
