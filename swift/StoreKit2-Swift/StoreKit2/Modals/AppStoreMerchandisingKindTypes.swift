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
@available(iOS 26.0, tvOS 26.0, *)
@available(macOS, unavailable)
public class AppStoreMerchandisingKindPresentationResultWrapper: NSObject {

    /// The underlying Swift PresentationResult (internal use)
    private let underlying: AppStoreMerchandisingKind.PresentationResult

    /// Whether the presentation was dismissed
    @objc public let isDismissed: Bool

    /// The associated purchase result if available
    @objc public let purchaseResult: ProductPurchaseResultWrapper?

    // MARK: - Initializer
    init(underlying result: AppStoreMerchandisingKind.PresentationResult) {
        self.underlying = result

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
        
        super.init()
    }
}
