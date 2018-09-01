import UIKit
import XCTest
import SwiftLuhn

let CardNumbersFileName = "TestCreditCardNumbers"

class Tests: XCTestCase {
    
    struct Card {
        let number: String
        let type: String
    }
    
    var validCards: [Card]!
    var invalidCards: [Card]!
    
    override func setUp() {
        super.setUp()
        
        let plistPath = Bundle(for: type(of: self)).path(forResource: CardNumbersFileName, ofType: "plist")
        XCTAssertNotNil(plistPath) // throw an assertion rather than using guard
        
        let plistData = try? Data(contentsOf: URL(fileURLWithPath: plistPath!))
        XCTAssertNotNil(plistData)
        
        let plist = try? PropertyListSerialization.propertyList(from: plistData!, options: PropertyListSerialization.MutabilityOptions(), format: nil) as! [String: AnyObject]
        XCTAssertNotNil(plist)
        
        let validCardNumbers = plist!["valid"] as! [[String: String]]
        validCards = validCardNumbers.map {
            return Card(number: $0["number"]!, type: $0["type"]!)
        }
        
        let invalidCardNumbers = plist!["invalid"] as! [String]
        invalidCards = invalidCardNumbers.map {
            return Card(number: $0, type: "Invalid")
        }
    }
    
    func testFormattedCardNumber() {
        // should only be numbers 0-9
        // no white space or new lines
        
        func containsOnlyLettersAndNumbers(_ cardNumber: String) -> Bool {
            let numbersRegex = "[0-9]"
            let replacedNumbers = cardNumber.replacingOccurrences(of: numbersRegex, with: "", options: .regularExpression, range: nil)
            
            return replacedNumbers.count == 0
        }
        
        func containsNoWhitespaceOrNewlines(_ cardNumber: String) -> Bool {
            let withProhibitedContents = " \n  \n " + cardNumber + " \n  \n "
            let formattedContents = withProhibitedContents.formattedCardNumber()
            
            return formattedContents.count == cardNumber.count
        }
        
        let incorrectlyFormattedNumbers = [
            "378-28-22-46-31-00-05",
            "\n371-449635398431\n",
            "37ajf8f7df3d f44eeee936..a>71000",
            "-\n-3787344 Tcx)_936710<@00",
            "<-\n 3056 93 09025904->"
        ]
        
        incorrectlyFormattedNumbers.forEach {
            let formattedEquivalent = $0.formattedCardNumber()
            XCTAssertTrue(containsOnlyLettersAndNumbers(formattedEquivalent))
            XCTAssertTrue(containsNoWhitespaceOrNewlines(formattedEquivalent))
            XCTAssertTrue(formattedEquivalent.isValidCardNumber())
        }
    }
    
    func testValidCardNumbersAreValid() {
        validCards.forEach {
            XCTAssertTrue($0.number.isValidCardNumber())
            XCTAssertEqual($0.number.cardType(), SwiftLuhn.CardType(string: $0.type))
        }
    }
    
    func testInvalidCardsAreInvalid() {
        invalidCards.forEach {
            XCTAssertFalse($0.number.isValidCardNumber())
        }
    }
}
