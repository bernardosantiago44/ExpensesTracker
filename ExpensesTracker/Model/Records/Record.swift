//
//  Record.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 20/11/24.
//

import Foundation

struct Record: Identifiable {
    let id: Int
    var createdAt: Date
    var transactionAmount: Double
    var accountId: Int
}

extension Record: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(transactionAmount)
    }
}

extension Record: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        
        // Timestamp
        let timestampString = try container.decode(String.self, forKey: .createdAt)
        let dateFormatter = ISO8601DateFormatter.SupabaseDateFormatter
        guard let date = dateFormatter.date(from: timestampString) else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Invalid date string.")
        }
        self.createdAt = date
        
        self.transactionAmount = try container.decode(Double.self, forKey: .transactionAmount)
        
        self.accountId = try container.decode(Int.self, forKey: .accountId)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case transactionAmount = "transaction_amount"
        case accountId = "account_id"
    }
}
