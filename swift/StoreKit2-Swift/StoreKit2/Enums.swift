//
//  Enums.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/17/25.
//

import Foundation
import UIKit
import StoreKit

@objc(StoreKitErrorCode)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public enum StoreKitErrorCode: Int {
    case unknown
    case userCancelled
    case networkError
    case systemError
    case notAvailableInStorefront
    case notEntitled
    case unsupported
    case invalidPresentationContext
}

@objc(StoreKitError)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class StoreKitErrorWrapper: NSObject {
    @objc public let code: StoreKitErrorCode
    @objc public let underlyingError: NSError?
    @objc public let errorDescription: String?
    @objc public let failureReason: String?
    @objc public let recoverySuggestion: String?

    init(swiftError: StoreKitError) {
        switch swiftError {
        case .unknown: code = .unknown; underlyingError = nil
        case .userCancelled: code = .userCancelled; underlyingError = nil
        case .networkError(let urlErr): code = .networkError; underlyingError = urlErr as NSError
        case .systemError(let anyErr): code = .systemError; underlyingError = anyErr as NSError
        case .notAvailableInStorefront: code = .notAvailableInStorefront; underlyingError = nil
        case .notEntitled: code = .notEntitled; underlyingError = nil
        case .unsupported: code = .unsupported; underlyingError = nil
        case .invalidPresentationContext: code = .invalidPresentationContext; underlyingError = nil
        default: code = .unknown; underlyingError = nil
        }
        if #available(iOS 15.4, *) {
            errorDescription = swiftError.errorDescription
        } else {
            errorDescription = "Unsupported on this platform"
        }
        if #available(iOS 15.4, *) {
            failureReason = swiftError.failureReason
        } else {
            failureReason = "Unsupported on this platform"
        }
        if #available(iOS 15.4, *) {
            recoverySuggestion = swiftError.recoverySuggestion
        } else {
            recoverySuggestion = "Unsupported on this platform"
        }
    }
}
