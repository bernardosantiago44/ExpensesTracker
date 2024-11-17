//
//  NewAccountForm.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 16/11/24.
//

import SwiftUI

struct NewAccountForm: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: AccountsViewModel
    @State private var newAccount: Account
    
    init(viewModel: AccountsViewModel, userId: UUID) {
        self.viewModel = viewModel
        self.newAccount = Account(userId: userId)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("User ID: \(newAccount.userId.uuidString)")
                    .font(.caption)
                TextField("account_name", text: $newAccount.accountName)
                    .textFieldStyle(RoundedTextFieldStyle())
                    .padding(.horizontal)
                
                Button("dismiss") {
                    dismiss()
                }
            }
            .navigationTitle("new_account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = AccountsViewModel()
    NewAccountForm(viewModel: viewModel, userId: UUID())
}
