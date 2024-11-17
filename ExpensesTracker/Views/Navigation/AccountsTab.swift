//
//  AccountsTab.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 31/10/24.
//

import SwiftUI

struct AccountsTab: View {
    @State private var viewModel = AccountsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                AccountsHeaderList(accounts: $viewModel.accounts)
                    .fontDesign(.rounded)
                    .navigationTitle("accounts")
            }
            .task {
                await viewModel.getUserAccounts()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountsTab()
}
