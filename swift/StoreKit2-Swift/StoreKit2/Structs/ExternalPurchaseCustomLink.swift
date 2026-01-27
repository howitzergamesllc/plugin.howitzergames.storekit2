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
@available(iOS 18.1, macOS 15.1, tvOS 18.1, *)
public final class ExternalPurchaseCustomLinkWrapper: NSObject {

    // MARK: - API
    public typealias BoolCompletion = (Bool) -> Void
    /// Check eligibility for external purchase links
    @objc public static func isEligibleAsync(completion: @escaping BoolCompletion) {
        Task {
            let eligible = await ExternalPurchaseCustomLink.isEligible
            completion(eligible)
        }
    }

    /// Show notice to user
    @objc public static func showNoticeAsync(
        type: ExternalPurchaseCustomLinkNoticeTypeWrapper,
        completion: @escaping (ExternalPurchaseCustomLinkNoticeResultWrapper?, NSError?) -> Void
    ) {
        let swiftType: ExternalPurchaseCustomLink.NoticeType =
            (type.rawValue == 0) ? .withinApp : .browser

        Task {
            do {
                let result = try await ExternalPurchaseCustomLink.showNotice(type: swiftType)
                completion(ExternalPurchaseCustomLinkNoticeResultWrapper(swiftResult: result), nil)
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
                completion(nil, nserror)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }

    /// Retrieve token
    @objc public static func getTokenAsync(
        for tokenType: String,
        completion: @escaping (ExternalPurchaseCustomLinkTokenWrapper?, NSError?) -> Void
    ) {
        Task {
            do {
                if let tok = try await ExternalPurchaseCustomLink.token(for: tokenType) {
                    completion(ExternalPurchaseCustomLinkTokenWrapper(swiftToken: tok), nil)
                } else {
                    completion(nil, nil)
                }
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
                completion(nil, nserror)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
}
