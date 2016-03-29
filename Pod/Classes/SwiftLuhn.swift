//
//  ObjectiveLuhn.swift
//  Example Project
//
//  Created by Max Kramer on 29/03/2016.
//  Copyright © 2016 Max Kramer. All rights reserved.
//

import Foundation

public class SwiftLuhn {
    public enum CardType: Int {
        case Amex = 0
        case Visa
        case Mastercard
        case Discover
        case DinersClub
        case JCB
    }
    
    public enum CardError: ErrorType {
        case Unsupported
        case Invalid
    }
    
    private class func regularExpression(cardType: CardType) -> String {
        switch cardType {
        case .Amex:
            return "^3[47][0-9]{5,}$";
        case .DinersClub:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$";
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$";
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$";
        case .Mastercard:
            return "^5[1-5][0-9]{5,}$";
        case .Visa:
            return "^4[0-9]{6,}$";
        }
    }
    
    class func performLuhnAlgorithm(cardNumber: String) throws {
        guard cardNumber.characters.count >= 9 else {
            throw CardError.Invalid
        }
        
        let originalCheckDigit = cardNumber.characters.last!
        let characters = cardNumber.characters.dropLast().reverse()
        
        var digitSum = 0
        
        for (idx, character) in characters.enumerate() {
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
            throw CardError.Invalid
        }
    }
    
    class func cardType(cardNumber: String) throws -> CardType {
        var foundCardType: CardType?
        
        for i in CardType.Amex.rawValue...CardType.JCB.rawValue {
            let cardType = CardType(rawValue: i)!
            let regex = regularExpression(cardType)
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            
            if predicate.evaluateWithObject(cardNumber) == true {
                foundCardType = cardType
                break
            }
        }
        
        if foundCardType == nil {
            throw CardError.Invalid
        }
        
        return foundCardType!
    }
}

public extension SwiftLuhn.CardType {
    func stringValue() -> String {
        switch self {
        case .Amex:
            return "American Express"
        case .Visa:
            return "Visa"
        case .Mastercard:
            return "Mastercard"
        case .Discover:
            return "Discover"
        case .DinersClub:
            return "Diner's Club"
        case .JCB:
            return "JCB"
        }
    }
    
    init?(string: String) {
        switch string.lowercaseString {
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
