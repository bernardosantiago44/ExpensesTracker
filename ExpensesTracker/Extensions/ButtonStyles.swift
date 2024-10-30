//
//  ButtonStyles.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 29/10/24.
//

import SwiftUI

struct PrimaryRoundedButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(self.color)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}
