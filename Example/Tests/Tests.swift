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
        
        let plistPath = NSBundle(forClass: self.dynamicType).pathForResource(CardNumbersFileName, ofType: "plist")
        XCTAssertNotNil(plistPath) // throw an assertion rather than using guard
        
        let plistData = NSData(contentsOfFile: plistPath!)
        XCTAssertNotNil(plistData)
        
        let plist = try? NSPropertyListSerialization.propertyListWithData(plistData!, options: .Immutable, format: nil) as! [String: AnyObject]
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
