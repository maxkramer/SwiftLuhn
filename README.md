# SwiftLuhn
[![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://swift.org)
[![CircleCI](https://circleci.com/gh/maxkramer/SwiftLuhn.svg?style=svg)](https://circleci.com/gh/maxkramer/SwiftLuhn)
[![Version](https://img.shields.io/cocoapods/v/SwiftLuhn.svg?style=flat)](http://cocoapods.org/pods/SwiftLuhn)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/SwiftLuhn.svg?style=flat)](http://cocoapods.org/pods/SwiftLuhn)
[![Platform](https://img.shields.io/cocoapods/p/SwiftLuhn.svg?style=flat)](http://cocoapods.org/pods/SwiftLuhn)

This is a port of the Luhn Algorithm, generally used for validating debit/credit card details, written in Swift.

SwiftLuhn's HEAD is written in Swift 4. If your project doesn't support Swift 4 yet, please use the [0.2.1 tag](https://github.com/MaxKramer/SwiftLuhn/releases/tag/0.2.1).

Objective-C port can be found at [https://github.com/MaxKramer/ObjectiveLuhn](https://github.com/MaxKramer/ObjectiveLuhn).

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SwiftLuhn is available through [CocoaPods](http://cocoapods.org) or Carthage (with or without using our pre-built binary). 

To install it, simply add the following line to your Podfile:

```ruby
pod "SwiftLuhn" # use '0.2.1' for Swift 3.X
```

Or alternatively the following line to your Cartfile:

```swift
github "MaxKramer/SwiftLuhn"
```

## Usage

### Validation


Call the class method which will throws an exception `SwiftLuhn.CardError` if the card is invalid.

```swift
let cardNumber = "378282246310005"
do {
    try SwiftLuhn.performLuhnAlgorithm(with: cardNumber)
    // process payment
}
catch {
    // invalid, alert user
}
```

Alternatively, you can use the `String` category:

```swift
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

```swift
do {
    let cardType = try SwiftLuhn.cardType(of: cardNumber)
}
catch {
	// card is invalid
}
```

## Unit Tests

To run the unit test suite, please open the example project and hit CMD + U.

## Sources

|Name|Website|Reason|
|:---|:------|:-----|
|Paypal|[http://www.paypalobjects.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm](http://www.paypalobjects.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm)|List of valid credit card numbers for the unit tests|

## Author

Max Kramer, max@maxkramer.co, [@maxkramer](http://twitter.com/maxkramer)

## License

SwiftLuhn is available under the MIT license. See the LICENSE file for more info.

