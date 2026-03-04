//
//  PaymentMethodBindingKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/18/25.
//

import Foundation
import UIKit
import StoreKit

@objc(PaymentMethodBindingErrorCode)
//@available(iOS 16.4, *)@available(macOS, unavailable)@available(tvOS, unavailable)
public enum PaymentMethodBindingErrorCode: Int {
    case notEligible
    case invalidPinningID
    case failed
    case unknown
}

// MARK: - PaymentMethodBindingErrorWrapper
@objc(PaymentMethodBindingError)
//@available(iOS 16.4, *)@available(macOS, unavailable)@available(tvOS, unavailable)
public final class PaymentMethodBindingErrorWrapper: NSObject {

    @objc public let code: PaymentMethodBindingErrorCode
    @objc public let errorDescription: String?
    @objc public let failureReason: String?
    @objc public let recoverySuggestion: String?

    /// Wrap a Swift PaymentMethodBindingError
    public init?(swiftError: Any?) {
        // Runtime check: only try to unwrap on iOS 16.4+ and if type matches
        if #available(iOS 16.4, *) {
            if let error = swiftError as? PaymentMethodBinding.PaymentMethodBindingError {
                switch error {
                case .notEligible:
                    self.code = .notEligible
                case .invalidPinningID:
                    self.code = .invalidPinningID
                case .failed:
                    self.code = .failed
                @unknown default:
                    self.code = .unknown
                }
                
                self.errorDescription = error.errorDescription
                self.failureReason = error.failureReason
                self.recoverySuggestion = error.recoverySuggestion
                super.init()
            } else {
                // Fallback if type isn't what we expect
                return nil
            }
        } else {
            // Older OS: provide a default error object
            self.code = .unknown
            self.errorDescription = "Unsupported < iOS 16.4"
            self.failureReason = nil
            self.recoverySuggestion = nil
            super.init()
        }
    }

    /// Custom initializer
    @objc
    public init(
        code: PaymentMethodBindingErrorCode,
        description: String? = nil,
        reason: String? = nil,
        suggestion: String? = nil
    ) {
        self.code = code
        self.errorDescription = description
        self.failureReason = reason
        self.recoverySuggestion = suggestion
    }
}
