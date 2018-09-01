//
//  CardTypeTest.swift
//  SwiftLuhn_Tests
//
//  Created by Max Kramer on 01/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import SwiftLuhn

class CardTypeTest: XCTestCase {
    func testStringValueShouldReturnCorrectValue() {
        let mapping = [
            SwiftLuhn.CardType.amex: "American Express",
            SwiftLuhn.CardType.visa: "Visa",
            SwiftLuhn.CardType.mastercard: "Mastercard",
            SwiftLuhn.CardType.discover: "Discover",
            SwiftLuhn.CardType.dinersClub: "Diner's Club",
            SwiftLuhn.CardType.jcb: "JCB",
            SwiftLuhn.CardType.maestro: "Maestro",
            SwiftLuhn.CardType.rupay: "Rupay",
            SwiftLuhn.CardType.mir: "Mir"
        ]
        
        mapping.forEach { key, value in
            let result = key.stringValue()
            XCTAssertEqual(result, value)
        }
    }
    
}
