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
            try SwiftLuhn.performLuhnAlgorithm(self)
            return true
        }
        catch {
            return false
        }
    }
    
    public func cardType() -> SwiftLuhn.CardType? {
        let cardType = try? SwiftLuhn.cardType(self)
        return cardType
    }
}