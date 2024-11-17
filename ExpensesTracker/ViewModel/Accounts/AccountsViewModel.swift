//
//  AccountsViewModel.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 01/11/24.
//

import Foundation

@Observable class AccountsViewModel {
    var accounts: [Account] = []
    var operationError: DatabaseError?
    
    @ObservationIgnored private var supabase = SupabaseInstance.shared.client
    
    private func fetchAccounts() async throws {
        guard let user = supabase.auth.currentUser else {
            throw DatabaseError.userAuthenticationRequired
        }
        
        let data = try await supabase
            .from("accounts")
            .select()
            .eq("user_id", value: user.id)
            .execute()
            .data
        
        let decoder = JSONDecoder()
        let _accounts: [Account] = try decoder.decode([Account].self, from: data)
        
        DispatchQueue.main.async {
            self.accounts = _accounts
        }
    }
    
    public func getUserAccounts() async {
        do {
            try await self.fetchAccounts()
        } catch {
            self.handleError(error as? DatabaseError ?? DatabaseError.unexpectedError)
        }
    }
    
    public func getUserID() -> UUID? {
        guard let user = supabase.auth.currentUser else {
            self.handleError(DatabaseError.userAuthenticationRequired)
            return nil
        }
        return user.id
    }
    
    // MARK: - Error Handling
    private func handleError(_ error: DatabaseError) {
        DispatchQueue.main.async {
            self.operationError = error
        }
    }
    
    public func dismissError() {
        self.operationError = nil
        
    }
}
