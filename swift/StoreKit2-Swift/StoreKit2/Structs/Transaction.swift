//
//  TransactionManager.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/17/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - Transaction
@objc(Transaction)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class TransactionWrapper: NSObject {
    
    private let swiftValue: Transaction
    
    public init(swiftValue: Transaction) {
        self.swiftValue = swiftValue
    }
    
    @objc public var jsonRepresentation: Data {
        swiftValue.jsonRepresentation
    }
    
    @objc public var id: NSNumber { // UInt64 → NSNumber for Obj-C
        NSNumber(value: swiftValue.id)
    }
    
    @objc public var originalID: NSNumber {
        NSNumber(value: swiftValue.originalID)
    }
    
    @objc public var webOrderLineItemID: String? {
        swiftValue.webOrderLineItemID
    }
    
    @objc public var productID: String {
        swiftValue.productID
    }
    
    @objc public var subscriptionGroupID: String? {
        swiftValue.subscriptionGroupID
    }
    
    @objc public var appBundleID: String {
        swiftValue.appBundleID
    }
    
    @objc public var purchaseDate: Date {
        swiftValue.purchaseDate
    }
    
    @objc public var originalPurchaseDate: Date {
        swiftValue.originalPurchaseDate
    }
    
    @objc public var expirationDate: Date? {
        swiftValue.expirationDate
    }
    
    @objc public var purchasedQuantity: Int {
        swiftValue.purchasedQuantity
    }
    
    @objc public var isUpgraded: Bool {
        swiftValue.isUpgraded
    }
    
    @available(iOS 17.2, macOS 14.2, tvOS 17.2, *)
    @objc public var offer: TransactionOfferWrapper? {
        guard let o = swiftValue.offer else { return nil }
        return TransactionOfferWrapper(swiftValue: o)
    }
    
    @objc
    public var offerType: TransactionOfferTypeWrapper {
        guard let ot = swiftValue.offerType else {
            return .unknown
        }
        switch ot {
        case .introductory:
            return .introductory
        case .promotional:
            return .promotional
        case .code:
            return .code
        case .winBack:
            return .winBack
        default:
            return .unknown
        }
    }

    
    @objc public var offerID: String? {
        swiftValue.offerID
    }
    
    @objc public var offerPaymentModeStringRepresentation: String? {
        swiftValue.offerPaymentModeStringRepresentation
    }
    
    @objc public var offerPeriodStringRepresentation: String? {
        swiftValue.offerPeriodStringRepresentation
    }
    
    @objc public var revocationDate: Date? {
        swiftValue.revocationDate
    }
    
    @objc
    public var revocationReason: TransactionRevocationReasonCode {
        guard let rr = swiftValue.revocationReason else {
            return .unknown
        }
        switch rr {
        case .developerIssue:
            return .developerIssue
        case .other:
            return .other
        default:
            return .unknown
        }
    }

    
    @objc public var productType: ProductTypeWrapper {
        ProductTypeWrapper(swiftValue: swiftValue.productType)
    }
    
    @objc public var appAccountToken: UUID? {
        swiftValue.appAccountToken
    }
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
    @objc public var environment: AppStoreEnvironmentWrapper {
        AppStoreEnvironmentWrapper(swiftEnvironment: swiftValue.environment)
    }
    
    @objc public var environmentStringRepresentation: String {
        swiftValue.environmentStringRepresentation
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
    @objc public var reason: TransactionReasonWrapper {
        TransactionReasonWrapper(swiftReason: swiftValue.reason)
    }
    
    @objc public var reasonStringRepresentation: String {
        swiftValue.reasonStringRepresentation
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
    @objc public var storefront: StoreFrontWrapper {
        StoreFrontWrapper(swiftValue.storefront)
    }
    
    @objc public var storefrontCountryCode: String {
        swiftValue.storefrontCountryCode
    }
    
    @objc public var price: NSDecimalNumber? {
        guard let p = swiftValue.price else { return nil }
        return p as NSDecimalNumber
    }
    
    @objc
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
    public var currency: CurrencyWrapper? {
        guard let swiftCurrency = Locale.current.currency else {
            return nil // Return nil if there's no currency (fallback to USD or other default)
        }
        return CurrencyWrapper(swiftValue: swiftCurrency)
    }
    
    @objc public var currencyCode: String? {
        swiftValue.currencyCode
    }
    
    @objc public var appTransactionID: String {
        swiftValue.appTransactionID
    }
    
    @objc public var deviceVerification: Data {
        swiftValue.deviceVerification
    }
    
    @objc public var deviceVerificationNonce: UUID? {
        swiftValue.deviceVerificationNonce
    }
    
    @objc public var ownershipType: TransactionOwnershipTypeWrapper {
        TransactionOwnershipTypeWrapper(swiftValue: swiftValue.ownershipType)
    }
    
    @objc public var signedDate: Date {
        swiftValue.signedDate
    }
    
    @objc
    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public var advancedCommerceInfo: TransactionAdvancedCommerceInfoWrapper? {
        if let info = swiftValue.advancedCommerceInfo {
            return TransactionAdvancedCommerceInfoWrapper(swiftValue: info)
        }
        return nil
    }
    
    @objc
    public func finishAsync(_ completion: @escaping () -> Void) {
        Task {
            await swiftValue.finish()
            completion()
        }
    }
    
    @objc
    public static func updateTransactionsAsync(
        transactionHandler: @escaping (TransactionVerificationResultWrapper)->Void,
        completion: @escaping ()->Void
    ) {
        Task {
            for await result in Transaction.updates {
                let wrapped = TransactionVerificationResultWrapper(verification: result)
                transactionHandler(wrapped)
            }
            
            completion()
        }
    }
    
    /// All transactions ever for this user and app
    @objc(allTransactionsAsyncWithHandler:completion:)
    public static func allTransactionsAsync(
        transactionHandler: @escaping (TransactionVerificationResultWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            for await result in Transaction.all {
                let wrapped = TransactionVerificationResultWrapper(verification: result)
                transactionHandler(wrapped)
            }
            completion()
        }
    }
    
    /// Currently entitled transactions (non-consumables + active subscriptions)
    @objc(currentEntitlementsAsyncWithHandler:completion:)
    public static func currentEntitlementsAsync(
        transactionHandler: @escaping (TransactionVerificationResultWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            for await result in Transaction.currentEntitlements {
                let wrapped = TransactionVerificationResultWrapper(verification: result)
                transactionHandler(wrapped)
            }
            completion()
        }
    }
    
    /// Get the current entitlement for a specific product (deprecated in iOS 18.4+)
    @objc(currentEntitlementsAsyncForProductIDAsync:completion:)
    @available(iOS, introduced: 15.0, deprecated: 18.4)
    @available(macOS, introduced: 12.0, deprecated: 15.4)
    @available(tvOS, introduced: 15.0, deprecated: 18.4)
    public static func currentEntitlementAsync(
        forProductID productID: String,
        completion: @escaping (TransactionVerificationResultWrapper?) -> Void
    ) {
        Task {
            let result = await Transaction.currentEntitlement(for: productID)
            if let result {
                completion(TransactionVerificationResultWrapper(verification: result))
            } else {
                completion(nil)
            }
        }
    }
    
    /// Get the latest transaction for a product
    @objc
    public static func latestTransactionAsync(
        forProductID productID: String,
        completion: @escaping (TransactionVerificationResultWrapper?) -> Void
    ) {
        Task {
            let result = await Transaction.latest(for: productID)
            if let result {
                completion(TransactionVerificationResultWrapper(verification: result))
            } else {
                completion(nil)
            }
        }
    }
    
    /// All unfinished transactions
    @objc
    public static func unfinishedTransactionsAsync(
        transactionHandler: @escaping (TransactionVerificationResultWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            for await result in Transaction.unfinished {
                let wrapped = TransactionVerificationResultWrapper(verification: result)
                transactionHandler(wrapped)
            }
            completion()
        }
    }
    
    @objc
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    public static func observeUpdatesAsync(
        transactionHandler: @escaping (TransactionVerificationResultWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            for await result in Transaction.updates {
                let wrapped = TransactionVerificationResultWrapper(verification: result
                )
                transactionHandler(wrapped)
            }
            completion()
        }
    }
    
    @objc(allTransactionsAsyncWithHandler:productID:completion:)
    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public static func allTransactionsAsync(
        forProductID productID: String,
        transactionHandler: @escaping (TransactionVerificationResultWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            for await result in Transaction.all(for: productID) {
                let wrapped = TransactionVerificationResultWrapper(verification: result
                )
                transactionHandler(wrapped)
            }
            completion()
        }
    }
    
    @objc(currentEntitlementsAsyncWithHandler:productID:completion:)
    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public static func currentEntitlementsAsync(
        forProductID productID: String,
        transactionHandler: @escaping (TransactionVerificationResultWrapper) -> Void,
        completion: @escaping () -> Void
    ) {
        Task {
            for await result in Transaction.currentEntitlements(for: productID) {
                let wrapped = TransactionVerificationResultWrapper(verification: result)
                transactionHandler(wrapped)
            }
            completion()
        }
    }
    
    @objc(beginRefundRequestAsyncInScene:completion:)
    public func beginRefundRequestAsync(
        in scene: UIWindowScene,
        completion: @escaping (RefundRequestStatusWrapper, NSError?) -> Void
    ) {
        Task {
            var wrappedStatus: RefundRequestStatusWrapper
            var wrappedError: NSError? = nil
            
            do {
                let status = try await swiftValue.beginRefundRequest(in: scene)
                switch status {
                case .success:
                    wrappedStatus = .success
                case .userCancelled:
                    wrappedStatus = .userCancelled
                @unknown default:
                    wrappedStatus = .undefined
                }
            } catch let error as Transaction.RefundRequestError {
                let wrappederror = RefundRequestErrorWrapper(swiftError: error)
                wrappedStatus = .failed
                wrappedError = NSError(domain: "maui.storekit2.apple", code: wrappederror.code.rawValue,                                      userInfo: [
                    NSLocalizedDescriptionKey: "RefundRequestError",
                    "ErrorCase": String(describing: wrappederror.code),
                    "ErrorCode": wrappederror.code,
                    "ErrorReason": String(describing: wrappederror.failureReason),
                    "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                    "IsVerified": false
                ])
            } catch let error as StoreKitError {
                let wrappederror = StoreKitErrorWrapper(swiftError: error)
                wrappedStatus = .failed
                wrappedError = NSError(domain: "maui.storekit2.apple", code: wrappederror.code.rawValue,                                      userInfo: [
                    NSLocalizedDescriptionKey: "StoreKitError",
                    "ErrorCase": String(describing: wrappederror.code),
                    "ErrorCode": wrappederror.code,
                    "ErrorReason": String(describing: wrappederror.failureReason),
                    "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                    "IsVerified": false
                ])
            } catch {
                wrappedStatus = .failed
                // Create a new generic NSError for any other Swift error
                wrappedError = NSError(domain: "maui.storekit2.apple", code: -1, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            }
            
            completion(wrappedStatus, wrappedError)
        }
    }
    
    @objc(beginRefundRequestAsyncInScene:transactionID:completion:)
    @available(iOS 15.0, *)
    @available(tvOS, unavailable)
    public static func beginRefundRequestAsync(
        for transactionID: UInt64,
        in scene: UIWindowScene,
        completion: @escaping (RefundRequestStatusWrapper, NSError?) -> Void
    ) {
        Task {
            var wrappedStatus: RefundRequestStatusWrapper
            var wrappedError: NSError? = nil

            do {
                // Call the Swift async static function
                let status = try await Transaction.beginRefundRequest(for: transactionID, in: scene)
                switch status {
                case .success:
                    wrappedStatus = .success
                case .userCancelled:
                    wrappedStatus = .userCancelled
                @unknown default:
                    wrappedStatus = .undefined
                }
            } catch let error as Transaction.RefundRequestError {
                let wrappederror = RefundRequestErrorWrapper(swiftError: error)
                wrappedStatus = .failed
                wrappedError = NSError(domain: "maui.storekit2.apple", code: wrappederror.code.rawValue, userInfo: [
                    NSLocalizedDescriptionKey: "RefundRequestError",
                    "ErrorCase": String(describing: wrappederror.code),
                    "ErrorCode": wrappederror.code,
                    "ErrorReason": String(describing: wrappederror.failureReason),
                    "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                    "IsVerified": false
                ])
            } catch let error as StoreKitError {
                let wrappederror = StoreKitErrorWrapper(swiftError: error)
                wrappedStatus = .failed
                wrappedError = NSError(domain: "maui.storekit2.apple", code: wrappederror.code.rawValue,                                      userInfo: [
                    NSLocalizedDescriptionKey: "StoreKitError",
                    "ErrorCase": String(describing: wrappederror.code),
                    "ErrorCode": wrappederror.code,
                    "ErrorReason": String(describing: wrappederror.failureReason),
                    "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                    "IsVerified": false
                ])
            } catch {
                wrappedStatus = .failed
                wrappedError = NSError(domain: "maui.storekit2.apple", code: -1, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            }

            // Call completion
            completion(wrappedStatus, wrappedError)
        }
    }
    
    @objc
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    public func getSubscriptionStatusAsync(
        completion: @escaping (SubscriptionStatusWrapper?) -> Void
    ) {
        Task {
            if let status = await swiftValue.subscriptionStatus {
                let wrappedStatus = SubscriptionStatusWrapper(swiftValue: status)
                completion(wrappedStatus)
            } else {
                completion(nil)
            }
        }
    }
}
