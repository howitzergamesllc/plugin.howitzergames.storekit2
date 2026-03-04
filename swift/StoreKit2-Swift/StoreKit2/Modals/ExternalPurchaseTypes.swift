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
//@available(iOS 15.4, macOS 14.4, tvOS 17.4, *)
public final class ExternalPurchaseNoticeResultWrapper: NSObject {

    @objc public let isCancelled: Bool

    @objc public let externalPurchaseToken: String?

    public init?(swiftResult: Any?) {
        if #available(iOS 15.4, tvOS 17.4, macOS 14.4, *),
           let result = swiftResult as? ExternalPurchase.NoticeResult {
            switch result {
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
        } else {
            // Older OS or unsupported type: safe default values
            self.isCancelled = true
            self.externalPurchaseToken = nil
        }

        super.init()
    }
}
