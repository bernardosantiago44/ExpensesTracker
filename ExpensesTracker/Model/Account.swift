//
//  Account.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 01/11/24.
//

import Foundation

struct Account: Identifiable, Codable {
    let id: Int
    let editedAt: Date
    let userId: UUID
    let data: String
    
    enum CodingKeys: String, CodingKey {
        case id          = "id"
        case editedAt   = "edited_at"
        case userId     = "user_id"
        case data       = "data"
    }
}
