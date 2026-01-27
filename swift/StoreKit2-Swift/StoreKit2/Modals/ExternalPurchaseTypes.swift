//
//  ExternalPurchaseKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/18/25.
//

import Foundation
import UIKit
import StoreKit

@objc(ExternalPurchaseNoticeResult)
@available(iOS 15.4, macOS 14.4, tvOS 17.4, *)
public final class ExternalPurchaseNoticeResultWrapper: NSObject {

    /// True if the user cancelled the external purchase notice
    @objc public let isCancelled: Bool

    /// The external purchase token if the user chose to continue
    @objc public let externalPurchaseToken: String?

    /// Initialize from the Swift ExternalPurchase.NoticeResult
    public init(swiftResult: ExternalPurchase.NoticeResult) {
        switch swiftResult {
        case .cancelled:
            self.isCancelled = true
            self.externalPurchaseToken = nil
        case let .continuedWithExternalPurchaseToken(token):
            self.isCancelled = false
            self.externalPurchaseToken = token
        @unknown default:
            self.isCancelled = true
            self.externalPurchaseToken = nil
        }
        super.init()
    }
}
