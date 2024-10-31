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
        TabView {
            Tab("accounts", systemImage: "dollarsign") {
                AccountsTab()
            }
            
            Tab("settings", systemImage: "gear") {
                SettingsTab(authViewModel: authViewModel)
            }
        }
    }
}

#Preview {
    @Previewable @State var authViewModel: AuthenticationViewModel = .init()
    MainView(authViewModel: authViewModel)
}
