//
//  MessageKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/18/25.
//

import Foundation
import UIKit
import StoreKit

@objc(MessageReason)
@available(iOS 16.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public final class MessageReasonWrapper: NSObject {

    // MARK: - Raw value
    @objc public let rawValue: Int

    // MARK: - Init
    @objc public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    // Swift-to-ObjC bridging initializer
    public convenience init(swiftReason: Message.Reason) {
        self.init(rawValue: swiftReason.rawValue)
    }

    // MARK: - Static instances
    @objc public static var generic: MessageReasonWrapper {
        MessageReasonWrapper(swiftReason: .generic)
    }

    @objc public static var priceIncreaseConsent: MessageReasonWrapper {
        MessageReasonWrapper(swiftReason: .priceIncreaseConsent)
    }

    @available(iOS 16.4, *)
    @objc public static var billingIssue: MessageReasonWrapper {
        MessageReasonWrapper(swiftReason: .billingIssue)
    }

    @available(iOS 18.0, *)
    @objc public static var winBackOffer: MessageReasonWrapper {
        MessageReasonWrapper(swiftReason: .winBackOffer)
    }
    
    @objc public func isEqualToReason(_ other: MessageReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
    
    // MARK: - Localized description
    @objc public var localizedDescription: String {
        let reason = Message.Reason(rawValue: rawValue) as Message.Reason?
        return reason?.localizedDescription ?? "Unknown"
    }
}
