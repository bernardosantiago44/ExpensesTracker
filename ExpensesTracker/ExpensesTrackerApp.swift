//
//  ExpensesTrackerApp.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 28/10/24.
//

import SwiftUI

@main
struct ExpensesTrackerApp: App {
    @State var authenticationViewModel: AuthenticationViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView(authenticationViewModel: self.authenticationViewModel)
        }
    }
}
