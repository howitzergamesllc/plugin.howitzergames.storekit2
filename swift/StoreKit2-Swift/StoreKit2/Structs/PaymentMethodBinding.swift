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
@available(iOS 16.4, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public final class PaymentMethodBindingWrapper: NSObject {

    private let binding: PaymentMethodBinding

    // MARK: - Init
    private init(binding: PaymentMethodBinding) {
        self.binding = binding
    }
    
    // Synchronous factory method for C# compatibility
    @objc public static func createAsync(id: String, completion: @escaping (PaymentMethodBindingWrapper?, NSError?) -> Void) {
        Task {
            do {
                // Asynchronously create the PaymentMethodBinding
                let binding = try await PaymentMethodBinding(id: id)
                
                // Wrap and return the result
                let wrapper = PaymentMethodBindingWrapper(binding: binding)
                completion(wrapper, nil)  // No error
            } catch let error as PaymentMethodBinding.PaymentMethodBindingError {
                let wrappederror = PaymentMethodBindingErrorWrapper(swiftError: error)
                // If an error occurs, wrap it and pass it to the completion
                let nsError = NSError(
                    domain: "maui.storekit2.apple",
                    code: wrappederror.code.rawValue,
                    userInfo: [
                        NSLocalizedDescriptionKey: "BindingError",
                        "ErrorCase": String(describing: wrappederror.code),
                        "ErrorCode": wrappederror.code,
                        "ErrorReason": String(describing: wrappederror.failureReason),
                        "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                        "IsVerified": false
                    ])
                completion(nil, nsError)
            } catch {
                // Catch any unexpected errors and pass them as unknown
                let nsError = NSError(
                domain: "maui.storekit2.apple",
                code: -1, // Custom error code for unknown errors
                userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                )
                completion(nil, nsError)
            }
        }
    }

    // MARK: - Bind
    @objc
    public func bindAsync(
        completion: @escaping (PaymentMethodBindingErrorWrapper?) -> Void
    ) {
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
    }

    // MARK: - Expose ID
    @objc public var pinningID: String {
        binding.id
    }
}
