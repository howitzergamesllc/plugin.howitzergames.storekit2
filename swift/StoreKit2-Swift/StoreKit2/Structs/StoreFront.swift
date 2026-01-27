//
//  StoreFrontManager.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/17/25.
//

import Foundation
import UIKit
import StoreKit

@objc(StoreFront)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class StoreFrontWrapper: NSObject {

    /// The underlying StoreKit Storefront instance (Swift-only)
    private let underlying: Storefront

    /// Three-letter ISO country code (e.g. "USA", "CAN")
    @objc public let countryCode: String

    /// Unique Apple storefront ID (string)
    @objc public let identifier: String
    
    @objc
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
    public var currency: CurrencyWrapper? {
        guard let swiftCurrency = Locale.current.currency else {
            return nil // Return nil if there's no currency (fallback to USD or other default)
        }
        return CurrencyWrapper(swiftValue: swiftCurrency)
    }
    
    /// ISO 3-letter currency code (e.g. "USD", "EUR")
    ///
    /// Only available on iOS 17+, macOS 14+, etc.
    @objc public let currencyCode: String?

    public init(_ storefront: Storefront) {
        self.underlying = storefront
        self.countryCode = storefront.countryCode
        self.identifier = storefront.id

        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, *) {
            self.currencyCode = storefront.currency?.identifier
        } else {
            self.currencyCode = nil
        }

        super.init()
    }

    /// Returns the current storefront asynchronously.
    ///
    /// Obj-C/C# signature:
    /// `+ (void)currentWithCompletion:(void (^)(StoreKitStoreFront * _Nullable))completion;`
    @objc public static func currentAsync(withCompletion completion: @escaping (StoreFrontWrapper?) -> Void) {
        Task {
            let sf = await Storefront.current
            completion(sf.map { StoreFrontWrapper($0) })
        }
    }
    
    @objc public static func observeUpdatesAsync(
        updateHandler: @escaping (StoreFrontWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            for await storefront in Storefront.updates {
                let wrapped = StoreFrontWrapper(storefront)
                updateHandler(wrapped)
            }
            completion()
        }
    }
}
