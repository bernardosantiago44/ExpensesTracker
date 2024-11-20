//
//  AccountSheet.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/24.
//

import SwiftUI

internal enum AccountSheet: SheetEnum {
    case addAccount(AccountsViewModel, UUID)
    case editAccount
    
    public var id: String {
        switch self {
        case .addAccount:
            "addAccount"
        case .editAccount:
            "editAccount"
        }
    }
    
    @ViewBuilder
    func view(coordinator: SheetCoordinator<AccountSheet>) -> some View {
        switch self {
        case .addAccount(let viewModel, let id):
            NewAccountForm(viewModel: viewModel, userId: id)
        
        case .editAccount:
            EmptyView()
        }
    }
}
