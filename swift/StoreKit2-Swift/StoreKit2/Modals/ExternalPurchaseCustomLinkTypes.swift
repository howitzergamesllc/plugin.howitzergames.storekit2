//
//  ExternalPurchaseCustomLinkKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/18/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - ExternalPurchaseCustomLinkNoticeResultWrapper
@objc(ExternalPurchaseCustomLinkNoticeResult)
//@available(iOS 18.1, macOS 15.1, tvOS 18.1, *)
public final class ExternalPurchaseCustomLinkNoticeResultWrapper: NSObject {

    @objc public let isCancelled: Bool

    public init?(swiftResult: Any?) {
        if #available(iOS 18.1, tvOS 18.1, macOS 15.1, *),
           let result = swiftResult as? ExternalPurchaseCustomLink.NoticeResult {
            switch result {
            case .cancelled: self.isCancelled = true
            case .continued: self.isCancelled = false
            @unknown default: self.isCancelled = true
            }
        } else {
            self.isCancelled = true
        }
        super.init()
    }
}

// MARK: - ExternalPurchaseCustomLinkNoticeTypeWrapper
@objc(ExternalPurchaseCustomLinkNoticeType)
public enum ExternalPurchaseCustomLinkNoticeTypeWrapper: Int {
    case withinApp = 0
    case browser = 1
}

// MARK: - ExternalPurchaseCustomLinkTokenWrapper
@objc(ExternalPurchaseCustomLinkToken)
//@available(iOS 18.1, macOS 15.1, tvOS 18.1, *)
public final class ExternalPurchaseCustomLinkTokenWrapper: NSObject {

    @objc public let value: String

    public init?(swiftToken: Any?) {
        if #available(iOS 18.1, tvOS 18.1, macOS 15.1, *),
           let token = swiftToken as? ExternalPurchaseCustomLink.Token {
            self.value = token.value
        } else {
            self.value = ""
        }
        super.init()
    }
}
