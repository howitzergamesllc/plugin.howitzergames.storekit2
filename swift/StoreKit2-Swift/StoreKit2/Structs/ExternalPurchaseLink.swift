//
//  ExternalPurchaseLink.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(ExternalPurchaseLink)
@available(iOS 15.4, macOS 14.4, tvOS 17.4, *)
public final class ExternalPurchaseLinkWrapper: NSObject {
    
    public typealias BoolCompletion = (Bool) -> Void
    @objc public static func canOpenAsync(_ completion: @escaping BoolCompletion) {
        Task {
            let result = await ExternalPurchaseLink.canOpen
            completion(result)
        }
    }

    @objc public static func openAsync(_ completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                try await ExternalPurchaseLink.open()
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }
    
    @objc public static func eligibleURLsAsync(_ completion: @escaping ([NSURL]?) -> Void) {
        if #available(iOS 17.5, macOS 14.5, tvOS 17.5, watchOS 10.5, visionOS 1.2, *) {
            Task {
                completion(await ExternalPurchaseLink.eligibleURLs?.map { $0 as NSURL })
            }
        } else {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    @objc public static func openAsync(
        _ url: NSURL,
        completion: @escaping (NSError?) -> Void
    ) {
        if #available(iOS 17.5, macOS 14.5, tvOS 17.5, watchOS 10.5, visionOS 1.2, *) {
            Task {
                do {
                    try await ExternalPurchaseLink.open(url: url as URL)
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
        } else {
            // Not available on older OS versions
            let error = NSError(
                domain: "maui.storekit2.apple",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "open(url:) is not available on this OS version."]
            )
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}
