//
//  AccountSheets.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 16/11/24.
//

import SwiftUI

final class SheetCoordinator<Sheet: SheetEnum>: ObservableObject {
    @Published var currentSheet: Sheet?
    private var sheetStack: [Sheet] = []
    
    @MainActor
    func presentSheet(_ sheet: Sheet) {
        sheetStack.append(sheet)
        
        if sheetStack.count == 1 {
            currentSheet = sheet
        }
    }
    
    @MainActor
    func sheetDismissed() {
        sheetStack.removeFirst()
        
        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet
        }
    }
}

protocol SheetEnum: Identifiable {
    associatedtype Body: View
    
    @ViewBuilder
    func view(coordinator: SheetCoordinator<Self>) -> Body
}

internal enum AccountSheet: Identifiable, SheetEnum {
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
        case .addAccount(var viewModel, let id):
            NewAccountForm(viewModel: viewModel, userId: id)
        
        case .editAccount:
            EmptyView()
        }
    }
}

struct SheetCoordinating<Sheet: SheetEnum>: ViewModifier {
    @StateObject var coordinator: SheetCoordinator<Sheet>
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $coordinator.currentSheet, onDismiss: { coordinator.sheetDismissed() }) { sheet in
                sheet.view(coordinator: coordinator)
            }
    }
}

extension View {
    func sheetCoordinator<Sheet: SheetEnum>(_ coordinator: SheetCoordinator<Sheet>) -> some View {
        modifier(SheetCoordinating(coordinator: coordinator))
    }
}
