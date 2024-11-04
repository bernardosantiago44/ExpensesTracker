//
//  DateFormatter+Extensions.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 04/11/24.
//

import Foundation

extension ISO8601DateFormatter {
    static var SupabaseDateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }
}
