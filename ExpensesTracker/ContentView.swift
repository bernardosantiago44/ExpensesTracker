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
        NavigationStack {
            AuthenticationScreen(viewModel: authenticationViewModel)
        }
    }
}

#Preview {
    ContentView()
}
