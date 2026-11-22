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
//@available(iOS 15.4, macOS 14.4, tvOS 17.4, *)
public final class ExternalPurchaseWrapper: NSObject {
    
    public typealias BoolCompletion = (Bool) -> Void
    @objc
    public static func canPresentAsync(completion: @escaping BoolCompletion) {
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

    
    @objc
    public static func presentNoticeSheetAsync(completion: @escaping (ExternalPurchaseNoticeResultWrapper?, NSError?) -> Void) {
        if #available(iOS 15.4, macOS 14.4, tvOS 17.4, *) {
            Task { @MainActor in
                do {
                    let result = try await ExternalPurchase.presentNoticeSheet()
                    let wrapper = ExternalPurchaseNoticeResultWrapper(swiftResult: result)
                    DispatchQueue.main.async {
                        completion(wrapper, nil)
                    }
                } catch let error as StoreKitError {
                    let wrappedError = StoreKitErrorWrapper(swiftError: error)
                    let nsError = NSError(
                        domain: "maui.storekit2.apple",
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
                    DispatchQueue.main.async {
                        completion(nil, nsError)
                    }
                } catch {
                    let nsError = NSError(
                        domain: "maui.storekit2.apple",
                        code: 1001,
                        userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                    )
                    DispatchQueue.main.async {
                        completion(nil, nsError)
                    }
                }
            }
        } else {
            // Unsupported OS version
            let nsError = NSError(
                domain: "maui.storekit2.apple",
                code: 1003,
                userInfo: [NSLocalizedDescriptionKey: "Unsupported OS version"]
            )
            DispatchQueue.main.async {
                completion(nil, nsError)
            }
        }
    }
}
