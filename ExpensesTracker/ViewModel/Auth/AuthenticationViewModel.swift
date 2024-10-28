//
//  AuthenticationViewModel.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import Foundation

@Observable class AuthenticationViewModel {
    var username: String = ""
    var password: String = ""
    var isValid: Bool {
        username.count > 0 && password.count >= 6
    }
}
