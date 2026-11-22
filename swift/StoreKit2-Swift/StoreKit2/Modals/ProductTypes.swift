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
    
    @objc public static var subscriptionBundle: ProductTypeWrapper {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) {
            return ProductTypeWrapper(swiftValue: Product.ProductType.subscriptionBundle)
        }
        return ProductTypeWrapper(rawValue: "unsupported")
    }

    @objc public static var subscriptionSuite: ProductTypeWrapper {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) {
            return ProductTypeWrapper(swiftValue: Product.ProductType.subscriptionSuite)
        }
        return ProductTypeWrapper(rawValue: "unsupported")
    }
    
    @objc public static var unknown: ProductTypeWrapper {
        ProductTypeWrapper(rawValue: "unknown")
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
    //@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    public var winBackOffers: NSArray {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, *) {
            return info.winBackOffers
                .map { ProductSubscriptionOfferWrapper(swiftValue: $0) }
            as NSArray
        } else {
            return []
        }
    }
    
    @objc
    public var subscriptionGroupID: String {
        info.subscriptionGroupID
    }
    
    @objc
    public var subscriptionPeriod: ProductSubscriptionPeriodWrapper {
        ProductSubscriptionPeriodWrapper(swiftValue: info.subscriptionPeriod)
    }
    
    @objc
    public var pricingTerms: [PricingTermsWrapper] {
        guard #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) else {
            return []
        }

        return info.pricingTerms.compactMap {
            PricingTermsWrapper(swiftValue: $0)
        }
    }
    
    @objc
    public var bundledSubscriptions: [BundledSubscriptionWrapper] {
        guard #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) else {
            return []
        }

        return info.bundledSubscriptions.compactMap {
            BundledSubscriptionWrapper(swiftValue: $0)
        }
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
    //@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public static func statusForTransactionIDAsync(
        _ transactionID: NSNumber,
        completion: @escaping (SubscriptionStatusWrapper?, NSError?) -> Void
    ) {
        guard #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) else {
            completion(nil, NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey : "Requires iOS 18.4+"]))
            return
        }
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
    //@available(iOS 16.4, macOS 13.4, tvOS 16.4, *)
    public var groupLevelValue: NSInteger {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, *) {
            return info.groupLevel
        } else {
            return 0
        }
    }
    
    @objc
    //@available(iOS 16.4, macOS 13.4, tvOS 16.4, *)
    public var groupDisplayName: String {
        if #available(iOS 16.4, macOS 13.3, tvOS 16.4, *) {
            return info.groupDisplayName
        } else {
            return "Unsupported on this OS Version"
        }
    }
    
    @objc
    //@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public static func updateAsync(
        completion: @escaping ([SubscriptionStatusWrapper]) -> Void
    ) {
        guard #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) else {
            completion([])
            return
        }
        
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
    //@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
    public static func allStatusesAsync(
        completion: @escaping ([NSString: [SubscriptionStatusWrapper]]) -> Void
    ) {
        guard #available(iOS 17.0, macOS 14.0, tvOS 17.0, *) else {
            completion([:])
            return
        }
        
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

// MARK: - PricingTerms
@objc(PricingTerms)
//(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *)
public final class PricingTermsWrapper: NSObject {

    @objc public let billingPrice: NSDecimalNumber
    @objc public let billingDisplayPrice: String
    @objc public let billingPeriod: ProductSubscriptionPeriodWrapper
    @objc public let billingPlanType: BillingPlanTypeWrapper
    @objc public let commitmentInfo: CommitmentInfoWrapper?
    @objc public let subscriptionOffers: [ProductSubscriptionOfferWrapper]

    @nonobjc public init?(swiftValue: Any?) {

        guard #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) else {
            return nil
        }

        guard let terms = swiftValue as? Product.SubscriptionInfo.PricingTerms else {
            return nil
        }

        self.billingPrice = NSDecimalNumber(decimal: terms.billingPrice)
        self.billingDisplayPrice = terms.billingDisplayPrice
        self.billingPeriod = ProductSubscriptionPeriodWrapper(
            swiftValue: terms.billingPeriod
        )
        self.billingPlanType = BillingPlanTypeWrapper(swiftValue: terms.billingPlanType)
        self.commitmentInfo = CommitmentInfoWrapper(swiftValue: terms.commitmentInfo)
        self.subscriptionOffers = terms.subscriptionOffers.compactMap {
            ProductSubscriptionOfferWrapper(swiftValue: $0)
        }
        super.init()
    }
}

// MARK: - BundledSubscription
@objc(BundledSubscription)
public final class BundledSubscriptionWrapper: NSObject {

    @objc public let id: String
    @objc public let displayName: String
    @objc public let subscriptionDescription: String
    @objc public let price: NSDecimalNumber
    @objc public let displayPrice: String
    @objc public let isFamilyShareable: Bool
    @objc public let subscriptionGroupID: String
    @objc public let subscriptionGroupLevel: Int
    @objc public let subscriptionGroupDisplayName: String

    @nonobjc public init?(swiftValue: Any?) {

        guard #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) else {
            return nil
        }

        guard let subscription = swiftValue as? Product.SubscriptionInfo.BundledSubscription else {
            return nil
        }

        self.id = subscription.id
        self.displayName = subscription.displayName
        self.subscriptionDescription = subscription.description
        self.price = NSDecimalNumber(decimal: subscription.price)
        self.displayPrice = subscription.displayPrice
        self.isFamilyShareable = subscription.isFamilyShareable
        self.subscriptionGroupID = subscription.subscriptionGroupID
        self.subscriptionGroupLevel = subscription.subscriptionGroupLevel
        self.subscriptionGroupDisplayName = subscription.subscriptionGroupDisplayName

        super.init()
    }
}

// MARK: - Visibility
@objc(Visibility)
//@available(iOS 16.4, *)@available(macOS, unavailable)@available(tvOS, unavailable)
public enum VisibilityWrapper: Int {
    case appStoreConnectDefault
    case visible
    case hidden
}

// MARK: - PromotionInfo
@objc(PromotionInfo)
//@available(iOS 16.4, *)@available(macOS, unavailable)@available(tvOS, unavailable)
public final class PromotionInfoWrapper: NSObject {

    private let promotion: Any

    public init?(swiftValue: Any?) {
        if #available(iOS 16.4, *) {
            if let promo = swiftValue as? Product.PromotionInfo {
                self.promotion = promo
                super.init()
            } else {
                return nil
            }
        } else {
            // Not supported on < iOS 16.4
            return nil
        }
    }

    @objc
    //@available(iOS 16.4, *)
    public var productID: String {
        if #available(iOS 16.4, *),
           let promo = promotion as? Product.PromotionInfo {
            return promo.productID
        }
        return "Unsupported on this OS version"
    }

    @objc
    //@available(iOS 16.4, *)
    public var visibility: VisibilityWrapper {
        if #available(iOS 16.4, *),
           let promo = promotion as? Product.PromotionInfo {

            switch promo.visibility {
            case .appStoreConnectDefault: return .appStoreConnectDefault
            case .visible: return .visible
            case .hidden: return .hidden
            @unknown default: return .appStoreConnectDefault
            }
        }
        return .appStoreConnectDefault
    }

    @objc
    //@available(iOS 16.4, *)
    public func updateAsync(_ completion: @escaping (NSError?) -> Void) {
        guard #available(iOS 16.4, *),
              let promo = promotion as? Product.PromotionInfo else {
            completion(NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Requires iOS 16.4+"]))
            return
        }

        Task {
            do {
                try await promo.update()
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple",code: 1001,userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }

    @objc
    //@available(iOS 16.4, *)
    public class func currentOrderAsync(
        _ completion: @escaping ([PromotionInfoWrapper]?, NSError?) -> Void
    ) {
        guard #available(iOS 16.4, *) else {
            completion(
                nil,
                NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: "Requires iOS 16.4+"]
                )
            )
            return
        }

        Task {
            do {
                let promos = try await Product.PromotionInfo.currentOrder
                let wrapped = promos.compactMap { PromotionInfoWrapper(swiftValue: $0) }
                completion(wrapped, nil)
            } catch {
                let nsError = NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                )
                completion(nil, nsError)
            }
        }
    }

    @objc
    //@available(iOS 16.4, *)
    public class func updateProductOrderAsync(
        byID order: [String],
        completion: @escaping (NSError?) -> Void
    ) {
        guard #available(iOS 16.4, *) else {
            completion(
                NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: "Requires iOS 16.4+"]
                )
            )
            return
        }

        Task {
            do {
                try await Product.PromotionInfo.updateProductOrder(byID: order)
                completion(nil)
            } catch {
                let nsError = NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                )
                completion(nsError)
            }
        }
    }
    
    @objc
    //@available(iOS 16.4, *)
    public class func updateProductVisibilityAsync(
        _ visibility: VisibilityWrapper,
        for productID: String,
        completion: @escaping (NSError?) -> Void
    ) {
        guard #available(iOS 16.4, *) else {
            completion(
                NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: "Requires iOS 16.4+"]
                )
            )
            return
        }

        Task {
            do {
                let swiftVisibility: Product.PromotionInfo.Visibility

                switch visibility {
                case .appStoreConnectDefault: swiftVisibility = .appStoreConnectDefault
                case .visible: swiftVisibility = .visible
                case .hidden: swiftVisibility = .hidden
                @unknown default: swiftVisibility = .appStoreConnectDefault
                }

                try await Product.PromotionInfo
                    .updateProductVisibility(swiftVisibility, for: productID)

                completion(nil)
            } catch {
                let nsError = NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                )
                completion(nsError)
            }
        }
    }

    @objc
    //@available(iOS 16.4, *)
    public class func updateAllAsync(
        _ promotions: [PromotionInfoWrapper],
        completion: @escaping (NSError?) -> Void
    ) {
        guard #available(iOS 16.4, *) else {
            completion(
                NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: "Requires iOS 16.4+"]
                )
            )
            return
        }

        Task {
            do {
                let swiftPromos = promotions.compactMap {
                    $0.promotion as? Product.PromotionInfo
                }
                try await Product.PromotionInfo.updateAll(swiftPromos)
                completion(nil)
            } catch {
                let nsError = NSError(
                    domain: "maui.storekit2.apple",
                    code: 1001,
                    userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
                )
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
    
    @objc public static func billingPlanType(_ type: BillingPlanTypeWrapper) -> ProductPurchaseOptionsWrapper? {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            return ProductPurchaseOptionsWrapper(
                Product.PurchaseOption.billingPlanType(type.swiftValue)
            )
        } else {
            return nil
        }
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
    /*@available(iOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    @available(macOS, introduced: 14.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")
    @available(tvOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")*/
    public static func promotionalOffer(
        offerID: String,
        signature: SubscriptionOfferSignatureWrapper
    ) -> ProductPurchaseOptionsWrapper? {

        if #available(iOS 17.4, macOS 14.4, tvOS 17.4, *) {

            guard let swiftSigAny = signature.swiftSignature(),
                  let swiftSig = swiftSigAny as? Product.SubscriptionOffer.Signature
            else {
                return nil
            }

            let option = Product.PurchaseOption.promotionalOffer(
                offerID: offerID,
                signature: swiftSig
            )

            return ProductPurchaseOptionsWrapper(option)
        }

        return nil
    }

    @objc public static func promotionalOffer(
        offerID: String,
        compactJWS: String
    ) -> [ProductPurchaseOptionsWrapper] {
        let options = Product.PurchaseOption.promotionalOffer(offerID, compactJWS: compactJWS)
        return options.map { ProductPurchaseOptionsWrapper($0) }
    }
    
    @objc
    //@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    public static func winBackOffer(
        _ offer: ProductSubscriptionOfferWrapper
    ) -> ProductPurchaseOptionsWrapper? {

        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, *) {
            return ProductPurchaseOptionsWrapper(
                Product.PurchaseOption.winBackOffer(offer.offer)
            )
        } else {
            return nil
        }
    }

    @objc public static func introductoryOfferEligibility(compactJWS: String) -> ProductPurchaseOptionsWrapper {
        return ProductPurchaseOptionsWrapper(Product.PurchaseOption.introductoryOfferEligibility(compactJWS: compactJWS))
    }

    @objc public func isEqualToOptions(_ other: ProductPurchaseOptionsWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.underlying == other.underlying
    }
}

// MARK: - RedeemOption
@objc(RedeemOption)
public final class RedeemOptionWrapper: NSObject {

    private let storedValue: Any?

    @nonobjc
    public init?(swiftValue: Any?) {
        guard #available(iOS 27.0, macOS 27.0, *) else {
            return nil
        }
        guard let value = swiftValue as? RedeemOption else {
            return nil
        }
        self.storedValue = value
        super.init()
    }

    @nonobjc
    public var swiftValue: Any? {
        guard #available(iOS 27.0, macOS 27.0, *) else {
            return nil
        }
        return storedValue as? RedeemOption
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
    case paymentMethodBindingConfigurationRequired
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
        case .paymentMethodBindingConfigurationRequired: code = .paymentMethodBindingConfigurationRequired
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

    @objc
    //@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    public static var winBack: SubscriptionOfferTypeWrapper {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, *) {
            return SubscriptionOfferTypeWrapper(swiftValue: .winBack)
        } else {
            // Safe fallback for < iOS 18
            return SubscriptionOfferTypeWrapper(rawValue: "winBack")
        }
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
/*@available(iOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")
@available(macOS, introduced: 14.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")
@available(tvOS, introduced: 17.4, deprecated: 26.0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")*/
public final class SubscriptionOfferSignatureWrapper: NSObject {

    @objc public let keyID: String
    @objc public let nonce: NSUUID
    @objc public let timestamp: NSNumber
    @objc public let signatureData: Data

    private let underlying: Any?
    
    func swiftSignature() -> Any? {
        if #available(iOS 17.4, macOS 14.4, tvOS 17.4, *) {
            return Product.SubscriptionOffer.Signature(
                keyID: keyID,
                nonce: nonce as UUID,
                timestamp: timestamp.intValue,
                signature: signatureData
            )
        }
        return nil
    }

    public init?(swiftValue: Any?) {
        if #available(iOS 17.4, macOS 14.4, tvOS 17.4, *),
           let signature = swiftValue as? Product.SubscriptionOffer.Signature {

            self.keyID = signature.keyID
            self.nonce = signature.nonce as NSUUID
            self.timestamp = NSNumber(value: signature.timestamp)
            self.signatureData = signature.signature
            self.underlying = signature
            super.init()
        } else {
            return nil
        }
    }
    
    @objc
    //@available(iOS 17.4, macOS 14.4, tvOS 17.4, *)
    public static func from(keyID: String, nonce: NSUUID, timestamp: NSNumber, signatureData: Data
    ) -> SubscriptionOfferSignatureWrapper? {

        if #available(iOS 17.4, macOS 14.4, tvOS 17.4, *) {

            let swiftSig = Product.SubscriptionOffer.Signature(
                keyID: keyID,
                nonce: nonce as UUID,
                timestamp: timestamp.intValue,
                signature: signatureData
            )

            return SubscriptionOfferSignatureWrapper(swiftValue: swiftSig)
        } else {
            return nil
        }
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
    
    @objc public static let unbundled = ExpirationReasonWrapper(                                          rawValue: Product.SubscriptionInfo.RenewalInfo.ExpirationReason.unbundled.rawValue
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
    //@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    public var offerType: TransactionOfferTypeWrapper {
        guard let ot = info.offerType else {
            return .unknown
        }

        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, *) {
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
        } else {
            switch ot {
            case .introductory:
                return .introductory
            case .promotional:
                return .promotional
            case .code:
                return .code
            default:
                return .unknown
            }
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
    //@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
    public var currency: CurrencyWrapper? {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) {
            guard let swiftCurrency = Locale.current.currency else {
                return nil
            }
            return CurrencyWrapper(swiftValue: swiftCurrency)
        }
        return nil
    }
    
    @objc public var currencyCode: String? {
        info.currencyCode
    }
    
    @objc
    //@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    public var eligibleWinBackOfferIDs: NSArray {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, *) {
            return info.eligibleWinBackOfferIDs.map { $0 as NSString } as NSArray
        }
        return []
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
    //@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public var advancedCommerceInfo: SubscriptionAdvancedCommerceInfoWrapper? {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            guard let swiftInfo = info.advancedCommerceInfo else { return nil }
            return SubscriptionAdvancedCommerceInfoWrapper(swiftInfo: swiftInfo)
        }
        return nil
    }

    @objc public var appAccountToken: NSUUID? {
        info.appAccountToken.map { $0 as NSUUID }
    }

    @objc public var appTransactionID: String {
        info.appTransactionID
    }
    
    @objc
    public var commitmentInfo: CommitmentInfoWrapper? {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            guard let swiftInfo = info.commitmentInfo else { return nil }
            return CommitmentInfoWrapper(swiftValue: swiftInfo)
        }
        return nil
    }
    
    @objc
    public var renewalBillingPlanType: BillingPlanTypeWrapper? {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            guard let swiftValue = info.renewalBillingPlanType else { return nil }
            return BillingPlanTypeWrapper(swiftValue: swiftValue)
        }
        return nil
    }
}

// MARK: - CommitmentInfo
@objc(CommitmentInfo)
public final class CommitmentInfoWrapper: NSObject {

    @objc public let autoRenewPreference: String
    @objc public let renewalBillingPlanType: BillingPlanTypeWrapper
    @objc public let renewalDate: Date
    @objc public let renewalPrice: NSDecimalNumber
    @objc public let willAutoRenew: Bool

    @nonobjc public init?(swiftValue: Any?) {

        guard #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) else {
            return nil
        }

        guard let info = swiftValue as? Product.SubscriptionInfo.RenewalInfo.CommitmentInfo else {
            return nil
        }

        self.autoRenewPreference = info.autoRenewPreference
        self.renewalBillingPlanType = BillingPlanTypeWrapper(swiftValue: info.renewalBillingPlanType)
        self.renewalDate = info.renewalDate
        self.renewalPrice = NSDecimalNumber(decimal: info.renewalPrice)
        self.willAutoRenew = info.willAutoRenew

        super.init()
    }
}

// MARK: - BillingPlanType
@objc(BillingPlanType)
//@available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *)
public final class BillingPlanTypeWrapper: NSObject {

    @objc public let rawValue: String
    
    @available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *)
    public init(swiftValue: Product.SubscriptionInfo.BillingPlanType) {
        self.rawValue = swiftValue.rawValue
        super.init()
    }

    @objc public init(rawValue: String) {
        self.rawValue = rawValue
        super.init()
    }

    @objc public static var monthly: BillingPlanTypeWrapper {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            return BillingPlanTypeWrapper(swiftValue: .monthly)
        } else {
            return BillingPlanTypeWrapper(rawValue: "unavailable")
        }
    }

    @objc public static var upFront: BillingPlanTypeWrapper {
        if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *) {
            return BillingPlanTypeWrapper(swiftValue: .upFront)
        } else {
            return BillingPlanTypeWrapper(rawValue: "unavailable")
        }
    }

    @available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, *)
    public var swiftValue: Product.SubscriptionInfo.BillingPlanType {
        Product.SubscriptionInfo.BillingPlanType(rawValue: rawValue)
    }

    @objc public func isEqualToType(_ other: BillingPlanTypeWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
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

// MARK: - AdvancedCommerceInfoWrapper
@objc(SubcriptionAdvancedCommerceInfo)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class SubscriptionAdvancedCommerceInfoWrapper: NSObject {

    @objc public let consistencyToken: String
    @objc public let requestReferenceID: String
    @objc public let taxCode: String
    @objc public let descriptionText: String
    @objc public let displayName: String
    @objc public let period: ProductSubscriptionPeriodWrapper
    @objc public let items: [SubscriptionAdvancedCommerceItemWrapper]

    private let underlying: Any?

    public init?(swiftInfo: Any) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let info = swiftInfo as? Product.SubscriptionInfo.RenewalInfo.AdvancedCommerceInfo {

            self.consistencyToken = info.consistencyToken
            self.requestReferenceID = info.requestReferenceID
            self.taxCode = info.taxCode
            self.descriptionText = info.description
            self.displayName = info.displayName
            self.period = ProductSubscriptionPeriodWrapper(swiftValue: info.period)
            self.items = info.items.compactMap { SubscriptionAdvancedCommerceItemWrapper(swiftItem: $0) }

            self.underlying = info
        } else {
            // Return nil if unavailable at runtime
            return nil
        }

        super.init()
    }
}

// MARK: - SubscriptionAdvancedCommerceItemWrapper
@objc(SubscriptionAdvancedCommerceItem)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class SubscriptionAdvancedCommerceItemWrapper: NSObject {

    @objc public let details: TransactionAdvancedCommerceInfoItemDetailsWrapper

    /// Internal storage of the underlying Swift item
    private let underlying: Any?

    /// Safe initializer used when 18.4+ is available
    public init?(swiftItem: Any) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let item = swiftItem as? Product.SubscriptionInfo.RenewalInfo.AdvancedCommerceInfo.Item {

            guard let wrappedDetails = TransactionAdvancedCommerceInfoItemDetailsWrapper(swiftValue: item.details) else {
                return nil
            }
            self.details = wrappedDetails
            self.underlying = item
        } else {
            return nil
        }

        super.init()
    }
}

// MARK: - TransactionAdvancedCommercePartner
@objc(TransactionAdvancedCommercePartner)
//@available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *)
public final class TransactionAdvancedCommercePartnerWrapper: NSObject {

    @objc public let id: String
    @objc public let name: String?

    /// Internal storage of the underlying Swift partner
    private let underlying: Any?

    /// Safe initializer used when iOS 27+ is available
    @nonobjc
    public init?(swiftValue: Any) {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *),
           let partner = swiftValue as? Transaction.AdvancedCommerceInfo.Partner {

            self.id = partner.id
            self.name = partner.name
            self.underlying = partner

        } else {
            return nil
        }

        super.init()
    }

    @objc public init(id: String, name: String?) {
        self.id = id
        self.name = name
        self.underlying = nil
        super.init()
    }

    @objc public func isEqualToPartner(_ other: TransactionAdvancedCommercePartnerWrapper?) -> Bool {
        guard let other else { return false }
        return id == other.id && name == other.name
    }
}
