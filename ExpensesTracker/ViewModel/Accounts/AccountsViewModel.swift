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
    var isBusy = false // For network operations
    
    @ObservationIgnored private var supabase = SupabaseInstance.shared.client
    
    
    // MARK: Account loading
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
        self.isBusy = true
        defer { self.isBusy = false }
        
        do {
            try await self.fetchAccounts()
        } catch {
            self.handleError(error as? DatabaseError ?? DatabaseError.unexpectedError(error.localizedDescription))
        }
    }
    
    // MARK: - Account creation POSTing
    private func createAccountRow(_ account: Account) async throws -> HTTPURLResponse {
        guard supabase.auth.currentUser != nil else {
            throw DatabaseError.userAuthenticationRequired
        }
        
        let currency = Locale.current.currency?.identifier ?? "USD"
        let command = try await supabase
            .from("accounts")
            .insert([
                "account_name": account.accountName,
                "start_balance": account.startBalance.description,
                "currency": currency,
                "account_type": account.accountType.rawValue,
            ])
            .execute()
            
        return command.response
    }
    
    public func createAccount(_ account: Account) async {
        self.isBusy = true
        defer { self.isBusy = false }
        
        do {
            let response = try await createAccountRow(account)
            
            if response.statusCode >= 200 && response.statusCode < 300 {
                self.accounts.append(account)
            }
        } catch {
            print(error.localizedDescription)
            self.handleError(error as? DatabaseError ?? .unexpectedError(error.localizedDescription))
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
