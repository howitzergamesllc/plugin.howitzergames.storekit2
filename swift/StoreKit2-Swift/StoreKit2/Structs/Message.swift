//
//  Message.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(Message)
@available(iOS 16.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public final class MessageWrapper: NSObject {

    // MARK: - Stored Swift Message
    private let swiftMessage: Message

    // MARK: - Init
    public init(swiftMessage: Message) {
        self.swiftMessage = swiftMessage
    }

    // MARK: - Reason
    @objc public var reason: MessageReasonWrapper {
        MessageReasonWrapper(swiftReason: swiftMessage.reason)
    }

    // MARK: - Display
    /// Objective-C wrapper for Swift `display(in:)
    @MainActor
    @objc public func displayIn(_ scene: UIWindowScene,
                                error: NSErrorPointer) -> Bool {
        do {
            try swiftMessage.display(in: scene)
            return true
        } catch let skerror as StoreKitError {
            let wrappederror = StoreKitErrorWrapper(swiftError: skerror)
            let nserror = NSError(domain: "maui.storekit2.apple",
                                  code: wrappederror.code.rawValue,
                                  userInfo: [
                                    NSLocalizedDescriptionKey: "StoreKitError",
                                    "ErrorCase": String(describing: wrappederror.code),
                                    "ErrorCode": wrappederror.code,
                                    "ErrorReason": String(describing: wrappederror.failureReason),
                                    "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                                    "IsVerified": false
                                  ])
            error?.pointee = nserror
            return false
        } catch let nsErr as NSError {
            error?.pointee = nsErr
            return false
        }
    }
    
    @MainActor
    @objc public static func getMessages() async throws -> [MessageWrapper] {

        var collected: [MessageWrapper] = []

        // Iterate through the async sequence
        for await message in StoreKit.Message.messages {
            collected.append(MessageWrapper(swiftMessage: message))
        }

        return collected
    }
}
