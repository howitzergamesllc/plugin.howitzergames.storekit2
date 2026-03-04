//
//  Currency.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/30/25.
//

import Foundation

// MARK: - Currency Wrapper

@objc(CurrencyWrapper) // This exposes the Swift class as a usable Objective-C class
//@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
public final class CurrencyWrapper: NSObject {

    // The Swift value that we are wrapping
    public let swiftValue: Any?
    
    // Initializer to initialize with a Swift Locale.Currency value
    public init?(swiftValue: Any?) {
        guard let value = swiftValue else { return nil }
        self.swiftValue = value
    }
    
    /// Returns the ISO 4217 code (like "USD"), or empty string if unavailable
    @objc public func currencyCode() -> String {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *),
           let currency = swiftValue as? Locale.Currency {
            return currency.identifier
        } else {
            return ""
        }
    }

    // Determines if the currency is within the list of ISO defined currecies
    @objc public func isISOCurrency() -> Bool {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *),
           let currency = swiftValue as? Locale.Currency {
            return currency.isISOCurrency
        } else {
            return false
        }
    }
    
    // Optionally, you can add additional methods or properties to compare currencies, etc.
    @objc public func isEqualToCurrency(_ other: CurrencyWrapper?) -> Bool {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *),
           let value1 = swiftValue as? Locale.Currency,
           let value2 = other?.swiftValue as? Locale.Currency {
            return value1.identifier == value2.identifier
        } else {
            return false
        }
    }
}
