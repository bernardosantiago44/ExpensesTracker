//
//  TextFieldStyles.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 29/10/24.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    let TextTitle: Text?
    
    init(headerText: LocalizedStringKey? = nil) {
        self.TextTitle = headerText != nil ? Text(headerText!) : nil
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let TextTitle {
                TextTitle
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            configuration
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                )
        }
    }
}
