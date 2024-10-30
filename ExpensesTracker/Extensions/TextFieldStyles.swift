//
//  TextFieldStyles.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 29/10/24.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color(uiColor: .secondarySystemBackground))
            )
    }
}
