//
//  Currency.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/30/25.
//

import Foundation

// MARK: - Currency Wrapper

@objc(CurrencyWrapper) // This exposes the Swift class as a usable Objective-C class
@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
public final class CurrencyWrapper: NSObject {

    // The Swift value that we are wrapping
    public let swiftValue: Locale.Currency
    
    // Initializer to initialize with a Swift Locale.Currency value
    public init(swiftValue: Locale.Currency) {
        self.swiftValue = swiftValue
    }
    
    // Getter for the currency code (ISO 4217 code like "USD")
    @objc public func currencyCode() -> String {
        return swiftValue.identifier
    }

    // Determines if the currency is within the list of ISO defined currecies
    @objc public func isISOCurrency() -> Bool {
        return swiftValue.isISOCurrency
    }
    
    // Optionally, you can add additional methods or properties to compare currencies, etc.
    @objc public func isEqualToCurrency(_ other: CurrencyWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.swiftValue.identifier == other.swiftValue.identifier
    }
}
