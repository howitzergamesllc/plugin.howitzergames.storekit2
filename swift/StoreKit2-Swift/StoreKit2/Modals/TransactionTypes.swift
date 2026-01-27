//
//  TransactionKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/17/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - TransactionReason
@objc(TransactionReason)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public final class TransactionReasonWrapper: NSObject {

    // Private Swift Transaction.Reason
    private let reason: Transaction.Reason

    // Expose rawValue to ObjC
    @objc public var rawValue: String {
        reason.rawValue
    }

    // Internal initializer for Swift only
    init(swiftReason: Transaction.Reason) {
        self.reason = swiftReason
    }

    // Convenience static constants for ObjC
    @objc public static let purchase = TransactionReasonWrapper(swiftReason: .purchase)
    @objc public static let renewal = TransactionReasonWrapper(swiftReason: .renewal)
    
    @objc public func isEqualToReason(_ other: TransactionReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - Transaction.RevocationReason
@objc(TransactionRevocationReason)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public enum TransactionRevocationReasonCode: Int {
    case developerIssue = 0
    case other = 1
    case unknown = -1
}

// MARK: - Transaction.OfferType
@objc(TransactionOfferType)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public enum TransactionOfferTypeWrapper: Int {
    case introductory = 0
    case promotional = 1
    case code = 2
    case winBack = 3
    case unknown = -1
}

// MARK: - TransactionOwnershipType
@objc(TransactionOwnershipType)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class TransactionOwnershipTypeWrapper: NSObject {

    private let swiftValue: Transaction.OwnershipType

    @objc public var rawValue: String {
        return swiftValue.rawValue
    }
    init(swiftValue: Transaction.OwnershipType) {
        self.swiftValue = swiftValue
    }

    @objc public static let purchased =
        TransactionOwnershipTypeWrapper(swiftValue: .purchased)

    @objc public static let familyShared =
        TransactionOwnershipTypeWrapper(swiftValue: .familyShared)

    @objc public func isEqualToType(_ other: TransactionOwnershipTypeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - TransactionOffer
@objc(TransactionOffer)
@available(iOS 17.2, macOS 14.2, tvOS 17.2, *)
public final class TransactionOfferWrapper: NSObject {

    private let swiftValue: Transaction.Offer

    @objc public var id: String? {
        swiftValue.id
    }

    @objc
    public var type: TransactionOfferTypeWrapper {
        switch swiftValue.type {
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

    @objc public var paymentMode: TransactionOfferPaymentModeWrapper? {
        if let pm = swiftValue.paymentMode {
            return TransactionOfferPaymentModeWrapper(swiftValue: pm)
        }
        return nil
    }

    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    @objc public var period: ProductSubscriptionPeriodWrapper? {
        if let p = swiftValue.period {
            return ProductSubscriptionPeriodWrapper(swiftValue: p)
        }
        return nil
    }

    init(swiftValue: Transaction.Offer) {
        self.swiftValue = swiftValue
    }
}

// MARK: - TransactionOffer.PaymentMode
@objc(TransactionOfferPaymentMode)
@available(iOS 17.2, macOS 14.2, tvOS 17.2, *)
public final class TransactionOfferPaymentModeWrapper: NSObject {

    private let swiftValue: Transaction.Offer.PaymentMode

    @objc public var rawValue: String {
        swiftValue.rawValue
    }

    init(swiftValue: Transaction.Offer.PaymentMode) {
        self.swiftValue = swiftValue
    }

    @objc public static let freeTrial =
        TransactionOfferPaymentModeWrapper(swiftValue: .freeTrial)

    @objc public static let payAsYouGo =
        TransactionOfferPaymentModeWrapper(swiftValue: .payAsYouGo)

    @objc public static let payUpFront =
        TransactionOfferPaymentModeWrapper(swiftValue: .payUpFront)

    @available(iOS 17.2, macOS 14.2, tvOS 17.2, *)
    @objc public static var oneTime: TransactionOfferPaymentModeWrapper {
        return TransactionOfferPaymentModeWrapper(swiftValue: .oneTime)
    }

    @objc public func isEqualToMode(_ other: TransactionOfferPaymentModeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - Transaction.AdvancedCommerceInfo
@objc(TransactionAdvancedCommerceInfo)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo
    
    public init(swiftValue: Transaction.AdvancedCommerceInfo) {
        self.swiftValue = swiftValue
    }
    
    @objc public var requestReferenceID: String {
        swiftValue.requestReferenceID
    }
    
    @objc public var estimatedTax: NSDecimalNumber {
        swiftValue.estimatedTax as NSDecimalNumber
    }
    
    @objc public var taxRate: NSDecimalNumber {
        swiftValue.taxRate as NSDecimalNumber
    }
    
    @objc public var taxCode: String {
        swiftValue.taxCode
    }
    
    @objc public var taxExclusivePrice: NSDecimalNumber {
        swiftValue.taxExclusivePrice as NSDecimalNumber
    }
    
    @objc public var infoDescription: String? {
        swiftValue.description
    }
    
    @objc public var displayName: String? {
        swiftValue.displayName
    }
    
    @objc public var period: ProductSubscriptionPeriodWrapper? {
        swiftValue.period.map { ProductSubscriptionPeriodWrapper(swiftValue: $0) }
    }
    
    @objc public var items: NSArray {
        return swiftValue.items.map { TransactionAdvancedCommerceInfoItemWrapper(swiftValue: $0) } as NSArray
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Item
@objc(TransactionAdvancedCommerceInfoItem)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoItemWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo.Item
    
    public init(swiftValue: Transaction.AdvancedCommerceInfo.Item) {
        self.swiftValue = swiftValue
    }
    
    @objc public var details: TransactionAdvancedCommerceInfoItemDetailsWrapper {
        TransactionAdvancedCommerceInfoItemDetailsWrapper(swiftValue: swiftValue.details)
    }
    
    @objc public var refunds: NSArray? {
        return swiftValue.refunds?.map { TransactionAdvancedCommerceInfoRefundWrapper(swiftValue: $0) } as NSArray?
    }
    
    @objc public var revocationDate: Date? {
        swiftValue.revocationDate
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Item.Details
@objc(TransactionAdvancedCommerceInfoItemDetails)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoItemDetailsWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo.Item.Details

    public init(swiftValue: Transaction.AdvancedCommerceInfo.Item.Details) {
        self.swiftValue = swiftValue
    }
    
    @objc public var sku: String { swiftValue.sku }
    @objc public var displayName: String { swiftValue.displayName }
    @objc public var itemDescription: String { swiftValue.description }
    
    @objc public var offer: TransactionAdvancedCommerceInfoOfferWrapper? {
        swiftValue.offer.map { TransactionAdvancedCommerceInfoOfferWrapper(swiftValue: $0) }
    }
    
    @objc public var price: NSDecimalNumber {
        swiftValue.price as NSDecimalNumber
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Offer
@objc(TransactionAdvancedCommerceInfoOffer)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoOfferWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo.Offer
    
    public init(swiftValue: Transaction.AdvancedCommerceInfo.Offer) {
        self.swiftValue = swiftValue
    }
    
    @objc public var price: NSDecimalNumber {
        swiftValue.price as NSDecimalNumber
    }
    
    @objc public var period: ProductSubscriptionPeriodWrapper {
        ProductSubscriptionPeriodWrapper(swiftValue: swiftValue.period)
    }
    
    @objc public var periodCount: NSNumber {
        NSNumber(value: swiftValue.periodCount)
    }
    
    @objc public var reason: TransactionAdvancedCommerceInfoOfferReasonWrapper {
        TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: swiftValue.reason)
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Offer.Reason
@objc(TransactionAdvancedCommerceInfoOfferReason)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoOfferReasonWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo.Offer.Reason
    
    public init(swiftValue: Transaction.AdvancedCommerceInfo.Offer.Reason) {
        self.swiftValue = swiftValue
    }
    
    @objc public var rawValue: String { swiftValue.rawValue }
    
    @objc public static let acquisition =
    TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: .acquisition)
    @objc public static let retention =
    TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: .retention)
    @objc public static let winBack =
    TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: .winBack)
    
    @objc public func isEqualToReason(_ other: TransactionAdvancedCommerceInfoOfferReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Refund
@objc(TransactionAdvancedCommerceInfoRefund)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoRefundWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo.Refund
    
    public init(swiftValue: Transaction.AdvancedCommerceInfo.Refund) {
        self.swiftValue = swiftValue
    }
    
    @objc public var reason: TransactionAdvancedCommerceInfoRefundReasonWrapper {
        TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: swiftValue.reason)
    }
    
    @objc public var type: TransactionAdvancedCommerceInfoRefundTypeWrapper {
        TransactionAdvancedCommerceInfoRefundTypeWrapper(swiftValue: swiftValue.type)
    }
    
    @objc public var date: Date { swiftValue.date }
    
    @objc public var amount: NSDecimalNumber {
        swiftValue.amount as NSDecimalNumber
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Refund.Reason
@objc(TransactionAdvancedCommerceInfoRefundReason)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoRefundReasonWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo.Refund.Reason
    
    public init(swiftValue: Transaction.AdvancedCommerceInfo.Refund.Reason) {
        self.swiftValue = swiftValue
    }
    
    @objc public var rawValue: String { swiftValue.rawValue }
    
    @objc public static let legal =
    TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: .legal)
    @objc public static let modifyItems =
    TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: .modifyItems)
    @objc public static let unintended =
    TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: .unintended)
    @objc public static let unfulfilled =
    TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: .unfulfilled)
    @objc public static let unsatisfied =
    TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: .unsatisfied)
    @objc public static let other =
    TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: .other)
    
    @objc public func isEqualToReason(_ other: TransactionAdvancedCommerceInfoRefundReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Refund.Type
@objc(TransactionAdvancedCommerceInfoRefundType)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoRefundTypeWrapper: NSObject {
    private let swiftValue: Transaction.AdvancedCommerceInfo.Refund.RefundType
    
    public init(swiftValue: Transaction.AdvancedCommerceInfo.Refund.RefundType) {
        self.swiftValue = swiftValue
    }
    
    @objc public var rawValue: String { swiftValue.rawValue }
    
    @objc public static let custom =
    TransactionAdvancedCommerceInfoRefundTypeWrapper(swiftValue: .custom)
    @objc public static let proRated =
    TransactionAdvancedCommerceInfoRefundTypeWrapper(swiftValue: .proRated)
    @objc public static let full =
    TransactionAdvancedCommerceInfoRefundTypeWrapper(swiftValue: .full)
    
    @objc public func isEqualToType(_ other: TransactionAdvancedCommerceInfoRefundTypeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

@objc(RefundRequestErrorCode)
@available(iOS 15.0, macOS 12.0, tvOS 17.0, *)
public enum RefundRequestErrorCode: Int {
    case duplicateRequest = 0
    case failed = 1
    case unknown = -1
}

// MARK: - RefundRequestError
@objc(RefundRequestError)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class RefundRequestErrorWrapper: NSObject {

    @objc public let code: RefundRequestErrorCode

    private let swiftError: Transaction.RefundRequestError
    
    public init(swiftError: Transaction.RefundRequestError) {
        // Map Swift enum to NS_ENUM
        self.swiftError = swiftError
        switch swiftError {
        case .duplicateRequest: code = .duplicateRequest
        case .failed: code = .failed
        @unknown default: code = .unknown
        }
    }
    
    // MARK: - LocalizedError bridging
    @objc public var errorDescription: String? {
        swiftError.errorDescription
    }

    @objc public var failureReason: String? {
        swiftError.failureReason
    }

    @objc public var recoverySuggestion: String? {
        swiftError.recoverySuggestion
    }
}

@objc(RefundRequestStatus)
@available(iOS 15.0, macOS 12.0, tvOS 17.0, *)
public enum RefundRequestStatusWrapper: Int {
    case success = 0
    case userCancelled = 1
    case failed = -1
    case undefined = -2
}
