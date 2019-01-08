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
        case maestro
        case rupay
        case mir
        case elo
        case hipercard
        case aura
    }
    
    public enum CardError: Error {
        case unsupported
        case invalid
    }
    
    fileprivate class func regularExpression(for cardType: CardType) -> String {
        switch cardType {
        case .amex:
            return "^3[47][0-9]{5,}$"
        case .dinersClub:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .jcb:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .mastercard:
            return "^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"
        case .visa:
            return "^4[0-9]{6,}$"
        case .maestro:
            return "^(5018|5020|5038|6304|6759|6761|6763)[0-9]{8,15}$"
        case .rupay:
            return "^6[0-9]{15}$"
        case .mir:
            return "^220[0-9]{13}$"
        case .elo:
            return "^(4011(78|79)|43(1274|8935)|45(1416|7393|763(1|2))|50(4175|6699|67[0-7][0-9]|9000)|50(9[0-9][0-9][0-9])|627780|63(6297|6368)|650(03([^4])|04([0-9])|05(0|1)|05([7-9])|06([0-9])|07([0-9])|08([0-9])|4([0-3][0-9]|8[5-9]|9[0-9])|5([0-9][0-9]|3[0-8])|9([0-6][0-9]|7[0-8])|7([0-2][0-9])|541|700|720|727|901)|65165([2-9])|6516([6-7][0-9])|65500([0-9])|6550([0-5][0-9])|655021|65505([6-7])|6516([8-9][0-9])|65170([0-4]))"
        case .hipercard:
            return "^(38|60)[0-9]{11,17}$"
        case .aura:
            return "^50[0-9]{14,17}$"
        }
    }
    
    fileprivate class func suggestionRegularExpression(for cardType: CardType) -> String {
        switch cardType {
        case .amex:
            return "^3[47][0-9]+$"
        case .dinersClub:
            return "^3(?:0[0-5]|[68][0-9])[0-9]+$"
        case .discover:
            return "^6(?:011|5[0-9]{2})[0-9]+$"
        case .jcb:
            return "^(?:2131|1800|35[0-9]{3})[0-9]+$"
        case .mastercard:
            return "^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"
        case .visa:
            return "^4[0-9]+$"
        case .maestro:
            return "^(5018|5020|5038|6304|6759|6761|6763)[0-9]+$"
        case .rupay:
            return "^6[0-9]+$"
        case .mir:
            return "^220[0-9]+$"
        case .elo:
            return "^(4011(78|79)|43(1274|8935)|45(1416|7393|763(1|2))|50(4175|6699|67[0-7][0-9]|9000)|50(9[0-9][0-9][0-9])|627780|63(6297|6368)|650(03([^4])|04([0-9])|05(0|1)|05([7-9])|06([0-9])|07([0-9])|08([0-9])|4([0-3][0-9]|8[5-9]|9[0-9])|5([0-9][0-9]|3[0-8])|9([0-6][0-9]|7[0-8])|7([0-2][0-9])|541|700|720|727|901)|65165([2-9])|6516([6-7][0-9])|65500([0-9])|6550([0-5][0-9])|655021|65505([6-7])|6516([8-9][0-9])|65170([0-4]))"
        case .hipercard:
            return "^(38|60)[0-9]{11,17}$"
        case .aura:
            return "^50[0-9]{14,17}$"
        }
    }
    
    public class func performLuhnAlgorithm(with cardNumber: String) throws {
        
        let formattedCardNumber = cardNumber.formattedCardNumber()
        
        guard formattedCardNumber.count >= 9 else {
            throw CardError.invalid
        }
        
        let originalCheckDigit = formattedCardNumber.last!
        let characters = formattedCardNumber.dropLast().reversed()
        
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
    
    public class func cardType(for cardNumber: String, suggest: Bool = false) throws -> CardType {
        var foundCardType: CardType?
        
        for i in CardType.amex.rawValue...CardType.jcb.rawValue {
            let cardType = CardType(rawValue: i)!
            let regex = suggest ? suggestionRegularExpression(for: cardType) : regularExpression(for: cardType)
            
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
        case .maestro:
            return "Maestro"
        case .rupay:
            return "Rupay"
        case .mir:
            return "Mir"
        case .elo:
            return "Elo"
        case .hipercard:
            return "Hipercard"
        case .aura:
            return "Aura"
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
        case "maestro":
            self.init(rawValue: 6)
        case "rupay":
            self.init(rawValue: 7)
        case "mir":
            self.init(rawValue: 8)
        case "elo":
            self.init(rawValue: 9)
        case "hipercard":
            self.init(rawValue: 10)
        case "aura":
            self.init(rawValue: 11)
        default:
            return nil
        }
    }
}
