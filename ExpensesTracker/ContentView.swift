//
//  ContentView.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var authenticationViewModel: AuthenticationViewModel = .init()
    
    var body: some View {
        Group {
            if let user = authenticationViewModel.user {
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
    ContentView()
}
