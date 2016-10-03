//
//  ObjectiveLuhn.swift
//  Example Project
//
//  Created by Max Kramer on 29/03/2016.
//  Copyright © 2016 Max Kramer. All rights reserved.
//

import Foundation

open class SwiftLuhn {
    public enum CardType: Int {
        case amex = 0
        case visa
        case mastercard
        case discover
        case dinersClub
        case jcb
    }
    
    public enum CardError: Error {
        case unsupported
        case invalid
    }
    
    fileprivate class func regularExpression(for cardType: CardType) -> String {
        switch cardType {
        case .amex:
            return "^3[47][0-9]{5,}$";
        case .dinersClub:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$";
        case .discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$";
        case .jcb:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$";
        case .mastercard:
            return "^5[1-5][0-9]{5,}$";
        case .visa:
            return "^4[0-9]{6,}$";
        }
    }
    
    class func performLuhnAlgorithm(with cardNumber: String) throws {
        
        let formattedCardNumber = cardNumber.formattedCardNumber()
        
        guard formattedCardNumber.characters.count >= 9 else {
            throw CardError.invalid
        }
        
        let originalCheckDigit = formattedCardNumber.characters.last!
        let characters = formattedCardNumber.characters.dropLast().reversed()
        
        var digitSum = 0
        
        for (idx, character) in characters.enumerated() {
            let value = Int(String(character)) ?? 0
            if idx % 2 == 0 {
                var product = value * 2
                
                if product > 9 {
                    product = product - 9
                }
                
                digitSum = digitSum + product
            }
            else {
                digitSum = digitSum + value
            }
        }
        
        digitSum = digitSum * 9
        
        let computedCheckDigit = digitSum % 10
        
        let originalCheckDigitInt = Int(String(originalCheckDigit))
        let valid = originalCheckDigitInt == computedCheckDigit
        
        if valid == false {
            throw CardError.invalid
        }
    }
    
    class func cardType(for cardNumber: String) throws -> CardType {
        var foundCardType: CardType?
        
        for i in CardType.amex.rawValue...CardType.jcb.rawValue {
            let cardType = CardType(rawValue: i)!
            let regex = regularExpression(for: cardType)
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            
            if predicate.evaluate(with: cardNumber) == true {
                foundCardType = cardType
                break
            }
        }
        
        if foundCardType == nil {
            throw CardError.invalid
        }
        
        return foundCardType!
    }
}

public extension SwiftLuhn.CardType {
    func stringValue() -> String {
        switch self {
        case .amex:
            return "American Express"
        case .visa:
            return "Visa"
        case .mastercard:
            return "Mastercard"
        case .discover:
            return "Discover"
        case .dinersClub:
            return "Diner's Club"
        case .jcb:
            return "JCB"
        }
    }
    
    init?(string: String) {
        switch string.lowercased() {
        case "american express":
            self.init(rawValue: 0)
        case "visa":
            self.init(rawValue: 1)
        case "mastercard":
            self.init(rawValue: 2)
        case "discover":
            self.init(rawValue: 3)
        case "diner's club":
            self.init(rawValue: 4)
        case "jcb":
            self.init(rawValue: 5)
        default:
            return nil
        }
    }
}
