//
//  AccountsTab.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 31/10/24.
//

import SwiftUI

struct AccountsTab: View {
    var body: some View {
        NavigationStack {
            Text("accounts")
                .fontDesign(.rounded)
                .navigationTitle("accounts")
        }
    }
}

#Preview {
    AccountsTab()
}
