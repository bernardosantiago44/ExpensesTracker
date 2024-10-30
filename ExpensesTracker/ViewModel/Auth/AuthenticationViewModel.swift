//
//  AuthenticationViewModel.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import Foundation

@MainActor
@Observable class AuthenticationViewModel {
    var username: String = ""
    var password: String = ""
    var isShowingPassword = false
    var isValid: Bool {
        username.count > 0 && password.count >= 6
    }
    
    // MARK: Data flow & async logic properties
    var isBusy = false   // Flag to show progress indicators
    var showErrorMessage = false
    var errorMessage = ""
    
    /// Authenticates the user using Supabase Auth
    ///
    private func authenticateWith(email: String, password: String) async throws {
        let response = try await SupabaseInstance.shared.client.auth.signIn(
            email: email,
            password: password)
    }
    
    /// Public func to pass the credentials to the Supabase Auth method.
    /// This function handles the errors thrown, if any, of the Supabase Authentication.
    ///
    public func login() async {
        self.isBusy = true
        defer { self.isBusy = false }
        do {
            try await self.authenticateWith(email: self.username, password: self.password)
        } catch {
            self.errorMessage = error.localizedDescription
            self.showErrorMessage = true
        }
    }
}
