//
//  Auth.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 27/10/24.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
    supabaseURL: SUPABASE_URL,
    supabaseKey: SUPABASE_ANON_KEY
)
