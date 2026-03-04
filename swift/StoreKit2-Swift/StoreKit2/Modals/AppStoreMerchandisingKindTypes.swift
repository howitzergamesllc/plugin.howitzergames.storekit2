//
//  AppStoreMerchandisingKindTypes.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/18/25.
//

import Foundation
import UIKit
import StoreKit

@objc(AppStoreMerchandisingKindPresentationResult)
//@available(iOS 26.0, tvOS 26.0, *)@available(macOS, unavailable)
public class AppStoreMerchandisingKindPresentationResultWrapper: NSObject {

    /// The underlying Swift PresentationResult (internal use)
    private let underlying: Any?

    /// Whether the presentation was dismissed
    @objc public let isDismissed: Bool

    /// The associated purchase result if available
    @objc public let purchaseResult: ProductPurchaseResultWrapper?

    // MARK: - Initializer
    public init(underlying result: Any?) {
        self.underlying = result

        if #available(iOS 26.0, tvOS 26.0, *),
           let result = result as? AppStoreMerchandisingKind.PresentationResult {
            
            // iOS 26+ logic
            switch result {
            case .dismissed:
                self.isDismissed = true
                self.purchaseResult = nil
            case .purchaseCompleted(let purchaseResult):
                self.isDismissed = false
                self.purchaseResult = ProductPurchaseResultWrapper(purchaseResult)
            @unknown default:
                self.isDismissed = true
                self.purchaseResult = nil
            }
        } else {
            // Older OSes or unsupported types
            self.isDismissed = true
            self.purchaseResult = nil
        }

        super.init()
    }
    
    public var swiftValue: Any? {
        return underlying
    }
}
