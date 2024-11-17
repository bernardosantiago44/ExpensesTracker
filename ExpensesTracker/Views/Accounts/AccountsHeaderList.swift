//
//  AccountsHeaderList.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/24.
//

import SwiftUI

struct AccountsHeaderList: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Binding var accounts: [Account]
    
    private var gridItems: [GridItem] {
        if dynamicTypeSize < .xxxLarge || horizontalSizeClass == .regular {
            return [
                GridItem(.flexible(), spacing: 8),
                GridItem(.flexible(), spacing: 8)
            ]
            
        }
        return [ GridItem(.flexible()) ]
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItems, spacing: 8) {
                ForEach(accounts) { account in
                    AccountCard(account: account)
                        .frame(width: cardWidth())
                }
                CreateAccountButton
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 16, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
        .defaultScrollAnchor(.leading)
    }
    
    private func cardWidth() -> CGFloat {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        let width = window?.screen.bounds.width ?? 0
        
        if (horizontalSizeClass == .regular) {
            let columnsPerPage = dynamicTypeSize < .xxxLarge ? round(width / 250) : round(width / 350)
            return width / columnsPerPage - 16
        }
        
        if dynamicTypeSize <= .xxxLarge {
            return width / 2 - 20
        }
        return width - 32
    }
    
    private var CreateAccountButton: some View {
        Button {
            
        } label: {
            GroupBox {
                Image(systemName: "plus.circle.fill")
//                    .renderingMode(.original)
                    .font(.title3)
                Text("new_account")
                    .frame(maxWidth: .infinity)
                    .font(.caption)
            }
            .frame(width: cardWidth())
        }
    }
}

#Preview {
    @Previewable @State var accounts = [Account.sampleCashAccount,
                                        Account.secondCashAccount,
                                        Account.sampleCreditCardAccount,
                                        Account.sampleSavingsAccount,
                                        Account.sampleInvestment,
                                        Account.sampleLoanAccount,
                                        Account.otherCreditCard
    ]
    AccountsHeaderList(accounts: $accounts)
//        .environment(\.dynamicTypeSize, .medium)
}
