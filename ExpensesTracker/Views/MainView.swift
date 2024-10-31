//
//  MainView.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 30/10/24.
//

import SwiftUI

struct MainView: View {
    @Bindable var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Button("Sign Out", role: .destructive) {
            Task {
                await authViewModel.signOut()
            }
        }
        .buttonStyle(.bordered)
        .tint(.red)
    }
}

#Preview {
    @Previewable @State var authViewModel: AuthenticationViewModel = .init()
    MainView(authViewModel: authViewModel)
}
