//
//  Auth.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 27/10/24.
//

import Foundation
import Supabase

class SupabaseInstance {
    // Prevent instantiation
    private init() {}
    
    let client = SupabaseClient(supabaseURL: SUPABASE_URL,
                              supabaseKey: SUPABASE_ANON_KEY)
}

extension SupabaseInstance {
    static let shared = SupabaseInstance()
}
