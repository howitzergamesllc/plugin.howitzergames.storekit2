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
//@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public final class TransactionReasonWrapper: NSObject {

    @objc public let rawValue: String

    // Internal initializer for Swift only
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public convenience init?(swiftReason: Any?) {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, *),
           let reason = swiftReason as? Transaction.Reason {
            self.init(rawValue: reason.rawValue)
        } else {
            return nil
        }
    }

    @objc public static var purchase: TransactionReasonWrapper? {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, *) {
            return TransactionReasonWrapper(swiftReason: Transaction.Reason.purchase)!
        } else {
            return nil
        }
    }

    @objc public static var renewal: TransactionReasonWrapper? {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, *) {
            return TransactionReasonWrapper(swiftReason: Transaction.Reason.renewal)!
        } else {
            return nil
        }
    }

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
    case upgradedToBundle = 2
    case unknown = -1
}

// MARK: - TransactionRevocationType
@objc(TransactionRevocationType)
//(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *)
public final class TransactionRevocationTypeWrapper: NSObject {

    private let storedValue: Any?
    private let storedRawValue: String

    @objc public var rawValue: String {
        return storedRawValue
    }

    @available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *)
    public var swiftValue: Transaction.RevocationType? {
        return storedValue as? Transaction.RevocationType
    }

    @available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *)
    public init(swiftValue: Transaction.RevocationType) {
        self.storedValue = swiftValue
        self.storedRawValue = swiftValue.rawValue
        super.init()
    }

    @objc public init(rawValue: String) {
        self.storedValue = nil
        self.storedRawValue = rawValue
        super.init()
    }

    @objc public static var familyRevocation: TransactionRevocationTypeWrapper {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            return TransactionRevocationTypeWrapper(swiftValue: .familyRevocation)
        }
        return TransactionRevocationTypeWrapper(rawValue: "unsupported")
    }

    @objc public static var fullRefund: TransactionRevocationTypeWrapper {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            return TransactionRevocationTypeWrapper(swiftValue: .fullRefund)
        }
        return TransactionRevocationTypeWrapper(rawValue: "unsupported")
    }

    @objc public static var proratedRefund: TransactionRevocationTypeWrapper {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 4.0, *) {
            return TransactionRevocationTypeWrapper(swiftValue: .proratedRefund)
        }
        return TransactionRevocationTypeWrapper(rawValue: "unsupported")
    }

    @objc public static var assignmentRevocation: TransactionRevocationTypeWrapper {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            return TransactionRevocationTypeWrapper(swiftValue: .assignmentRevocation)
        }
        return TransactionRevocationTypeWrapper(rawValue: "unsupported")
    }

    @objc public func isEqualToType(_ other: TransactionRevocationTypeWrapper?) -> Bool {
        guard let other else { return false }
        return rawValue == other.rawValue
    }
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
    
    @objc public static var assigned: TransactionOwnershipTypeWrapper {
        TransactionOwnershipTypeWrapper(swiftValue: .assigned)
    }

    @objc public func isEqualToType(_ other: TransactionOwnershipTypeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - TransactionOffer
@objc(TransactionOffer)
//@available(iOS 17.2, macOS 14.2, tvOS 17.2, *)
public final class TransactionOfferWrapper: NSObject {
    
    @objc public let id: String?
    @objc public let type: TransactionOfferTypeWrapper
    @objc public let paymentMode: TransactionOfferPaymentModeWrapper?
    @objc public let period: ProductSubscriptionPeriodWrapper?

    // Private initializer for internal bridging
    private init(
        id: String?,
        type: TransactionOfferTypeWrapper,
        paymentMode: TransactionOfferPaymentModeWrapper?,
        period: ProductSubscriptionPeriodWrapper?
    ) {
        self.id = id
        self.type = type
        self.paymentMode = paymentMode
        self.period = period
        super.init()
    }

    /// Runtime-safe initializer from Swift `Transaction.Offer`
    public convenience init?(swiftOffer: Any?) {
        if #available(iOS 17.2, macOS 14.2, tvOS 17.2, *),
           let offer = swiftOffer as? Transaction.Offer {

            let typeWrapper: TransactionOfferTypeWrapper
            switch offer.type {
            case .introductory:
                typeWrapper = .introductory
            case .promotional:
                typeWrapper = .promotional
            case .code:
                typeWrapper = .code
            case .winBack:
                typeWrapper = .winBack
            default:
                typeWrapper = .unknown
            }

            let paymentModeWrapper = offer.paymentMode.flatMap { TransactionOfferPaymentModeWrapper(swiftValue: $0) }
            let periodWrapper: ProductSubscriptionPeriodWrapper?
            if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
                periodWrapper = offer.period.map { ProductSubscriptionPeriodWrapper(swiftValue: $0) }
            } else {
                periodWrapper = nil
            }

            self.init(
                id: offer.id,
                type: typeWrapper,
                paymentMode: paymentModeWrapper,
                period: periodWrapper
            )
        } else {
            return nil
        }
    }
}

// MARK: - TransactionOffer.PaymentMode
@objc(TransactionOfferPaymentMode)
//@available(iOS 17.2, macOS 14.2, tvOS 17.2, *)
public final class TransactionOfferPaymentModeWrapper: NSObject {

    @objc public let rawValue: String

    private init(rawValue: String) {
        self.rawValue = rawValue
        super.init()
    }
    
    public convenience init?(swiftValue: Any?) {
        if #available(iOS 17.2, macOS 14.2, tvOS 17.2, *),
           let mode = swiftValue as? Transaction.Offer.PaymentMode {
            self.init(rawValue: mode.rawValue)
        } else {
            return nil
        }
    }

    @objc public static let freeTrial = TransactionOfferPaymentModeWrapper(rawValue: "freeTrial")
    @objc public static let payAsYouGo = TransactionOfferPaymentModeWrapper(rawValue: "payAsYouGo")
    @objc public static let payUpFront = TransactionOfferPaymentModeWrapper(rawValue: "payUpFront")

    @objc public static var oneTime: TransactionOfferPaymentModeWrapper {
        if #available(iOS 17.2, macOS 14.2, tvOS 17.2, *) {
            return TransactionOfferPaymentModeWrapper(swiftValue: Transaction.Offer.PaymentMode.oneTime)!
        } else {
            return TransactionOfferPaymentModeWrapper(rawValue: "oneTime")
        }
    }

    @objc public func isEqualToMode(_ other: TransactionOfferPaymentModeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - Transaction.AdvancedCommerceInfo
@objc(TransactionAdvancedCommerceInfo)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoWrapper: NSObject {
    
    @objc public let requestReferenceID: String
    @objc public let estimatedTax: NSDecimalNumber
    @objc public let taxRate: NSDecimalNumber
    @objc public let taxCode: String
    @objc public let taxExclusivePrice: NSDecimalNumber
    @objc public let infoDescription: String?
    @objc public let displayName: String?
    @objc public let period: ProductSubscriptionPeriodWrapper?
    @objc public let items: [SubscriptionAdvancedCommerceItemWrapper]
    
    public init?(swiftValue: Any?) {
        // Only unwrap if OS is available
        guard #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
              let info = swiftValue as? Transaction.AdvancedCommerceInfo else {
            return nil
        }
        
        self.requestReferenceID = info.requestReferenceID
        self.estimatedTax = info.estimatedTax as NSDecimalNumber
        self.taxRate = info.taxRate as NSDecimalNumber
        self.taxCode = info.taxCode
        self.taxExclusivePrice = info.taxExclusivePrice as NSDecimalNumber
        self.infoDescription = info.description
        self.displayName = info.displayName
        self.period = info.period.map { ProductSubscriptionPeriodWrapper(swiftValue: $0) }
        self.items = info.items.compactMap { SubscriptionAdvancedCommerceItemWrapper(swiftItem: $0) }
        
        super.init()
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Item
@objc(TransactionAdvancedCommerceInfoItem)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoItemWrapper: NSObject {
    @objc public let details: TransactionAdvancedCommerceInfoItemDetailsWrapper?
    @objc public let refunds: NSArray?
    @objc public let revocationDate: Date?
    
    public init?(swiftItem: Any?) {
        // Only unwrap if OS supports it
        guard #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
              let item = swiftItem as? Transaction.AdvancedCommerceInfo.Item else {
            return nil
        }

        self.details = TransactionAdvancedCommerceInfoItemDetailsWrapper(swiftValue: item.details)
        self.refunds = item.refunds?.map { TransactionAdvancedCommerceInfoRefundWrapper(swiftValue: $0) } as NSArray?
        self.revocationDate = item.revocationDate

        super.init()
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Item.Details
@objc(TransactionAdvancedCommerceInfoItemDetails)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoItemDetailsWrapper: NSObject {
    
    private let underlying: Any?

    public init?(swiftValue: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            // Only cast inside the #available check
            guard swiftValue is Transaction.AdvancedCommerceInfo.Item.Details else { return nil }
            self.underlying = swiftValue
        } else {
            // Older OS: cannot wrap, return nil
            self.underlying = nil
        }
        super.init()
    }

    @objc public var sku: String {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let details = underlying as? Transaction.AdvancedCommerceInfo.Item.Details {
            return details.sku
        }
        return "Unknown SKU"
    }

    @objc public var displayName: String {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let details = underlying as? Transaction.AdvancedCommerceInfo.Item.Details {
            return details.displayName
        }
        return "Unknown"
    }

    @objc public var itemDescription: String {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let details = underlying as? Transaction.AdvancedCommerceInfo.Item.Details {
            return details.description
        }
        return "Unknown"
    }

    @objc public var offer: TransactionAdvancedCommerceInfoOfferWrapper? {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let details = underlying as? Transaction.AdvancedCommerceInfo.Item.Details,
           let offer = details.offer {
            return TransactionAdvancedCommerceInfoOfferWrapper(swiftValue: offer)
        }
        return nil
    }

    @objc public var price: NSDecimalNumber {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let details = underlying as? Transaction.AdvancedCommerceInfo.Item.Details {
            return details.price as NSDecimalNumber
        }
        return NSDecimalNumber.zero
    }

    @objc
    public var partners: NSArray {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) {
            guard let details = underlying as? Transaction.AdvancedCommerceInfo.Item.Details else {
                return []
            }

            return details.partners.compactMap {
                TransactionAdvancedCommercePartnerWrapper(swiftValue: $0)
            } as NSArray
        }
        return []
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Offer
@objc(TransactionAdvancedCommerceInfoOffer)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoOfferWrapper: NSObject {

    private let underlying: Any?

    /// Runtime-safe initializer
    public init?(swiftValue: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let offer = swiftValue as? Transaction.AdvancedCommerceInfo.Offer {
            self.underlying = offer
        } else {
            self.underlying = nil
        }
        super.init()
    }

    @objc public var price: NSDecimalNumber {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let offer = underlying as? Transaction.AdvancedCommerceInfo.Offer {
            return offer.price as NSDecimalNumber
        }
        return NSDecimalNumber.zero
    }

    @objc public var period: ProductSubscriptionPeriodWrapper? {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let offer = underlying as? Transaction.AdvancedCommerceInfo.Offer {
            return ProductSubscriptionPeriodWrapper(swiftValue: offer.period)
        }
        return nil
    }

    @objc public var periodCount: NSNumber {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let offer = underlying as? Transaction.AdvancedCommerceInfo.Offer {
            return NSNumber(value: offer.periodCount)
        }
        return NSNumber(value: 0)
    }

    @objc public var reason: TransactionAdvancedCommerceInfoOfferReasonWrapper? {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let offer = underlying as? Transaction.AdvancedCommerceInfo.Offer {
            return TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: offer.reason)
        }
        return nil
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Offer.Reason
@objc(TransactionAdvancedCommerceInfoOfferReason)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoOfferReasonWrapper: NSObject {

    private let underlying: Any?

    @objc public let rawValue: String

    /// Runtime-safe initializer
    public init?(swiftValue: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            guard let reason = swiftValue as? Transaction.AdvancedCommerceInfo.Offer.Reason else {
                return nil
            }
            self.underlying = reason
            self.rawValue = reason.rawValue
        } else {
            // Older OS versions cannot wrap, store a placeholder if needed
            self.underlying = nil
            self.rawValue = "unknown"
        }
        super.init()
    }

    /// Convenience static instances
    @objc public static var acquisition: TransactionAdvancedCommerceInfoOfferReasonWrapper {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            return TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: Transaction.AdvancedCommerceInfo.Offer.Reason.acquisition)!
        } else {
            return TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: nil)!
        }
    }

    @objc public static var retention: TransactionAdvancedCommerceInfoOfferReasonWrapper {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            return TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: Transaction.AdvancedCommerceInfo.Offer.Reason.retention)!
        } else {
            return TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: nil)!
        }
    }

    @objc public static var winBack: TransactionAdvancedCommerceInfoOfferReasonWrapper {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            return TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: Transaction.AdvancedCommerceInfo.Offer.Reason.winBack)!
        } else {
            return TransactionAdvancedCommerceInfoOfferReasonWrapper(swiftValue: nil)!
        }
    }

    @objc public func isEqualToReason(_ other: TransactionAdvancedCommerceInfoOfferReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Refund
@objc(TransactionAdvancedCommerceInfoRefund)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoRefundWrapper: NSObject {
    private let underlying: Any?
    
    @objc public let reason: TransactionAdvancedCommerceInfoRefundReasonWrapper?
    @objc public let type: TransactionAdvancedCommerceInfoRefundTypeWrapper?
    @objc public let date: Date
    @objc public let amount: NSDecimalNumber
    
    public init?(swiftValue: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let refund = swiftValue as? Transaction.AdvancedCommerceInfo.Refund {

            self.underlying = refund
            self.reason = TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: refund.reason)
            self.type = TransactionAdvancedCommerceInfoRefundTypeWrapper(swiftValue: refund.type)
            self.date = refund.date
            self.amount = refund.amount as NSDecimalNumber

        } else {
            // Unsupported OS: provide safe defaults
            self.underlying = nil
            self.reason = TransactionAdvancedCommerceInfoRefundReasonWrapper(swiftValue: nil)!
            self.type = TransactionAdvancedCommerceInfoRefundTypeWrapper(swiftValue: nil)!
            self.date = Date.distantPast
            self.amount = NSDecimalNumber.zero
        }

        super.init()
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Refund.Reason
@objc(TransactionAdvancedCommerceInfoRefundReason)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoRefundReasonWrapper: NSObject {

    private let raw: String

    public init?(swiftValue: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let reason = swiftValue as? Transaction.AdvancedCommerceInfo.Refund.Reason {
            self.raw = reason.rawValue
        } else {
            // Unsupported OS: return a generic "unknown" reason
            self.raw = "unknown"
        }
        super.init()
    }

    /// Fallback initializer from raw string for ObjC
    @objc public init(rawValue: String) {
        self.raw = rawValue
        super.init()
    }

    @objc public var rawValue: String { raw }

    // ObjC-friendly constants
    @objc public static let legal = TransactionAdvancedCommerceInfoRefundReasonWrapper(rawValue: "legal")
    @objc public static let modifyItems = TransactionAdvancedCommerceInfoRefundReasonWrapper(rawValue: "modifyItems")
    @objc public static let unintended = TransactionAdvancedCommerceInfoRefundReasonWrapper(rawValue: "unintended")
    @objc public static let unfulfilled = TransactionAdvancedCommerceInfoRefundReasonWrapper(rawValue: "unfulfilled")
    @objc public static let unsatisfied = TransactionAdvancedCommerceInfoRefundReasonWrapper(rawValue: "unsatisfied")
    @objc public static let other = TransactionAdvancedCommerceInfoRefundReasonWrapper(rawValue: "other")
    @objc public static let unknown = TransactionAdvancedCommerceInfoRefundReasonWrapper(rawValue: "unknown")

    @objc public func isEqualToReason(_ other: TransactionAdvancedCommerceInfoRefundReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - Transaction.AdvancedCommerceInfo.Refund.Type
@objc(TransactionAdvancedCommerceInfoRefundType)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class TransactionAdvancedCommerceInfoRefundTypeWrapper: NSObject {

    private let raw: String

    /// Runtime-safe initializer from Swift RefundType
    public init?(swiftValue: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let type = swiftValue as? Transaction.AdvancedCommerceInfo.Refund.RefundType {
            self.raw = type.rawValue
        } else {
            self.raw = "unknown"
        }
        super.init()
    }

    /// Fallback initializer from raw string for ObjC
    @objc public init(rawValue: String) {
        self.raw = rawValue
        super.init()
    }

    @objc public var rawValue: String { raw }

    // ObjC-friendly constants
    @objc public static let custom = TransactionAdvancedCommerceInfoRefundTypeWrapper(rawValue: "custom")
    @objc public static let proRated = TransactionAdvancedCommerceInfoRefundTypeWrapper(rawValue: "proRated")
    @objc public static let full = TransactionAdvancedCommerceInfoRefundTypeWrapper(rawValue: "full")
    @objc public static let unknown = TransactionAdvancedCommerceInfoRefundTypeWrapper(rawValue: "unknown")

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
    case ineligible = 2
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
        case .ineligible: code = .ineligible
        default: code = .unknown
        }
    }
    
    // MARK: - LocalizedError bridging
    @objc public var errorDescription: String? {
        if #available(iOS 15.4, macCatalyst 15.4, *) {
            swiftError.errorDescription
        } else {
            "Unsupported on the OS version"
        }
    }

    @objc public var failureReason: String? {
        if #available(iOS 15.4, macCatalyst 15.4, *) {
            swiftError.failureReason
        } else {
            "Unsupported on the OS version"
        }
    }

    @objc public var recoverySuggestion: String? {
        if #available(iOS 15.4, macCatalyst 15.4, *) {
            swiftError.recoverySuggestion
        } else {
            "Unsupported on the OS version"
        }
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
