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
    
    var isValidFormat: Bool {
        return !newAccount.accountName.isValidName()
    
    }
    
    init(viewModel: AccountsViewModel, userId: UUID) {
        self.viewModel = viewModel
        self.newAccount = Account(userId: userId)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("account_name", text: $newAccount.accountName)
                    .textFieldStyle(RoundedTextFieldStyle(headerText: "account_name"))
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                CurrencyEntry(placeholder: "account_balance")
                
                AccountTypeEntry(placeholder: "account_type")
            }
            .navigationTitle("new_account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                CreateButton
            }
        }
    }
    
    private var CreateButton: some View {
        Group {
            if self.viewModel.isBusy {
                ProgressView("loading")
            } else {
                Button {
                    Task {
                        await self.viewModel.createAccount(self.newAccount)
                        dismiss()
                    }
                } label: {
                    Text("create_account")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryRoundedButtonStyle(color: .accentColor))
                .padding()
                .disabled(!self.newAccount.isValid())
            }
        }
    }
    
    @ViewBuilder
    private func CurrencyEntry(placeholder: LocalizedStringResource) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.subheadline)
                .foregroundColor(.secondary)
            CurrencyTextField("account_balance", value: $newAccount.startBalance)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                )
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func AccountTypeEntry(placeholder: LocalizedStringResource) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Picker("account_type", selection: $newAccount.accountType) {
                ForEach(AccountType.allCases, id: \.rawValue) { type in
                    Text(LocalizedStringResource(stringLiteral: type.rawValue))
                        .tag(type)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var viewModel = AccountsViewModel()
    NewAccountForm(viewModel: viewModel, userId: UUID())
}
