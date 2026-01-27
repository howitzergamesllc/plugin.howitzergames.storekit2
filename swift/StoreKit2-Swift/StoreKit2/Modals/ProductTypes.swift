//
//  ProductKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - ProductType
@objc(ProductType)
@available(iOS 15.0, tvOS 15.0, macOS 12.0, *)
public final class ProductTypeWrapper: NSObject {

    @objc public let rawValue: String

    // Swift → ObjC convenience init
    public init(swiftValue: Product.ProductType) {
        self.rawValue = swiftValue.rawValue
    }

    // ObjC → Swift init
    @objc public init(rawValue: String) {
        self.rawValue = rawValue
    }

    // Static values
    @objc public static var consumable: ProductTypeWrapper {
        ProductTypeWrapper(swiftValue: Product.ProductType.consumable)
    }

    @objc public static var nonConsumable: ProductTypeWrapper {
        ProductTypeWrapper(swiftValue: Product.ProductType.nonConsumable)
    }

    @objc public static var nonRenewable: ProductTypeWrapper {
        ProductTypeWrapper(swiftValue: Product.ProductType.nonRenewable)
    }

    @objc public static var autoRenewable: ProductTypeWrapper {
        ProductTypeWrapper(swiftValue: Product.ProductType.autoRenewable)
    }

    // Allow equality testing
    @objc public func isEqualToType(_ other: ProductTypeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }

    // Swift helper for converting back
    public var swiftValue: Product.ProductType {
        Product.ProductType(rawValue: rawValue)
    }
}

// MARK: - SubscriptionUnit
@objc(Unit)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public enum UnitWrapper: Int {
    case day
    case week
    case month
    case year
    case unknown
}

// MARK: - SubscriptionPeriod
@objc(ProductSubscriptionPeriod)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ProductSubscriptionPeriodWrapper: NSObject {

    private let period: Product.SubscriptionPeriod

    public init(swiftValue: Product.SubscriptionPeriod) {
        self.period = swiftValue
    }
    
    @objc
    public var unit: UnitWrapper {
        switch period.unit {
        case .day: return .day
        case .week: return .week
        case .month: return .month
        case .year: return .year
        @unknown default: return .unknown
        }
    }

    @objc
    public var value: Int {
        period.value
    }
}

// MARK: - SubscriptionInfo
@objc(ProductSubscriptionInfo)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ProductSubscriptionInfoWrapper: NSObject {
    
    private let info: Product.SubscriptionInfo
    
    public init(swiftValue: Product.SubscriptionInfo) {
        self.info = swiftValue
    }
    
    @objc
    public var introductoryOffer: ProductSubscriptionOfferWrapper? {
        guard let intro = info.introductoryOffer else { return nil }
        return ProductSubscriptionOfferWrapper(swiftValue: intro)
    }
    
    @objc
    public var promotionalOffers: NSArray {
        info.promotionalOffers
            .map { ProductSubscriptionOfferWrapper(swiftValue: $0) }
        as NSArray
    }
    
    @objc
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    public var winBackOffers: NSArray {
        info.winBackOffers
            .map { ProductSubscriptionOfferWrapper(swiftValue: $0) }
        as NSArray
    }
    
    @objc
    public var subscriptionGroupID: String {
        info.subscriptionGroupID
    }
    
    @objc
    public var subscriptionPeriod: ProductSubscriptionPeriodWrapper {
        ProductSubscriptionPeriodWrapper(swiftValue: info.subscriptionPeriod)
    }
    
    /// Bridges the async `isEligibleForIntroOfferAsync
    @objc
    public func isEligibleForIntroOfferAsync(
        completion: @escaping (Bool) -> Void
    ) {
        Task {
            let eligible = await info.isEligibleForIntroOffer
            completion(eligible)
        }
    }
    
    /// Bridges the async static API:
    /// `SubscriptionInfo.isEligibleForIntroOffer(for:)`
    @objc
    public static func isEligibleForIntroOfferAsync(
        forGroupID groupID: String,
        completion: @escaping (Bool) -> Void
    ) {
        Task {
            let eligible = await Product.SubscriptionInfo.isEligibleForIntroOffer(for: groupID)
            completion(eligible)
        }
    }
    
    @objc
    public func statusAsync(
        _ completion: @escaping ([SubscriptionStatusWrapper]?, NSError?) -> Void
    ) {
        Task {
            do {
                let values = try await info.status
                completion(values.map { SubscriptionStatusWrapper(swiftValue: $0) }, nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
    
    @objc
    public static func statusForGroupIDAsync(
        _ groupID: String,
        completion: @escaping ([SubscriptionStatusWrapper]?, NSError?) -> Void
    ) {
        Task {
            do {
                let values = try await Product.SubscriptionInfo.status(for: groupID)
                completion(values.map { SubscriptionStatusWrapper(swiftValue: $0) }, nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
    
    @objc
    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public static func statusForTransactionIDAsync(
        _ transactionID: NSNumber,
        completion: @escaping (SubscriptionStatusWrapper?, NSError?) -> Void
    ) {
        Task {
            do {
                let result = try await Product.SubscriptionInfo
                    .status(transactionID: transactionID.uint64Value)
                
                if let result {
                    completion(SubscriptionStatusWrapper(swiftValue: result), nil)
                } else {
                    completion(nil, nil)
                }
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
    
    @objc
    @available(iOS 16.4, macOS 13.3, tvOS 16.4, *)
    public var groupLevelValue: NSInteger {
        info.groupLevel
    }
    
    @objc
    @available(iOS 16.4, macOS 13.3, tvOS 16.4, *)
    public var groupDisplayName: String {
        info.groupDisplayName
    }
    
    @objc
    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public static func updateAsync(
        completion: @escaping ([SubscriptionStatusWrapper]) -> Void
    ) {
        Task {
            var results: [SubscriptionStatusWrapper] = []
            var iterator = Product.SubscriptionInfo.Status.updates.makeAsyncIterator()
            while let status = await iterator.next() {
                results.append(SubscriptionStatusWrapper(swiftValue: status))
            }
            completion(results)
        }
    }
    
    @objc
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
    public static func allStatusesAsync(
        completion: @escaping ([NSString: [SubscriptionStatusWrapper]]) -> Void
    ) {
        Task {
            var results: [NSString: [SubscriptionStatusWrapper]] = [:]

            for await (groupID, statuses) in Product.SubscriptionInfo.Status.all {
                let wrapped = statuses.map { SubscriptionStatusWrapper(swiftValue: $0) }
                results[groupID as NSString] = wrapped
            }

            completion(results)
        }
    }
}

// MARK: - Visibility
@objc(Visibility)
@available(iOS 16.4, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public enum VisibilityWrapper: Int {
    case appStoreConnectDefault
    case visible
    case hidden
}

// MARK: - PromotionInfo
@objc(PromotionInfo)
@available(iOS 16.4, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public final class PromotionInfoWrapper: NSObject {

    let promotion: Product.PromotionInfo

    public init(_ promotion: Product.PromotionInfo) {
        self.promotion = promotion
    }

    @objc
    public var productID: String {
        promotion.productID
    }

    @objc
    public var visibility: VisibilityWrapper {
        switch promotion.visibility {
        case .appStoreConnectDefault: return .appStoreConnectDefault
        case .visible: return .visible
        case .hidden: return .hidden
        @unknown default: return .appStoreConnectDefault
        }
    }

    @objc
    public func updateAsync(_ completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                try await promotion.update()
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }

    @objc
    public class func currentOrderAsync(_ completion: @escaping ([PromotionInfoWrapper]?, NSError?) -> Void) {
        Task {
            do {
                let promos = try await Product.PromotionInfo.currentOrder
                completion(promos.map { PromotionInfoWrapper($0) }, nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }

    @objc
    public class func updateProductOrderAsync(byID order: [String], completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                try await Product.PromotionInfo.updateProductOrder(byID: order)
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }

    @objc
    public class func updateProductVisibilityAsync(_ visibility: VisibilityWrapper, for productID: String, completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                let swiftVisibility: Product.PromotionInfo.Visibility
                switch visibility {
                case .appStoreConnectDefault: swiftVisibility = .appStoreConnectDefault
                case .visible: swiftVisibility = .visible
                case .hidden: swiftVisibility = .hidden
                @unknown default: swiftVisibility = .appStoreConnectDefault
                }

                try await Product.PromotionInfo.updateProductVisibility(swiftVisibility, for: productID)
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }

    @objc
    public class func updateAllAsync(_ promotions: [PromotionInfoWrapper], completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                let swiftPromotions = promotions.map { $0.promotion }
                try await Product.PromotionInfo.updateAll(swiftPromotions)
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }
}

// MARK: - PurchaseOptions
@objc(ProductPurchaseOptions)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ProductPurchaseOptionsWrapper: NSObject {

    /// The underlying Swift PurchaseOption
    let underlying: Product.PurchaseOption

    init(_ option: Product.PurchaseOption) {
        self.underlying = option
        super.init()
    }

    /// Access the underlying Swift PurchaseOption
    var swiftOption: Product.PurchaseOption { underlying }

    @objc public static func appAccountToken(_ uuid: NSUUID) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.appAccountToken(uuid as UUID))
    }

    @objc public static func customString(key: String, value: String) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.custom(key: key, value: value))
    }

    @objc public static func customDouble(key: String, value: Double) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.custom(key: key, value: value))
    }

    @objc public static func customBool(key: String, value: Bool) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.custom(key: key, value: value))
    }

    @objc public static func customData(key: String, value: Data) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.custom(key: key, value: value))
    }
    
    /// Obj-C factory for onStorefrontChange
    @objc public static func onStorefrontChange(
        shouldContinuePurchase: @escaping @convention(block) (StoreFrontWrapper) -> Bool
    ) -> ProductPurchaseOptionsWrapper {

        // Wrap the Swift PurchaseOption closure
        let option = Product.PurchaseOption.onStorefrontChange { storefront in
            let wrapper = StoreFrontWrapper(storefront)
            return shouldContinuePurchase(wrapper)
        }

        return ProductPurchaseOptionsWrapper(option)
    }
    
    @objc public static func quantity(_ quantity: Int) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.quantity(quantity))
    }

    @objc public static func simulateAskToBuy(_ simulate: Bool) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.simulatesAskToBuyInSandbox(simulate))
    }
    

    @objc public static func promotionalOfferLegacy(
        offerID: String,
        keyID: String,
        nonce: NSUUID,
        signature: Data,
        timestamp: Int
    ) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(
            Product.PurchaseOption.promotionalOffer(
                offerID: offerID,
                keyID: keyID,
                nonce: nonce as UUID,
                signature: signature,
                timestamp: timestamp
            )
        )
    }
    
    @objc
    @available(iOS, introduced: 15.0, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    @available(macOS, introduced: 12.0, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    @available(tvOS, introduced: 15.0, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    public static func promotionalOffer(
        offerID: String,
        keyID: String,
        nonce: NSUUID,
        signature: Data,
        timestamp: Int
    ) -> ProductPurchaseOptionsWrapper {
        let option = Product.PurchaseOption.promotionalOffer(
            offerID: offerID,
            keyID: keyID,
            nonce: nonce as UUID,
            signature: signature,
            timestamp: timestamp
        )
        return ProductPurchaseOptionsWrapper(option)
    }
    
    @objc
    @available(iOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    @available(macOS, introduced: 14.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    @available(tvOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    public static func promotionalOffer(
        offerID: String,
        signature: SubscriptionOfferSignatureWrapper
    ) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(
            Product.PurchaseOption.promotionalOffer(offerID: offerID, signature: signature.swiftSignature)
        )
    }

    @objc public static func promotionalOffer(
        offerID: String,
        compactJWS: String
    ) -> [ProductPurchaseOptionsWrapper] {
        let options = Product.PurchaseOption.promotionalOffer(offerID, compactJWS: compactJWS)
        return options.map { ProductPurchaseOptionsWrapper($0) }
    }
    
    @objc
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    public static func winBackOffer(_ offer: ProductSubscriptionOfferWrapper) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(
            Product.PurchaseOption.winBackOffer(offer.offer)
        )
    }

    @objc public static func introductoryOfferEligibility(compactJWS: String) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.introductoryOfferEligibility(compactJWS: compactJWS))
    }

    @objc public func isEqualToOptions(_ other: ProductPurchaseOptionsWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.underlying == other.underlying
    }
}

// MARK: - PurchaseResult
@objc(ProductPurchaseResult)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ProductPurchaseResultWrapper: NSObject {

    /// Underlying Swift PurchaseResult
    private let underlying: Product.PurchaseResult
    
    @objc public var verificationresult: TransactionVerificationResultWrapper?

    init(_ result: Product.PurchaseResult) {
        self.underlying = result
        self.verificationresult = nil
        // Populate the verification result when the purchase is successful
        if case .success(let verificationResult) = underlying {
            // Initialize the verification result with the verification data
            verificationresult = TransactionVerificationResultWrapper(verification: verificationResult)
        }
    }

    /// Returns true if the purchase succeeded
    @objc public var isSuccess: Bool {
        if case .success = underlying { return true }
        return false
    }

    /// Returns true if the user cancelled the purchase
    @objc public var isUserCancelled: Bool {
        if case .userCancelled = underlying { return true }
        return false
    }

    /// Returns true if the purchase is pending
    @objc public var isPending: Bool {
        if case .pending = underlying { return true }
        return false
    }
}

// MARK: - PurchaseErrorCode
@objc(PurchaseErrorCode)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public enum ProductPurchaseErrorCode: Int {
    case invalidQuantity
    case productUnavailable
    case purchaseNotAllowed
    case ineligibleForOffer
    case invalidOfferIdentifier
    case invalidOfferPrice
    case invalidOfferSignature
    case missingOfferParameters
    case unknown
}

// MARK: - PurchaseError
@objc(PurchaseError)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ProductPurchaseErrorWrapper: NSObject {

    @objc public let code: ProductPurchaseErrorCode

    private let swiftError: Product.PurchaseError
    
    public init(swiftError: Product.PurchaseError) {
        // Map Swift enum to NS_ENUM
        self.swiftError = swiftError
        switch swiftError {
        case .invalidQuantity: code = .invalidQuantity
        case .productUnavailable: code = .productUnavailable
        case .purchaseNotAllowed: code = .purchaseNotAllowed
        case .ineligibleForOffer: code = .ineligibleForOffer
        case .invalidOfferIdentifier: code = .invalidOfferIdentifier
        case .invalidOfferPrice: code = .invalidOfferPrice
        case .invalidOfferSignature: code = .invalidOfferSignature
        case .missingOfferParameters: code = .missingOfferParameters
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

// MARK: - SubscriptionOfferType
@objc(SubscriptionOfferType)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class SubscriptionOfferTypeWrapper: NSObject {

    @objc public let rawValue: String

    public init(swiftValue: Product.SubscriptionOffer.OfferType) {
        self.rawValue = swiftValue.rawValue
    }

    @objc public init(rawValue: String) {
        self.rawValue = rawValue
    }

    @objc public static var introductory: SubscriptionOfferTypeWrapper {
        SubscriptionOfferTypeWrapper(swiftValue: .introductory)
    }

    @objc public static var promotional: SubscriptionOfferTypeWrapper {
        SubscriptionOfferTypeWrapper(swiftValue: .promotional)
    }

    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    @objc public static var winBack: SubscriptionOfferTypeWrapper {
        SubscriptionOfferTypeWrapper(swiftValue: .winBack)
    }

    public var swiftValue: Product.SubscriptionOffer.OfferType {
        Product.SubscriptionOffer.OfferType(rawValue: rawValue)
    }

    @objc public func isEqualToType(_ other: SubscriptionOfferTypeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - SubscriptionOfferPaymentMode
@objc(SubscriptionOfferPaymentMode)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class SubscriptionOfferPaymentModeWrapper: NSObject {

    @objc public let rawValue: String

    public init(swiftValue: Product.SubscriptionOffer.PaymentMode) {
        self.rawValue = swiftValue.rawValue
    }

    @objc public init(rawValue: String) {
        self.rawValue = rawValue
    }

    @objc public static var payAsYouGo: SubscriptionOfferPaymentModeWrapper {
        SubscriptionOfferPaymentModeWrapper(swiftValue: .payAsYouGo)
    }

    @objc public static var payUpFront: SubscriptionOfferPaymentModeWrapper {
        SubscriptionOfferPaymentModeWrapper(swiftValue: .payUpFront)
    }

    @objc public static var freeTrial: SubscriptionOfferPaymentModeWrapper {
        SubscriptionOfferPaymentModeWrapper(swiftValue: .freeTrial)
    }

    public var swiftValue: Product.SubscriptionOffer.PaymentMode {
        Product.SubscriptionOffer.PaymentMode(rawValue: rawValue)
    }

    @objc public func isEqualToMode(_ other: SubscriptionOfferPaymentModeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - SubscriptionOfferSignatureWrapper
@objc(SubscriptionOfferSignature)
@available(iOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")
@available(macOS, introduced: 14.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")
@available(tvOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")
public final class SubscriptionOfferSignatureWrapper: NSObject {

    @objc public let keyID: String
    @objc public let nonce: NSUUID
    @objc public let timestamp: NSNumber
    @objc public let signatureData: Data

    public let swiftSignature: Product.SubscriptionOffer.Signature

    public init(swiftSignature: Product.SubscriptionOffer.Signature) {
        self.swiftSignature = swiftSignature
        self.keyID = swiftSignature.keyID
        self.nonce = swiftSignature.nonce as NSUUID
        self.timestamp = NSNumber(value: swiftSignature.timestamp)
        self.signatureData = swiftSignature.signature
        super.init()
    }
    
    /// Factory method to create a wrapper from raw components
    @objc public static func from(
        keyID: String,
        nonce: NSUUID,
        timestamp: NSNumber,
        signatureData: Data
    ) -> SubscriptionOfferSignatureWrapper {
        let swiftSig = Product.SubscriptionOffer.Signature(
            keyID: keyID,
            nonce: nonce as UUID,
            timestamp: timestamp.intValue,
            signature: signatureData
        )
        return SubscriptionOfferSignatureWrapper(swiftSignature: swiftSig)
    }
}

// MARK: - SubcriptionOffer
@objc(SubscriptionOffer)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ProductSubscriptionOfferWrapper: NSObject {

    public let offer: Product.SubscriptionOffer

    public init(swiftValue: Product.SubscriptionOffer) {
        self.offer = swiftValue
    }

    /// The offer's identifier (nil for introductory offers).
    @objc
    public var offerId: String? {
        offer.id
    }

    /// Wrapper for the offer type (introductory/promotional/winBack/...).
    @objc
    public var offerType: SubscriptionOfferTypeWrapper {
        SubscriptionOfferTypeWrapper(swiftValue: offer.type)
    }

    /// Wrapper for the payment mode (payAsYouGo/payUpFront/freeTrial).
    @objc
    public var paymentMode: SubscriptionOfferPaymentModeWrapper {
        SubscriptionOfferPaymentModeWrapper(swiftValue: offer.paymentMode)
    }

    /// The offer period count.
    @objc
    public var periodCount: Int {
        offer.periodCount
    }

    /// Subscription period wrapped for Obj-C.
    @objc
    public var period: ProductSubscriptionPeriodWrapper {
        ProductSubscriptionPeriodWrapper(swiftValue: offer.period)
    }

    /// Localized formatted price.
    @objc
    public var displayPrice: String {
        offer.displayPrice
    }

    /// Numeric price exposed as NSDecimalNumber.
    @objc
    public var price: NSDecimalNumber {
        offer.price as NSDecimalNumber
    }
}

// MARK: - RenewalState
@objc(RenewalState)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class RenewalStateWrapper: NSObject {
    
    @objc public let rawValue: Int
    
    @objc public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    @objc public static let subscribed = RenewalStateWrapper(rawValue: Product.SubscriptionInfo.RenewalState.subscribed.rawValue)
    @objc public static let expired = RenewalStateWrapper(rawValue: Product.SubscriptionInfo.RenewalState.expired.rawValue)
    @objc public static let inBillingRetryPeriod = RenewalStateWrapper(rawValue: Product.SubscriptionInfo.RenewalState.inBillingRetryPeriod.rawValue)
    @objc public static let inGracePeriod = RenewalStateWrapper(rawValue: Product.SubscriptionInfo.RenewalState.inGracePeriod.rawValue)
    @objc public static let revoked = RenewalStateWrapper(rawValue: Product.SubscriptionInfo.RenewalState.revoked.rawValue)
    
    @objc public func isEqualToState(_ other: RenewalStateWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - ExpirationReason
@objc(ExpirationReason)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ExpirationReasonWrapper: NSObject {
    
    @objc public let rawValue: Int
    
    @objc public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    @objc public static let autoRenewDisabled = ExpirationReasonWrapper(
        rawValue: Product.SubscriptionInfo.RenewalInfo.ExpirationReason.autoRenewDisabled.rawValue
    )
    
    @objc public static let billingError = ExpirationReasonWrapper(
        rawValue: Product.SubscriptionInfo.RenewalInfo.ExpirationReason.billingError.rawValue
    )
    
    @objc public static let didNotConsentToPriceIncrease = ExpirationReasonWrapper(
        rawValue: Product.SubscriptionInfo.RenewalInfo.ExpirationReason.didNotConsentToPriceIncrease.rawValue
    )
    
    @objc public static let productUnavailable = ExpirationReasonWrapper(
        rawValue: Product.SubscriptionInfo.RenewalInfo.ExpirationReason.productUnavailable.rawValue
    )
    
    @objc public static let unknown = ExpirationReasonWrapper(
        rawValue: Product.SubscriptionInfo.RenewalInfo.ExpirationReason.unknown.rawValue
    )
    
    @objc public func isEqualToReason(_ other: ExpirationReasonWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - PriceIncreaseStatus
@objc(PriceIncreaseStatus)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public enum PriceIncreaseStatusWrapper: Int {
    case noIncreasePending = 0
    case pending = 1
    case agreed = 2
    case unknown = -1
}

// MARK: - RenewalInfo
@objc(RenewalInfo)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class RenewalInfoWrapper: NSObject {

    private let info: Product.SubscriptionInfo.RenewalInfo

    // MARK: - Init

    public init(renewalInfo: Product.SubscriptionInfo.RenewalInfo) {
        self.info = renewalInfo
    }

    @objc public var originalTransactionID: NSNumber {
        NSNumber(value: info.originalTransactionID)
    }

    @objc public var currentProductID: String {
        info.currentProductID
    }

    @objc public var willAutoRenew: Bool {
        info.willAutoRenew
    }

    @objc public var autoRenewPreference: String? {
        info.autoRenewPreference
    }

    @objc public var expirationReason: ExpirationReasonWrapper {
        guard let reason = info.expirationReason else {
            return .unknown  // default value in your wrapper enum
        }
        return ExpirationReasonWrapper(rawValue: reason.rawValue)
    }
    
    @objc public var priceIncreaseStatus: PriceIncreaseStatusWrapper {
        let swiftStatus = info.priceIncreaseStatus
        switch swiftStatus {
        case .noIncreasePending:
            return .noIncreasePending
        case .pending:
            return .pending
        case .agreed:
            return .agreed
        @unknown default:
            return .unknown
        }
    }

    @objc public var isInBillingRetry: Bool {
        info.isInBillingRetry
    }

    @objc public var gracePeriodExpirationDate: Date? {
        info.gracePeriodExpirationDate
    }

    @objc public var offerID: String? {
        info.offerID
    }
    
    @objc
    public var offerType: TransactionOfferTypeWrapper {
        guard let ot = info.offerType else {
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


    @objc public var environmentStringRepresentation: String {
        info.environmentStringRepresentation
    }

    @objc public var recentSubscriptionStartDate: Date {
        info.recentSubscriptionStartDate
    }

    @objc public var renewalDate: Date? {
        info.renewalDate
    }

    @objc public var renewalPrice: NSDecimalNumber? {
        info.renewalPrice.map { NSDecimalNumber(decimal: $0) }
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
        info.currencyCode
    }
    
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    @objc public var eligibleWinBackOfferIDs: NSArray {
        return info.eligibleWinBackOfferIDs.map { $0 as NSString } as NSArray
    }

    @objc public var deviceVerification: Data {
        info.deviceVerification
    }

    @objc public var deviceVerificationNonce: UUID {
        info.deviceVerificationNonce
    }

    @objc public var signedDate: Date {
        info.signedDate
    }
    
    @objc
    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public var advancedCommerceInfo: SubscriptionAdvancedCommerceInfoWrapper? {
        guard let info = info.advancedCommerceInfo else { return nil }
        return SubscriptionAdvancedCommerceInfoWrapper(swiftInfo: info)
    }

    @objc public var appAccountToken: NSUUID? {
        info.appAccountToken.map { $0 as NSUUID }
    }

    @objc public var appTransactionID: String {
        info.appTransactionID
    }
}

// MARK: - StatusWrapper
@objc(SubscriptionStatus)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class SubscriptionStatusWrapper: NSObject {
    private let status: Product.SubscriptionInfo.Status
    @objc public let state: RenewalStateWrapper
    @objc public let transaction: TransactionVerificationResultWrapper
    @objc public let renewalInfo: RenewalInfoVerificationResultWrapper

    public init(swiftValue: Product.SubscriptionInfo.Status) {

        self.status = swiftValue
        
        // Convert the Swift enum → NSNumber / Int
        self.state = RenewalStateWrapper(rawValue: swiftValue.state.rawValue)

        // Rewrap using your custom wrappers
        self.transaction = TransactionVerificationResultWrapper(
            verification: status.transaction
        )

        self.renewalInfo = RenewalInfoVerificationResultWrapper(
            verification: status.renewalInfo
        )

        super.init()
    }
    
    @objc public func isEqualToStatus(_ other: SubscriptionStatusWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.status == other.status
    }
}

// MARK: - SubscriptionAdvancedCommerceItemWrapper
@objc(SubscriptionAdvancedCommerceItem)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class SubscriptionAdvancedCommerceItemWrapper: NSObject {

    // Wrap the underlying Swift struct
    @objc public let details: TransactionAdvancedCommerceInfoItemDetailsWrapper

    // Initialize from Swift type
    public init(swiftItem: Product.SubscriptionInfo.RenewalInfo.AdvancedCommerceInfo.Item) {
        // Wrap the details struct properly
        self.details = TransactionAdvancedCommerceInfoItemDetailsWrapper(swiftValue: swiftItem.details)
        super.init()
    }
}

// MARK: - AdvancedCommerceInfoWrapper
@objc(SubcriptionAdvancedCommerceInfo)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class SubscriptionAdvancedCommerceInfoWrapper: NSObject {

    @objc public let consistencyToken: String
    @objc public let requestReferenceID: String
    @objc public let taxCode: String
    @objc public let descriptionText: String
    @objc public let displayName: String
    @objc public let period: ProductSubscriptionPeriodWrapper
    @objc public let items: [SubscriptionAdvancedCommerceItemWrapper]

    public init(swiftInfo: Product.SubscriptionInfo.RenewalInfo.AdvancedCommerceInfo) {
        self.consistencyToken = swiftInfo.consistencyToken
        self.requestReferenceID = swiftInfo.requestReferenceID
        self.taxCode = swiftInfo.taxCode
        self.descriptionText = swiftInfo.description
        self.displayName = swiftInfo.displayName
        self.period = ProductSubscriptionPeriodWrapper(swiftValue: swiftInfo.period)
        self.items = swiftInfo.items.map { SubscriptionAdvancedCommerceItemWrapper(swiftItem: $0) }

        super.init()
    }
}
