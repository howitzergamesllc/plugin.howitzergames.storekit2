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
@available(iOS 16.0, tvOS 16.4, *)
@available(macOS, unavailable)
public final class ExternalLinkAccountWrapper: NSObject {
    
    /// Check if the external link account can be opened.
    public typealias BoolCompletion = (Bool) -> Void
    @objc public static func canOpenAsync(completion: @escaping BoolCompletion) {
        Task {
            let result = await ExternalLinkAccount.canOpen
            completion(result)
        }
    }

    /// Open the external link account in the user's default browser.
    @objc public static func openAsync(completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                try await ExternalLinkAccount.open()
                completion(nil)
            } catch let error as StoreKitError {
                let wrappederror = StoreKitErrorWrapper(swiftError: error)
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
                completion(nserror)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }
}
