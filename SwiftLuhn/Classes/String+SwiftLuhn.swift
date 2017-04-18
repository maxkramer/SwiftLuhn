//
//  String+SwiftLuhn.swift
//  Example Project
//
//  Created by Max Kramer on 29/03/2016.
//  Copyright © 2016 Max Kramer. All rights reserved.
//

import Foundation

public extension String {
    public func isValidCardNumber() -> Bool {
        do {
            try SwiftLuhn.performLuhnAlgorithm(with: self)
            return true
        }
        catch {
            return false
        }
    }
    
    public func cardType() -> SwiftLuhn.CardType? {
        let cardType = try? SwiftLuhn.cardType(for: self)
        return cardType
    }
    public func suggestedCardType() -> SwiftLuhn.CardType? {
        let cardType = try? SwiftLuhn.cardType(for: self, suggest: true)
        return cardType
    }
    
    public func formattedCardNumber() -> String {
        let numbersOnlyEquivalent = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        return numbersOnlyEquivalent.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
