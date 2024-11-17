//
//  HorizontalAlignment.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 16/11/24.
//

import SwiftUI

extension HorizontalAlignment {
    private enum AccountCardWidth: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.width
        }
    }
    
    static let cardWidth = HorizontalAlignment(AccountCardWidth.self)
}
