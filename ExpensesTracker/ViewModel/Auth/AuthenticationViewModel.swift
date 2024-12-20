//
//  AuthenticationViewModel.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import Foundation
import Auth

@Observable class AuthenticationViewModel {
    var username: String = ""
    var password: String = ""
    var isShowingPassword = false
    var isValid: Bool {
        username.isValidEmailAddress() && password.count >= 6
    }
    
    // MARK: Data flow & async logic properties
    var isBusy = false   // Flag to show progress indicators
    var showErrorMessage = false
    var errorMessage = ""
    
    // MARK: - Listening for authentication changes
    var subscription: AuthStateChangeListenerRegistration?
    var user: User?
    
    init() {
        setupAuthListener()
    }
    
    deinit {
        subscription?.remove()
    }
    
    private func setupAuthListener() {
        guard subscription == nil else { return }
        Task {
            subscription = await SupabaseInstance.shared.client.auth.onAuthStateChange { [weak self] event, session in
                self?.user = session?.user
            }
        }
    }
    
    /// Authenticates the user using Supabase Auth
    ///
    private func authenticateWith(email: String, password: String) async throws {
        try await SupabaseInstance.shared.client.auth.signIn(
            email: email,
            password: password)
    }
    
    /// Creates a new user using the Supabase Auth
    /// 
    private func registerUser(email: String, password: String) async throws {
        try await SupabaseInstance.shared.client.auth.signUp(
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
            self.handleError(error: error)
        }
    }
    
    /// Public func to create a new user using the Supabase Auth,
    /// and creating its corresponding tuple into the database.
    ///
    public func register() async {
        self.isBusy = true
        defer { self.isBusy = false }
        do {
            try await registerUser(email: self.username, password: self.password)
        } catch {
            self.handleError(error: error)
        }
    }
    
    private func logUserOut() async throws {
        guard user != nil else {
            throw URLError(.userAuthenticationRequired)
        }
        
        try await SupabaseInstance.shared.client.auth.signOut()
    }
    
    /// Public func to sign the user out of the app.
    /// This function handles errors thrown, if any.
     public func signOut() async {
        self.isBusy = true
        defer { self.isBusy = false }
        do {
            try await logUserOut()
        } catch {
            self.handleError(error: error)
        }
    }
    
    // MARK: Error Handling
     public func handleError(error: Error) {
        self.errorMessage = error.localizedDescription
        self.showErrorMessage = true
    }
}
