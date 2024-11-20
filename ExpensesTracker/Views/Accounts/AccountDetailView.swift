//
//  AccountDetailView.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/24.
//

import SwiftUI

struct AccountDetailView: View {
    @Binding var account: Account
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(account.startBalance.currencyFormat() ?? "no_account_balance")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                // If account has records, display them
                if (false) {
                    
                }
                // otherwise, show an empty view
                else {
                    NoRecordsMessage
                }
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            NewRecordButton
            .padding()
        }
        .navigationTitle(account.accountName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var NewRecordButton: some View {
        Button {
            
        } label: {
            Label("record", systemImage: "plus.circle.fill")
        }
        

    }
    
    private var NoRecordsMessage: some View {
        ContentUnavailableView {
            Label {
                Text("no_records")
            } icon: {
                Image(systemName: "questionmark.circle")
                    .foregroundStyle(.accent)
            }
        } description: {
            Text("no_records_description")
        }
    }
}

#Preview {
    NavigationStack {
        AccountDetailView(account: .constant(.sampleCashAccount))
    }
}
