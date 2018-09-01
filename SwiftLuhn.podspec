#
# Be sure to run `pod lib lint SwiftLuhn.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
	s.name             = 'SwiftLuhn'
	s.version          = '1.0.0'
	s.summary          = 'SwiftLuhn is a port of the Luhn algorithm, used for validating debit/credit card details.'
	s.description      = <<-DESC
	This is a port of the Luhn Algorithm, generally used for validating debit/credit card details, to Swift.

	Objective-C port can be found at [https://github.com/MaxKramer/ObjectiveLuhn](https://github.com/MaxKramer/ObjectiveLuhn).
	DESC
	s.homepage         = 'https://github.com/MaxKramer/SwiftLuhn'
	s.license          = 'MIT'
	s.author           = { 'Max Kramer' => 'max@maxkramer.co' }
	s.source           = { :git => 'https://github.com/maxkramer/SwiftLuhn.git', :tag => s.version.to_s }
	s.social_media_url = 'https://twitter.com/uint_max'
	s.platform     = :ios, '8.0'
	s.requires_arc = true
	s.source_files = 'SwiftLuhn/Classes/**/*'
	s.swift_version = '4.0'
end
