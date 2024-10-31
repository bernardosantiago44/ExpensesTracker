//
//  SettingsTab.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 31/10/24.
//

import SwiftUI

struct SettingsTab: View {
    @Bindable var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            Button("Sign Out") {
                Task {
                    await authViewModel.signOut()
                }
            }
            .buttonStyle(.bordered)
            .tint(.red)
            .navigationTitle("settings")
        }
    }
}

#Preview {
    @Previewable @State var authViewModel: AuthenticationViewModel = .init()
    SettingsTab(authViewModel: authViewModel)
}
