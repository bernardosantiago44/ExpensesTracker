//
//  Account.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 01/11/24.
//

import Foundation

struct Account: Identifiable, Codable {
    let id: Int
    var editedAt: Date
    let userId: UUID
    var accountName: String
    var description: String?
    var startBalance: Double
    var accountLimit: Double?
    var accountType: AccountType
    
    enum CodingKeys: String, CodingKey {
        case id          = "id"
        case editedAt    = "edited_at"
        case userId      = "user_id"
        case accountName = "account_name"
        case description = "description"
        case startBalance = "start_balance"
        case accountLimit = "account_limit"
        case accountType  = "account_type"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        
        // Edited at timestamp
        let timestampString = try container.decode(String.self, forKey: .editedAt).trimmingCharacters(in: .whitespaces)
        let dateFormatter = ISO8601DateFormatter.SupabaseDateFormatter
        guard let date = dateFormatter.date(from: timestampString) else {
            throw DecodingError.dataCorruptedError(forKey: .editedAt, in: container, debugDescription: "Invalid date string.")
        }
        self.editedAt = date
        
        // User UUID
        let uuidString = try container.decode(String.self, forKey: .userId)
        guard let uuid = UUID(uuidString: uuidString) else {
            throw DecodingError.dataCorruptedError(forKey: .userId, in: container, debugDescription: "Invalid UUID string.")
        }
        self.userId = uuid
        
        self.accountName = try container.decode(String.self, forKey: .accountName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.startBalance = try container.decode(Double.self, forKey: .startBalance)
        self.accountLimit = try? container.decodeIfPresent(Double.self, forKey: .accountLimit)
        let type = try container.decode(String.self, forKey: .accountType)
        self.accountType = AccountType(rawValue: type) ?? .cash
    }
    init(id: Int, editedAt: Date, userId: UUID, accountName: String, description: String, startBalance: Double, accountLimit: Double?, accountType: AccountType) {
        self.id = id
        self.editedAt = editedAt
        self.userId = userId
        self.accountName = accountName
        self.description = description
        self.startBalance = startBalance
        self.accountLimit = accountLimit
        self.accountType = accountType
    }
    
    init(userId: UUID) {
        self.init(id: .random(in: 0...10000), editedAt: .now, userId: userId, accountName: "", description: "", startBalance: 0.0, accountLimit: nil, accountType: .cash)
    }
    
    // Property methods
    func isValid() -> Bool {
        return accountName.tidy().isEmpty == false
    }
}

extension Account: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension Account {
    static let sampleCashAccount: Account = {
        Account(id: 32,
                editedAt: Date(timeIntervalSince1970: 1730490527),
                userId: .init(),
                accountName: "Cash Account",
                description: "A sample cash account, suitable for testing",
                startBalance: 17258,
                accountLimit: nil,
                accountType: .cash)
    }()
    
    static let secondCashAccount: Account = {
        Account(id: 31,
                editedAt: Date(timeIntervalSince1970: 1730490527),
                userId: .init(),
                accountName: "Cash Account 2",
                description: "A sample cash account, suitable for testing",
                startBalance: 17258,
                accountLimit: nil,
                accountType: .cash)
    }()
    
    static let sampleCreditCardAccount: Account = {
        Account(id: 33,
                editedAt: Date(timeIntervalSince1970: 1730450527),
                userId: .init(),
                accountName: "Credit Card Account",
                description: "A sample credit card account, suitable for testing",
                startBalance: 9511,
                accountLimit: 50000,
                accountType: .creditCard)
    }()
    
    static let sampleSavingsAccount: Account = {
        Account(id: 34,
                editedAt: Date(timeIntervalSince1970: 1730490527),
                userId: .init(),
                accountName: "Savings Account",
                description: "A sample savings account, suitable for testing",
                startBalance: 10000,
                accountLimit: nil,
                accountType: .goals
        )
    }()
    
    static let sampleLoanAccount: Account = {
        Account(id: 35,
                editedAt: Date(timeIntervalSince1970: 1730490527),
                userId: .init(),
                accountName: "Loan Account",
                description: "A sample loan account, suitable for testing",
                startBalance: 10000,
                accountLimit: nil,
                accountType: .loan)
    }()
    
    static let sampleInvestment: Account = {
        Account(id: 36,
                editedAt: Date(timeIntervalSince1970: 1730350527),
                userId: .init(),
                accountName: "Investments Account",
                description: "A sample investments account, suitable for testing",
                startBalance: 10000,
                accountLimit: nil,
                accountType: .investment)
    }()
    
    static let otherCreditCard: Account = {
       Account(id: 37,
                editedAt: Date(timeIntervalSince1970: 1730490527),
                userId: .init(),
                accountName: "Other Credit Card",
                description: "A sample credit card account, suitable for testing",
                startBalance: 10000,
                accountLimit: nil,
                accountType: .creditCard)
    }()
    
}
