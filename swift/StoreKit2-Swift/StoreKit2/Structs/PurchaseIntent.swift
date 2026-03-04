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
//@available(iOS 16.4, macOS 14.4, *)@available(tvOS, unavailable)
public final class PurchaseIntentWrapper: NSObject {

    @objc public let product: ProductWrapper?
    @objc public let offer: ProductSubscriptionOfferWrapper?
    @objc public let identifier: NSString

    /// The underlying Swift PurchaseIntent (kept private)
    private let swiftValue: Any?

    public init?(swiftValue: Any?) {
        self.swiftValue = swiftValue

        if #available(iOS 16.4, macOS 14.4, *) {
            // Only attempt the cast on supported OS
            if let intent = swiftValue as? PurchaseIntent {
                self.product = ProductWrapper(product: intent.product)

                if #available(iOS 18.0, macOS 15.0, *) {
                    if let offer = intent.offer {
                        self.offer = ProductSubscriptionOfferWrapper(swiftValue: offer)
                    } else {
                        self.offer = nil
                    }
                } else {
                    self.offer = nil
                }

                self.identifier = intent.id as NSString
            } else {
                self.product = nil
                self.offer = nil
                self.identifier = "" as NSString
            }
        } else {
            // OS is too old, do not attempt any cast
            self.product = nil
            self.offer = nil
            self.identifier = "" as NSString
        }

        super.init()
    }
    
    @objc
    public static func observeIntentsAsync(
        intentHandler: @escaping (PurchaseIntentWrapper?) -> Void,
        completion: @escaping () -> Void
    ) {
        if #available(iOS 16.4, macOS 14.4, *) {
            Task {
                // Use optional casting to make runtime-safe
                for await rawIntent in PurchaseIntent.intents {
                    let wrapped = PurchaseIntentWrapper(swiftValue: rawIntent as Any)
                    intentHandler(wrapped)
                }
                completion()
            }
        } else {
            // Older OS versions: nothing to observe
            completion()
        }
    }
}
