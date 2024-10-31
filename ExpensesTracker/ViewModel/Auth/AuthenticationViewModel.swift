//
//  AuthenticationViewModel.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import Foundation
import Auth

@Observable class AuthenticationViewModel {
    @MainActor var username: String = ""
    @MainActor var password: String = ""
    @MainActor var isShowingPassword = false
    @MainActor var isValid: Bool {
        username.count > 0 && password.count >= 6
    }
    
    // MARK: Data flow & async logic properties
    @MainActor var isBusy = false   // Flag to show progress indicators
    @MainActor var showErrorMessage = false
    @MainActor var errorMessage = ""
    
    // MARK: - Listening for authentication changes
    var subscription: AuthStateChangeListenerRegistration?
    var user: User?
    
    init() {
        Task {
            subscription = await SupabaseInstance.shared.client.auth.onAuthStateChange { event, session in
                self.user = session?.user
            }
        }
    }
    
    deinit {
        subscription?.remove()
        print("Successfully removed subscription")
    }
    
    /// Authenticates the user using Supabase Auth
    ///
    @MainActor private func authenticateWith(email: String, password: String) async throws {
        try await SupabaseInstance.shared.client.auth.signIn(
            email: email,
            password: password)
    }
    
    /// Public func to pass the credentials to the Supabase Auth method.
    /// This function handles the errors thrown, if any, of the Supabase Authentication.
    ///
    @MainActor public func login() async {
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
