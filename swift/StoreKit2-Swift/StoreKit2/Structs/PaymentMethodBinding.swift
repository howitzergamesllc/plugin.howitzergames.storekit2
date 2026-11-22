//
//  PaymentMethodBinding.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - PaymentMethodBindingWrapper
@objc(PaymentMethodBinding)
//@available(iOS 16.4, *)@available(macOS, unavailable)@available(tvOS, unavailable)
public final class PaymentMethodBindingWrapper: NSObject {

    private let binding: Any?

    private init(binding: Any?) {
        self.binding = binding
    }
    
    @objc public static func createAsync(
        id: String,
        completion: @escaping (PaymentMethodBindingWrapper?, NSError?) -> Void
    ) {
        if #available(iOS 16.4, *) {
            Task {
                do {
                    let binding = try await PaymentMethodBinding(id: id)
                    completion(PaymentMethodBindingWrapper(binding: binding), nil)
                } catch let error as PaymentMethodBinding.PaymentMethodBindingError {
                    let wrappederror = PaymentMethodBindingErrorWrapper(swiftError: error)
                    let nsError = NSError(
                        domain: "maui.storekit2.apple",
                        code: wrappederror?.code.rawValue ?? -1,
                        userInfo: [
                            NSLocalizedDescriptionKey: "BindingError",
                            "ErrorCase": String(describing: wrappederror?.code),
                            "ErrorCode": wrappederror?.code ?? -1,
                            "ErrorReason": String(describing: wrappederror?.failureReason),
                            "RecoverySuggestion": String(describing: wrappederror?.recoverySuggestion),
                            "IsVerified": false
                        ]
                    )
                    completion(nil, nsError)
                } catch {
                    let nsError = NSError(
                        domain: "maui.storekit2.apple",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                    )
                    completion(nil, nsError)
                }
            }
        } else {
            // Fallback for older OS versions
            let error = NSError(
                domain: "maui.storekit2.apple",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "PaymentMethodBinding is not available on this OS version."]
            )
            completion(nil, error)
        }
    }

    @objc public func bindAsync(
        completion: @escaping (PaymentMethodBindingErrorWrapper?) -> Void
    ) {
        if #available(iOS 16.4, *), let binding = binding as? PaymentMethodBinding {
            Task {
                do {
                    try await binding.bind()
                    completion(nil)
                } catch let err as PaymentMethodBinding.PaymentMethodBindingError {
                    completion(PaymentMethodBindingErrorWrapper(swiftError: err))
                } catch {
                    completion(PaymentMethodBindingErrorWrapper(
                        code: .unknown,
                        description: error.localizedDescription
                    ))
                }
            }
        } else {
            // Older OS versions cannot bind
            completion(PaymentMethodBindingErrorWrapper(
                code: .unknown,
                description: "PaymentMethodBinding.bind() is not supported on this OS version."
            ))
        }
    }

    @objc public var pinningID: String? {
        if #available(iOS 16.4, *), let binding = binding as? PaymentMethodBinding {
            return binding.id
        } else {
            return nil
        }
    }
}
