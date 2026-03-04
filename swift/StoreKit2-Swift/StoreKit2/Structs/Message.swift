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
//@available(iOS 16.0, *)@available(macOS, unavailable)@available(tvOS, unavailable)
public final class MessageWrapper: NSObject {

    private let swiftMessage: Any?
    
    @objc public let reason: MessageReasonWrapper?

    public init(swiftMessage: Any?) {
        if #available(iOS 16.0, *),
           let message = swiftMessage as? Message {
            self.swiftMessage = message
            self.reason = MessageReasonWrapper(swiftReason: message.reason)
        } else {
            // Unsupported OS: fallback
            self.swiftMessage = nil
            self.reason = nil
        }
        super.init()
    }
    
    @MainActor
    @objc
    public func displayIn(_ scene: UIWindowScene, error: NSErrorPointer) -> Bool {
        if #available(iOS 16.0, *) {
            guard let message = swiftMessage as? Message else {
                error?.pointee = NSError(domain: "plugin.howitzergames.storekit2",
                                         code: -1,
                                         userInfo: [NSLocalizedDescriptionKey: "Message not available"])
                return false
            }

            do {
                try message.display(in: scene)
                return true
            } catch let skerror as StoreKitError {
                let wrappederror = StoreKitErrorWrapper(swiftError: skerror)
                let nserror = NSError(domain: "plugin.howitzergames.storekit2",
                                      code: wrappederror.code.rawValue,
                                      userInfo: [
                                        NSLocalizedDescriptionKey: "StoreKitError",
                                        "ErrorCase": String(describing: wrappederror.code),
                                        "ErrorCode": wrappederror.code,
                                        "ErrorReason": String(describing: wrappederror.failureReason),
                                        "RecoverySuggestion": String(describing: wrappederror.recoverySuggestion),
                                        "IsVerified": false
                                      ])
                error?.pointee = nserror
                return false
            } catch let nsErr as NSError {
                error?.pointee = nsErr
                return false
            }

        } else {
            // iOS <16: not available
            error?.pointee = NSError(domain: "plugin.howitzergames.storekit2",
                                     code: -1,
                                     userInfo: [NSLocalizedDescriptionKey: "Message not available on this OS"])
            return false
        }
    }
    
    @MainActor
    @objc
    public static func getMessages(completion: @escaping ([MessageWrapper]?, NSError?) -> Void) {
        if #available(iOS 16.0, *) {
            Task {
                var collected: [MessageWrapper] = []
                for await message in StoreKit.Message.messages {
                    collected.append(MessageWrapper(swiftMessage: message))
                }
                completion(collected, nil)
            }
        } else {
            let nsError = NSError(
                domain: "plugin.howitzergames.storekit2",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Messages API not available on this OS version."]
            )
            completion(nil, nsError)
        }
    }
}
