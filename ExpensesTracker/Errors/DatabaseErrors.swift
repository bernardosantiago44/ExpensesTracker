//
//  DatabaseErrors.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 16/11/24.
//

import Foundation

public enum DatabaseError: Error {
    case unexpectedError(String)
    case userAuthenticationRequired
}

extension DatabaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unexpectedError(let errorMessage):
            return String(format: NSLocalizedString("unexpected_error: %@", comment: "Unexpected error."), errorMessage)
        case .userAuthenticationRequired:
            return NSLocalizedString("user_auth_required", comment: "User authentication is required to finish operation.")
        }
    }
}
