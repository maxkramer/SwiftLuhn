# SwiftLuhn

[![CI Status](http://img.shields.io/travis/Max Kramer/SwiftLuhn.svg?style=flat)](https://travis-ci.org/Max Kramer/SwiftLuhn)
[![Version](https://img.shields.io/cocoapods/v/SwiftLuhn.svg?style=flat)](http://cocoapods.org/pods/SwiftLuhn)
[![License](https://img.shields.io/cocoapods/l/SwiftLuhn.svg?style=flat)](http://cocoapods.org/pods/SwiftLuhn)
[![Platform](https://img.shields.io/cocoapods/p/SwiftLuhn.svg?style=flat)](http://cocoapods.org/pods/SwiftLuhn)

This is a port of the Luhn Algorithm, generally used for validating Credit Card details, to Swift.

Objective-C port can be found at [https://github.com/MaxKramer/ObjectiveLuhn](https://github.com/MaxKramer/ObjectiveLuhn).

## Usage
---
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation
---
SwiftLuhn is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftLuhn"
```

## Usage
---

### Validation

    
Call the class method which will throws an exception `ObjectiveLuhn.CardError` if the card is invalid.

```
let cardNumber = "378282246310005"
do {
    try? ObjectiveLuhn.performLuhnAlgorithm(cardNumber)
    // process payment
}
catch {
    // invalid, alert user
}
```

Alternatively, you can use the `String` category:

```
let isValid = cardNumber.isValidCardNumber()
```

### Card Types

You can also get the type of the card being used which will be one of:

|Card Type|
|-------------|
|American Express|
|Visa|
|Mastercard|
|Discover|
|Diner's Club|
|JCB|

```
do {
    let cardType = ObjectiveLuhn.cardType(cardNumber)
}
catch {
	// card is invalid
}
```
## Sources
---
|Name|Website|Reason|
|:---|:------|:-----|
|Paypal|[http://www.paypalobjects.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm](http://www.paypalobjects.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm)|List of valid credit card numbers for the unit tests|

## Author
---
Max Kramer, max@maxkramer.co, @maxkramer

## License
---
SwiftLuhn is available under the MIT license. See the LICENSE file for more info.
