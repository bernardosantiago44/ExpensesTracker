//
//  AccountTypes.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/24.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case cash = "cash"
    case creditCard = "credit_card"
    case debitCard = "debit_card"
    case loan = "loan"
    case goals = "goals"
    case investment = "investment"
    case mortgage = "mortgage"
}
