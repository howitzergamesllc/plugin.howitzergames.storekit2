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
//@available(iOS 16.0)@available(macOS, unavailable)@available(tvOS, unavailable)
public final class MessageReasonWrapper: NSObject {

    @objc public let rawValue: Int

    @objc public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public convenience init?(swiftReason: Any?) {
        if #available(iOS 16.0, *) {
            // Safe to cast to Message.Reason only on iOS 16+
            if let reason = swiftReason as? Message.Reason {
                self.init(rawValue: reason.rawValue)
            } else {
                return nil
            }
        } else {
            // On older OS, return a default/fallback instance
            if let raw = swiftReason as? Int {
                self.init(rawValue: raw)
            } else {
                return nil
            }
        }
    }

    @objc public static var generic: MessageReasonWrapper {
        if #available(iOS 16.0, *) {
            return MessageReasonWrapper(swiftReason: Message.Reason.generic)!
        } else {
            return MessageReasonWrapper(rawValue: 0)
        }
    }

    @objc public static var priceIncreaseConsent: MessageReasonWrapper {
        if #available(iOS 16.0, *) {
            return MessageReasonWrapper(swiftReason: Message.Reason.priceIncreaseConsent)!
        } else {
            return MessageReasonWrapper(rawValue: 0)
        }
    }

    @objc public static var billingIssue: MessageReasonWrapper {
        if #available(iOS 16.4, *) {
            return MessageReasonWrapper(swiftReason: Message.Reason.billingIssue)!
        } else {
            return MessageReasonWrapper(rawValue: 0)
        }
    }

    @objc public static var winBackOffer: MessageReasonWrapper {
        if #available(iOS 18.0, *) {
            return MessageReasonWrapper(swiftReason: Message.Reason.winBackOffer)!
        } else {
            return MessageReasonWrapper(rawValue: 0)
        }
    }

    @objc public func isEqualToReason(_ other: MessageReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
    
    @objc public var localizedDescription: String {
        if #available(iOS 16.0, *) {
        let reason = Message.Reason(rawValue: rawValue) as Message.Reason?
        return reason?.localizedDescription ?? "Unknown"
        } else {
            return "Unsupported < iOS 16.0"
        }
    }
}
