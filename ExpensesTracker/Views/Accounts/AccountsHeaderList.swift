//
//  AccountsHeaderList.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/24.
//

import SwiftUI

struct AccountsHeaderList: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Binding var accounts: [Account]
    
    private let gridItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal) {
                #warning("Fix alignment of the grid items")
                LazyHGrid(rows: gridItems) {
                    ForEach(accounts) { account in
                        AccountCard(account: account)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    @Previewable @State var accounts = [Account.sampleCashAccount,
                                        Account.sampleCreditCardAccount,
                                        Account.sampleSavingsAccount]
    AccountsHeaderList(accounts: $accounts)
}
