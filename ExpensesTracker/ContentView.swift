//
//  ContentView.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import SwiftUI

struct ContentView: View {
    @Bindable var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        Group {
            if authenticationViewModel.user != nil {
                // Main Screen
                MainView(authViewModel: authenticationViewModel)
            } else {
                // Authentication Screen
                NavigationStack {
                    AuthenticationScreen(viewModel: authenticationViewModel)
                }
            }
        }
        .animation(.easeOut, value: authenticationViewModel.user)
    }
}

#Preview {
    @Previewable @State var authenticationViewModel: AuthenticationViewModel = .init()
    ContentView(authenticationViewModel: authenticationViewModel)
}
