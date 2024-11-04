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
            List(viewModel.accounts) { account in
                Text(account.description ?? "Unable to retrieve the data")
            }
            .fontDesign(.rounded)
            .navigationTitle("accounts")
            .refreshable {
                await viewModel.getUserAccounts()
            }
        }
    }
}

#Preview {
    AccountsTab()
}
