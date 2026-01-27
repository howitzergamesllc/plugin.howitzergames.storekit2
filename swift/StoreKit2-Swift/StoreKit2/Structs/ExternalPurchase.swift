//
//  ExternalPurchaseManager.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(ExternalPurchase)
@available(iOS 15.4, macOS 14.4, tvOS 17.4, *)
public final class ExternalPurchaseWrapper: NSObject {
    
    public typealias BoolCompletion = (Bool) -> Void
    @objc public static func canPresentAsync(completion: @escaping BoolCompletion) {
        if #available(iOS 17.4, macOS 14.4, tvOS 17.4, watchOS 10.4, visionOS 1.1, *) {
            Task {
                let result = await ExternalPurchase.canPresent
                completion(result)
            }
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }

    
    @objc public static func presentNoticeSheetAsync(completion: @escaping (ExternalPurchaseNoticeResultWrapper?, NSError?) -> Void) {
        Task {
            do {
                let result = try await ExternalPurchase.presentNoticeSheet()
                completion(ExternalPurchaseNoticeResultWrapper(swiftResult: result), nil)
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
