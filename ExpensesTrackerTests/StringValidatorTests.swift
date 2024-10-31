//
//  StringValidatorTests.swift
//  ExpensesTrackerTests
//
//  Created by Bernardo Santiago Marin on 30/10/24.
//

import Testing
@testable import ExpensesTracker

/// Tests function validators, like email & password validation.
@Suite("String Validator Tests")
struct StringValidatorTests {
    
    let validEmailAddresses = [
        "john.doe@example.com.mx",
        "jane.smith@example.org",
        "alice.johnson@example.net",
        "bob.brown@example.co",
        "charlie.davis@example.io",
        "danielle.miller@example.com",
        "frank.wilson@example.org",
        "grace.hall@example.net",
        "henry.lee@example.co",
        "isabel.clark@example.io",
        "bernardosantiago44@gmail.com",
        "A01638915@tec.mx",
        "lisa.king@example.net",
        "michael.green@example.co",
        "nancy.adams@example.io",
        "oliver.baker@example.com",
        "paula.morris@example.org",
        "quentin.jones@example.net",
        "rachel.moore@example.co",
        "steve.turner@example.io"
    ]
    let invalidEmailAddresses = [
        "john.doeexample.com",        // Missing "@" symbol
        "jane.smith@.com",            // Missing domain name
        "@example.org",               // Missing username
        "alice.johnson@example..net", // Double dot in domain
        "bob.brown@example",          // Missing domain extension
        "charlie.davis@.io.",         // Trailing dot in domain
        "danielle.miller@-example.com", // Invalid character "-" at start of domain
        "frank wilson@example.org",   // Space in username
        "grace.hall@@example.net",    // Double "@" symbol
        "henry.lee@exam_ple.co",      // Underscore in domain
        "isabel.clark@example",       // Missing top-level domain
        "julia.scott@.example.com",   // Dot immediately after "@"
        "kevin.white@example..org",   // Double dot in domain extension
        "lisa.king@example.c",        // Single-letter domain extension
        "michael.green@.com",         // Missing domain name
        "nancy.adams@example,com",    // Comma instead of dot
        "oliver.baker@example .com",  // Space before dot in domain
        "paula.morris@example!.org",  // Invalid character "!" in domain
        "quentin.jones@example.net.", // Trailing dot after domain extension
        "rachel.moore@example..co"    // Double dot in domain
    ]
    
    @Test func testCorrectlyFormattedEmails() {
        self.validEmailAddresses.forEach { email in
            #expect(email.isValidEmailAddress() == true)
        }
    }
    
    @Test func testBadlyFormattedEmails() {
        self.invalidEmailAddresses.forEach { email in
            #expect(email.isValidEmailAddress() == false)
        }
    }
    
}
