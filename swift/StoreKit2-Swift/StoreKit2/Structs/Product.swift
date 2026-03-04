//
//  Product.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - Product
@objc(Product)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class ProductWrapper: NSObject {
    
    private let product: Product
    
    public init(product: Product) {
        self.product = product
    }
    
    @objc public var productID: String {
        product.id
    }
    
    @objc public var type: ProductTypeWrapper {
        ProductTypeWrapper(swiftValue: product.type)
    }
    
    @objc public var displayName: String {
        product.displayName
    }
    
    @objc public var productDescription: String {
        product.description
    }
    
    /// Decimal → NSDecimalNumber (ObjC compatible)
    @objc public var price: NSDecimalNumber {
        product.price as NSDecimalNumber
    }
    
    @objc public var displayPrice: String {
        product.displayPrice
    }
    
    @objc public var isFamilyShareable: Bool {
        product.isFamilyShareable
    }
    
    @objc public var jsonRepresentation: Data {
        product.jsonRepresentation
    }
    
    @objc
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    public var subscription: ProductSubscriptionInfoWrapper? {
        guard let sub = product.subscription else { return nil }
        return ProductSubscriptionInfoWrapper(swiftValue: sub)
    }
    
    // MARK: - Purchase
    @objc
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    public func purchaseAsync(
        options: [ProductPurchaseOptionsWrapper],
        completion: @escaping (ProductPurchaseResultWrapper?, NSError?) -> Void
    ) {
        Task { @MainActor in
            // Convert the ObjC wrappers into Swift purchase options
            let optionSet = Set(options.map { $0.swiftOption })
            
            do {
                let result = try await product.purchase(options: optionSet)
                // Return the result (wrapped in a ProductPurchaseResultWrapper)
                completion(ProductPurchaseResultWrapper(result), nil)
            } catch let purchaseError as Product.PurchaseError {
                let wrappederror = ProductPurchaseErrorWrapper(swiftError: purchaseError)
                let nsError = NSError(domain: "plugin.howitzergames.storekit2",
                                      code: wrappederror.code.rawValue,
                                      userInfo: [
                                          NSLocalizedDescriptionKey: "PurchaseError",
                                          "ErrorCase": String(describing: wrappederror.code),
                                          "ErrorCode": wrappederror.code,
                                          "ErrorReason": String(describing: wrappederror.failureReason),
                                          "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                                          "IsVerified": false
                                      ])
                completion(nil, nsError)
            } catch let error as StoreKitError {
                let wrappederror = StoreKitErrorWrapper(swiftError: error)
                let nserror = NSError(domain: "plugin.howitzergames.storekit2",
                                      code: wrappederror.code.rawValue,
                                      userInfo: [
                                        NSLocalizedDescriptionKey: "StoreKitError",
                                        "ErrorCase": String(describing: wrappederror.code),
                                        "ErrorCode": wrappederror.code,
                                        "ErrorReason": String(describing: wrappederror.failureReason),
                                        "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                                        "IsVerified": false
                                      ])
                completion(nil, nserror)
            } catch let error{
                // Catch any other errors and wrap them in an NSError
                let nsError = NSError(domain: "plugin.howitzergames.storekit2",
                                      code: 1001, // Custom code for unknown errors
                                      userInfo: [
                                        NSLocalizedDescriptionKey: error.localizedDescription
                                      ])
                completion(nil, nsError)
            }
        }
    }
    
    @objc(purchaseInSceneAsync:options:completion:)
    public func purchaseAsync(
        confirmIn scene: UIScene,
        options: [ProductPurchaseOptionsWrapper],
        completion: @escaping (ProductPurchaseResultWrapper?, NSError?) -> Void
    ) {
        if #available(iOS 17.0, tvOS 17.0, *) {
            Task { @MainActor in
                let optionSet = Set(options.map { $0.swiftOption })

                do {
                    let result = try await product.purchase(confirmIn: scene, options: optionSet)
                    completion(ProductPurchaseResultWrapper(result), nil)
                } catch let purchaseError as Product.PurchaseError {
                    let wrappederror = ProductPurchaseErrorWrapper(swiftError: purchaseError)
                    let nsError = NSError(domain: "plugin.howitzergames.storekit2",
                                          code: wrappederror.code.rawValue,
                                          userInfo: [
                                              NSLocalizedDescriptionKey: "PurchaseError",
                                              "ErrorCase": String(describing: wrappederror.code),
                                              "ErrorCode": wrappederror.code,
                                              "ErrorReason": String(describing: wrappederror.failureReason),
                                              "RecoverySuggestion": String(describing: wrappederror.recoverySuggestion),
                                              "IsVerified": false
                                          ])
                    completion(nil, nsError)
                } catch let error as StoreKitError {
                    let wrappederror = StoreKitErrorWrapper(swiftError: error)
                    let nserror = NSError(domain: "plugin.howitzergames.storekit2",
                                          code: wrappederror.code.rawValue,
                                          userInfo: [
                                            NSLocalizedDescriptionKey: "StoreKitError",
                                            "ErrorCase": String(describing: wrappederror.code),
                                            "ErrorCode": wrappederror.code,
                                            "ErrorReason": String(describing: wrappederror.failureReason),
                                            "RecoverySuggestion": String(describing: wrappederror.recoverySuggestion),
                                            "IsVerified": false
                                          ])
                    completion(nil, nserror)
                } catch {
                    let nsError = NSError(domain: "plugin.howitzergames.storekit2",
                                          code: 1001,
                                          userInfo: [
                                            NSLocalizedDescriptionKey: error.localizedDescription
                                          ])
                    completion(nil, nsError)
                }
            }
        } else {
            // Runtime fallback for older OS
            let nsError = NSError(
                domain: "plugin.howitzergames.storekit2",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "purchaseAsync is not available on this OS version."]
            )
            completion(nil, nsError)
        }
    }
    
    @objc(purchaseInViewControllerAsync:options:completion:)
    public func purchaseAsync(
        confirmIn viewController: UIViewController,
        options: [ProductPurchaseOptionsWrapper],
        completion: @escaping (ProductPurchaseResultWrapper?, NSError?) -> Void
    ) {
        if #available(iOS 18.2, tvOS 18.2, *) {
            Task { @MainActor in
                let optionSet = Set(options.map { $0.swiftOption })
                
                do {
                    let result = try await product.purchase(confirmIn: viewController, options: optionSet)
                    completion(ProductPurchaseResultWrapper(result), nil)
                } catch let purchaseError as Product.PurchaseError {
                    let wrappederror = ProductPurchaseErrorWrapper(swiftError: purchaseError)
                    let nsError = NSError(domain: "plugin.howitzergames.storekit2",
                                          code: wrappederror.code.rawValue,
                                          userInfo: [
                                              NSLocalizedDescriptionKey: "PurchaseError",
                                              "ErrorCase": String(describing: wrappederror.code),
                                              "ErrorCode": wrappederror.code,
                                              "ErrorReason": String(describing: wrappederror.failureReason),
                                              "RecoverySuggestion": String(describing: wrappederror.recoverySuggestion),
                                              "IsVerified": false
                                          ])
                    completion(nil, nsError)
                } catch let error as StoreKitError {
                    let wrappederror = StoreKitErrorWrapper(swiftError: error)
                    let nserror = NSError(domain: "plugin.howitzergames.storekit2",
                                          code: wrappederror.code.rawValue,
                                          userInfo: [
                                            NSLocalizedDescriptionKey: "StoreKitError",
                                            "ErrorCase": String(describing: wrappederror.code),
                                            "ErrorCode": wrappederror.code,
                                            "ErrorReason": String(describing: wrappederror.failureReason),
                                            "RecoverySuggestion": String(describing: wrappederror.recoverySuggestion),
                                            "IsVerified": false
                                          ])
                    completion(nil, nserror)
                } catch {
                    let nsError = NSError(domain: "plugin.howitzergames.storekit2",
                                          code: 1001,
                                          userInfo: [
                                            NSLocalizedDescriptionKey: error.localizedDescription
                                          ])
                    completion(nil, nsError)
                }
            }
        } else {
            // Runtime fallback for OS versions <18.2
            let nsError = NSError(
                domain: "plugin.howitzergames.storekit2",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "purchaseAsync(confirmIn:viewController:) is not available on this OS version."]
            )
            completion(nil, nsError)
        }
    }
    
    @objc(productsWithIdentifiersAsync:completion:)
    public static func productsAsync(
        identifiers: [String],
        completion: @escaping ([ProductWrapper]?, NSError?) -> Void
    ) {
        Task {
            do {
                // Call StoreKit 2 API
                let products = try await Product.products(for: identifiers)

                // Wrap Swift Product → ProductWrapper
                let wrapped = products.map { ProductWrapper(product: $0) }

                completion(wrapped, nil)
            } catch let error as StoreKitError {
                let wrappederror = StoreKitErrorWrapper(swiftError: error)
                let nserror = NSError(domain: "plugin.howitzergames.storekit2",
                                      code: wrappederror.code.rawValue,
                                      userInfo: [
                                        NSLocalizedDescriptionKey: "StoreKitError",
                                        "ErrorCase": String(describing: wrappederror.code),
                                        "ErrorCode": wrappederror.code,
                                        "ErrorReason": String(describing: wrappederror.failureReason),
                                        "RecoverySuggestion":String(describing: wrappederror.recoverySuggestion),
                                        "IsVerified": false
                                      ])
                completion(nil, nserror)
            } catch {
                completion(nil, error as NSError)
            }
        }
    }
    
    /// Fetches the latest transaction wrapped in a TransactionVerificationResultWrapper.
    @objc(latestTransactionWithCompletionAsync:)
    public func latestTransactionAsync(completion: @escaping (TransactionVerificationResultWrapper?) -> Void) {
        Task {
            guard let verificationResult = await product.latestTransaction else {
                completion(nil)
                return
            }

            let wrapped = TransactionVerificationResultWrapper(verification: verificationResult)
            completion(wrapped)
        }
    }

    /// Fetches the current entitlement (deprecated) wrapped in a TransactionVerificationResultWrapper.
    @objc(currentEntitlementWithCompletionAsync:)
    @available(iOS, introduced: 15.0, deprecated: 18.4, message: "Use the currentEntitlements property instead.")
    @available(macOS, introduced: 12.0, deprecated: 15.4, message: "Use the currentEntitlements property instead.")
    @available(tvOS, introduced: 15.0, deprecated: 18.4, message: "Use the currentEntitlements property instead.")
    public func currentEntitlementAsync(completion: @escaping (TransactionVerificationResultWrapper?, NSError?) -> Void) {
        Task {
            guard let verificationResult = await product.currentEntitlement else {
                completion(nil, nil)
                return
            }

            let wrapped = TransactionVerificationResultWrapper(verification: verificationResult)
            if wrapped.isVerified {
                completion(wrapped, nil)
            } else {
                let nsError = NSError(
                    domain: "plugin.howitzergames.storekit2",
                    code: wrapped.error.rawValue,
                    userInfo: [
                        NSLocalizedDescriptionKey: "VerificationError",
                        "VerificationCase": String(describing: wrapped.error),
                        "VerificationCode": wrapped.error.rawValue,
                        "IsVerified": false,
                        "TransactionID": wrapped.transaction.id
                    ]
                )
                completion(wrapped, nsError)
            }
        }
    }

    @objc(currentEntitlementsWithCompletionAsync:)
    public func currentEntitlementsAsync(
        completion: @escaping ([TransactionVerificationResultWrapper], NSError?) -> Void
    ) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            Task {
                var wrappedResults: [TransactionVerificationResultWrapper] = []
                var unverifiedCount = 0
                var lastError: NSError?

                // Iterate over the async sequence of current entitlements
                for await verificationResult in product.currentEntitlements {
                    let wrapped = TransactionVerificationResultWrapper(verification: verificationResult)
                    wrappedResults.append(wrapped)

                    if !wrapped.isVerified {
                        unverifiedCount += 1
                        lastError = NSError(
                            domain: "plugin.howitzergames.storekit2",
                            code: wrapped.error.rawValue,
                            userInfo: [
                                NSLocalizedDescriptionKey: "VerificationError",
                                "VerificationCase": String(describing: wrapped.error),
                                "VerificationCode": wrapped.error.rawValue,
                                "IsVerified": false,
                                "TransactionID": wrapped.transaction.id,
                                "UnverifiedCount": unverifiedCount
                            ]
                        )
                    }
                }

                completion(wrappedResults, lastError)
            }
        } else {
            // Runtime fallback for older OS versions
            let nsError = NSError(
                domain: "plugin.howitzergames.storekit2",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "currentEntitlementsAsync is not available on this OS version."
                ]
            )
            completion([], nsError)
        }
    }
}
