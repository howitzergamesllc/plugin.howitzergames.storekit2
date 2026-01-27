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
@available(iOS 16.4, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public enum PaymentMethodBindingErrorCode: Int {
    case notEligible
    case invalidPinningID
    case failed
    case unknown
}

// MARK: - PaymentMethodBindingErrorWrapper
@objc(PaymentMethodBindingError)
@available(iOS 16.4, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public final class PaymentMethodBindingErrorWrapper: NSObject {

    @objc public let code: PaymentMethodBindingErrorCode
    @objc public let errorDescription: String?
    @objc public let failureReason: String?
    @objc public let recoverySuggestion: String?

    /// Wrap a Swift PaymentMethodBindingError
    public init(swiftError: PaymentMethodBinding.PaymentMethodBindingError) {
        switch swiftError {
        case .notEligible:
            self.code = .notEligible
        case .invalidPinningID:
            self.code = .invalidPinningID
        case .failed:
            self.code = .failed
        @unknown default:
            self.code = .unknown
        }

        self.errorDescription = swiftError.errorDescription
        self.failureReason = swiftError.failureReason
        self.recoverySuggestion = swiftError.recoverySuggestion
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
