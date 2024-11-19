//
//  String+Extensions.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 30/10/24.
//

import Foundation

extension String {
    func isValidEmailAddress() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[\\w.-]+@[a-zA-Z0-9]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z]{2,4}$")
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, range: range) != nil
    }
    
    func isValidName() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .punctuationCharacters)
        
        return trimmed.isEmpty && trimmed.count < 25
    }
    
    func tidy() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
                   .folding(options: .diacriticInsensitive, locale: .current)
    }
}
