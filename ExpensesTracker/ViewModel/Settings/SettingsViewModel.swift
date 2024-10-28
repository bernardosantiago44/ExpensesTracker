//
//  SettingsViewModel.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import Foundation
import SwiftUI

@Observable class SettingsViewModel {
    var selectedAccentColor: Color = .accentColor
}

// Color palette
extension SettingsViewModel {
    @ObservationIgnored static let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .accentColor]
}

// Environment Keys
extension EnvironmentValues {
    @Entry var settings: SettingsViewModel = .init()
}
