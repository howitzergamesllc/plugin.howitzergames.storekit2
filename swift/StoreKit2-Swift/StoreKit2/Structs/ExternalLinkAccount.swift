//
//  ExternalLinkAccountManager.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(ExternalLinkAccount)
//@available(iOS 16.0, tvOS 16.4, *)@available(macOS, unavailable)
public final class ExternalLinkAccountWrapper: NSObject {
    
    public typealias BoolCompletion = (Bool) -> Void
    @objc
    public static func canOpenAsync(completion: @escaping BoolCompletion) {
        if #available(iOS 16.0, tvOS 16.4, *) {
            Task {
                let result = await ExternalLinkAccount.canOpen
                completion(result)
            }
        } else {
            completion(false) // Unsupported OS version
        }
    }

    @objc
    public static func openAsync(completion: @escaping (NSError?) -> Void) {
        if #available(iOS 16.0, tvOS 16.4, *) {
            Task {
                do {
                    try await ExternalLinkAccount.open()
                    completion(nil)
                } catch let error as StoreKitError {
                    let wrappedError = StoreKitErrorWrapper(swiftError: error)
                    let nsError = NSError(
                        domain: "plugin.howitzergames.storekit2",
                        code: wrappedError.code.rawValue,
                        userInfo: [
                            NSLocalizedDescriptionKey: "StoreKitError",
                            "ErrorCase": String(describing: wrappedError.code),
                            "ErrorCode": wrappedError.code,
                            "ErrorReason": String(describing: wrappedError.failureReason),
                            "RecoverySuggestion": String(describing: wrappedError.recoverySuggestion),
                            "IsVerified": false
                        ]
                    )
                    completion(nsError)
                } catch {
                    let nsError = NSError(
                        domain: "plugin.howitzergames.storekit2",
                        code: 1001,
                        userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                    )
                    completion(nsError)
                }
            }
        } else {
            let nsError = NSError(
                domain: "plugin.howitzergames.storekit2",
                code: 1003,
                userInfo: [NSLocalizedDescriptionKey: "Unsupported OS version"]
            )
            completion(nsError)
        }
    }
}
