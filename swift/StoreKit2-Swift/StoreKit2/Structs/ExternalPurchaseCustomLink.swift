//
//  ExternalPurchaseCustomLink.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(ExternalPurchaseCustomLink)
//@available(iOS 18.1, macOS 15.1, tvOS 18.1, *)
public final class ExternalPurchaseCustomLinkWrapper: NSObject {

    // MARK: - API
    public typealias BoolCompletion = (Bool) -> Void
    /// Check eligibility for external purchase links
    @objc
    public static func isEligibleAsync(completion: @escaping BoolCompletion) {
        if #available(iOS 18.1, macOS 15.1, tvOS 18.1, *) {
            Task {
                let eligible = await ExternalPurchaseCustomLink.isEligible
                completion(eligible)
            }
        } else {
            // Fallback for older OSes
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }

    @objc
    public static func showNoticeAsync(
        type: ExternalPurchaseCustomLinkNoticeTypeWrapper,
        completion: @escaping (ExternalPurchaseCustomLinkNoticeResultWrapper?, NSError?) -> Void
    ) {
        if #available(iOS 18.1, macOS 15.1, tvOS 18.1, *) {
            let swiftType: ExternalPurchaseCustomLink.NoticeType =
                (type.rawValue == 0) ? .withinApp : .browser

            Task { @MainActor in
                do {
                    let result = try await ExternalPurchaseCustomLink.showNotice(type: swiftType)
                    completion(ExternalPurchaseCustomLinkNoticeResultWrapper(swiftResult: result), nil)
                } catch let error as StoreKitError {
                    let wrappedError = StoreKitErrorWrapper(swiftError: error)
                    let nsError = NSError(domain: "maui.storekit2.apple",
                                          code: wrappedError.code.rawValue,
                                          userInfo: [
                                            NSLocalizedDescriptionKey: "StoreKitError",
                                            "ErrorCase": String(describing: wrappedError.code),
                                            "ErrorCode": wrappedError.code,
                                            "ErrorReason": String(describing: wrappedError.failureReason),
                                            "RecoverySuggestion": String(describing: wrappedError.recoverySuggestion),
                                            "IsVerified": false
                                          ])
                    completion(nil, nsError)
                } catch {
                    let nsError = NSError(domain: "maui.storekit2.apple",
                                          code: 1001,
                                          userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    completion(nil, nsError)
                }
            }
        } else {
            // Runtime fallback
            let nsError = NSError(domain: "maui.storekit2.apple",
                                  code: 1003,
                                  userInfo: [NSLocalizedDescriptionKey: "ExternalPurchaseCustomLink is not available on this OS version"])
            completion(nil, nsError)
        }
    }

    @objc
    public static func getTokenAsync(
        for tokenType: String,
        completion: @escaping (ExternalPurchaseCustomLinkTokenWrapper?, NSError?) -> Void
    ) {
        if #available(iOS 18.1, macOS 15.1, tvOS 18.1, *) {
            Task {
                do {
                    if let token = try await ExternalPurchaseCustomLink.token(for: tokenType) {
                        completion(ExternalPurchaseCustomLinkTokenWrapper(swiftToken: token), nil)
                    } else {
                        completion(nil, nil)
                    }
                } catch let error as StoreKitError {
                    let wrappedError = StoreKitErrorWrapper(swiftError: error)
                    let nsError = NSError(domain: "maui.storekit2.apple",
                                          code: wrappedError.code.rawValue,
                                          userInfo: [
                                            NSLocalizedDescriptionKey: "StoreKitError",
                                            "ErrorCase": String(describing: wrappedError.code),
                                            "ErrorCode": wrappedError.code,
                                            "ErrorReason": String(describing: wrappedError.failureReason),
                                            "RecoverySuggestion": String(describing: wrappedError.recoverySuggestion),
                                            "IsVerified": false
                                          ])
                    completion(nil, nsError)
                } catch {
                    let nsError = NSError(domain: "maui.storekit2.apple",
                                          code: 1001,
                                          userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    completion(nil, nsError)
                }
            }
        } else {
            // Runtime fallback
            let nsError = NSError(domain: "maui.storekit2.apple",
                                  code: 1003,
                                  userInfo: [NSLocalizedDescriptionKey: "ExternalPurchaseCustomLink is not available on this OS version"])
            completion(nil, nsError)
        }
    }
}
