//
//  ExternalPurchaseCustomLinkKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/18/25.
//

import Foundation
import UIKit
import StoreKit

@objc(ExternalPurchaseCustomLinkNoticeResult)
@available(iOS 18.1, macOS 15.1, tvOS 18.1, *)
public final class ExternalPurchaseCustomLinkNoticeResultWrapper: NSObject {
    @objc public let isCancelled: Bool

    public init(swiftResult: ExternalPurchaseCustomLink.NoticeResult) {
        switch swiftResult {
        case .cancelled: self.isCancelled = true
        case .continued: self.isCancelled = false
        @unknown default: self.isCancelled = true
        }
        super.init()
    }
}

@objc(ExternalPurchaseCustomLinkNoticeType)
public enum ExternalPurchaseCustomLinkNoticeTypeWrapper: Int {
    case withinApp = 0
    case browser = 1
}

/*@objc
@available(iOS 18.1, macOS 15.1, tvOS 18.1, watchOS 11.1, visionOS 2.1, *)
public class ExternalPurchaseCustomLinkNoticeTypeWrapper: NSObject {
    @objc public let rawValue: Int

    @objc public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public var swiftEnum: ExternalPurchaseCustomLink.NoticeType? {
        ExternalPurchaseCustomLink.NoticeType(rawValue: rawValue)
    }

    @objc public static var withinApp: ExternalPurchaseCustomLinkNoticeTypeWrapper {
        ExternalPurchaseCustomLinkNoticeTypeWrapper(rawValue: ExternalPurchaseCustomLink.NoticeType.withinApp.rawValue)
    }

    @objc public static var browser: ExternalPurchaseCustomLinkNoticeTypeWrapper {
        ExternalPurchaseCustomLinkNoticeTypeWrapper(rawValue: ExternalPurchaseCustomLink.NoticeType.browser.rawValue)
    }
}*/

@objc(ExternalPurchaseCustomLinkToken)
@available(iOS 18.1, macOS 15.1, tvOS 18.1, *)
public final class ExternalPurchaseCustomLinkTokenWrapper: NSObject {
    @objc public let value: String

    public init(swiftToken: ExternalPurchaseCustomLink.Token) {
        self.value = swiftToken.value
        super.init()
    }
}
