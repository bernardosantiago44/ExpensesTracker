//
//  AccountCard.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/24.
//

import SwiftUI

struct AccountCard: View {
    @Environment(\.settings) private var settings
    let account: Account
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                Text(account.accountName)
                    .font(.footnote)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(account.startBalance, format: .currency(code: settings.currencyCode))
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    AccountCard(account: .sampleCashAccount)
}
