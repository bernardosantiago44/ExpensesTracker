//
//  AccountsViewModel.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 01/11/24.
//

import Foundation

@Observable class AccountsViewModel {
    var accounts: [Account] = []
    @ObservationIgnored private var supabase = SupabaseInstance.shared.client
    
    private func fetchAccounts() async throws {
        guard let user = supabase.auth.currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let _accounts: [Account] = try await supabase
            .from("accounts")
            .select()
            .eq("user_id", value: user.id)
            .execute()
            .value
        
        DispatchQueue.main.async {
            self.accounts = _accounts
        }
    }
    
    public func getUserAccounts() async {
        do {
            try await self.fetchAccounts()
        } catch {
            print(error.localizedDescription)
        }
    }
}
