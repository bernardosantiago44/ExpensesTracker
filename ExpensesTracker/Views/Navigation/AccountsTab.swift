//
//  AccountsTab.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 31/10/24.
//

import SwiftUI

struct AccountsTab: View {
    @State private var viewModel = AccountsViewModel()
    @StateObject var sheetCoordinator = SheetCoordinator<AccountSheet>()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                AccountsHeaderList(viewModel: self.viewModel, sheetCoordinator: sheetCoordinator)
                    .fontDesign(.rounded)
                    .navigationTitle("accounts")
            }
            .task {
                await viewModel.getUserAccounts()
            }
            .alert(isPresented: .constant(viewModel.operationError != nil), error: viewModel.operationError, actions: {
                Button("OK", role: .cancel) {
                    viewModel.dismissError()
                }
            })
            .sheetCoordinator(self.sheetCoordinator)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountsTab()
}
