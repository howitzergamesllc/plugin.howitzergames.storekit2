//
//  PurchaseIntent.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/19/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - PurchaseIntentWrapper
@objc(PurchaseIntent)
@available(iOS 16.4, macOS 14.4, *)
@available(tvOS, unavailable)
public final class PurchaseIntentWrapper: NSObject {

    /// Wrapped product
    @objc public let product: ProductWrapper

    /// Wrapped subscription offer (if present)
    @objc public let offer: ProductSubscriptionOfferWrapper?

    /// Identifier of the purchase intent
    @objc public let identifier: NSString

    /// The underlying Swift PurchaseIntent (kept private)
    private let swiftValue: PurchaseIntent

    public init(swiftValue: PurchaseIntent) {
        self.swiftValue = swiftValue
        self.product = ProductWrapper(product: swiftValue.product)

        if #available(iOS 18.0, macOS 15.0, *) {
            if let offer = swiftValue.offer {
                self.offer = ProductSubscriptionOfferWrapper(swiftValue: offer)
            } else {
                self.offer = nil
            }
        } else {
            self.offer = nil
        }

        self.identifier = swiftValue.id as NSString

        super.init()
    }
    
    @objc
    public static func observeIntentsAsync(
        intentHandler: @escaping (PurchaseIntentWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            // Iterate the AsyncSequence
            for await intent in PurchaseIntent.intents {
                let wrapped = PurchaseIntentWrapper(swiftValue: intent)
                intentHandler(wrapped)
            }

            // Only reached if the sequence ever ends (unlikely)
            completion()
        }
    }
}
