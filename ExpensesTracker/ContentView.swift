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
                Text("Hello, \(user.email ?? "User")!")
            } else {
                // Authentication Screen
                NavigationStack {
                    AuthenticationScreen(viewModel: authenticationViewModel)
                }
            }
        }.animation(.linear, value: authenticationViewModel.user)
    }
}

#Preview {
    ContentView()
}
