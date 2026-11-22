//
//  AdvancedCommerceProduct.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/17/25.
//

import Foundation
import StoreKit
import UIKit

@objc(AdvancedCommerceProduct)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class AdvancedCommerceProductWrapper: NSObject {

    @objc public let id: String
    @objc public let type: ProductTypeWrapper
    
    private let underlying: Any?
    
    public init?(swiftProduct: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let product = swiftProduct as? AdvancedCommerceProduct {
            self.underlying = product
            self.id = product.id
            self.type = ProductTypeWrapper(swiftValue: product.type)
        } else {
            // Unsupported OS version
            self.underlying = nil
            self.id = "Unsupported"
            self.type = .unknown
        }
        super.init()
    }
    
    @objc public static func createAdvancedProductAsync(
        productID: String,
        completion: @escaping (AdvancedCommerceProductWrapper?, NSError?) -> Void
    ) {
        guard #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) else {
            completion(nil, NSError(domain: "maui.storekit2.apple", code: 1003,
                                    userInfo: [NSLocalizedDescriptionKey: "Unsupported OS version"]))
            return
        }
        
        Task {
            do {
                let product = try await AdvancedCommerceProduct(id: productID)
                let wrapper = AdvancedCommerceProductWrapper(swiftProduct: product)
                completion(wrapper, nil)
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
    
    // Purchase method for ObjC
    @objc public func purchaseAsync(
        compactJWS: String,
        viewController: UIViewController,
        options: [AdvancedCommerceProductPurchaseOptionWrapper],
        completion: @escaping (ProductPurchaseResultWrapper?, NSError?) -> Void
    ) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let product = underlying as? AdvancedCommerceProduct {

            // Now safe to use AdvancedCommerceProduct
            let swiftOptions: Set<AdvancedCommerceProduct.PurchaseOption> = Set(
                options.compactMap { wrapper in
                    wrapper.swiftValue as? AdvancedCommerceProduct.PurchaseOption
                }
            )

            Task {
                do {
                    let result = try await product.purchase(
                        compactJWS: compactJWS,
                        confirmIn: viewController,
                        options: swiftOptions
                    )
                    completion(ProductPurchaseResultWrapper(result), nil)
                } catch {
                    completion(nil, NSError(domain: "maui.storekit2.apple",
                                            code: 1001,
                                            userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]))
                }
            }

        } else {
            completion(nil, NSError(domain: "maui.storekit2.apple",
                                    code: 1003,
                                    userInfo: [NSLocalizedDescriptionKey: "Unsupported OS version"]))
        }
    }
    
    @objc public func latestTransactionAsync(completion: @escaping (TransactionVerificationResultWrapper?) -> Void) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let product = underlying as? AdvancedCommerceProduct {
            Task {
                completion(await product.latestTransaction.map { TransactionVerificationResultWrapper(verification: $0) })
            }
        } else {
            completion(nil)
        }
    }
    
    @objc public func allTransactionsAsync(completion: @escaping ([TransactionWrapper]) -> Void) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let product = underlying as? AdvancedCommerceProduct {
            Task {
                var results: [TransactionWrapper] = []
                var iterator = product.allTransactions.makeAsyncIterator()
                while let verificationResult = await iterator.next() {
                    let transaction: Transaction
                    switch verificationResult {
                    case .verified(let t), .unverified(let t, _):
                        transaction = t
                    }
                    results.append(TransactionWrapper(swiftValue: transaction))
                }
                completion(results)
            }
        } else {
            completion([])
        }
    }

    @objc public func currentEntitlementsAsync(completion: @escaping ([TransactionWrapper]) -> Void) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let product = underlying as? AdvancedCommerceProduct {
            Task {
                var results: [TransactionWrapper] = []
                var iterator = product.currentEntitlements.makeAsyncIterator()
                while let verificationResult = await iterator.next() {
                    let transaction: Transaction
                    switch verificationResult {
                    case .verified(let t), .unverified(let t, _):
                        transaction = t
                    }
                    results.append(TransactionWrapper(swiftValue: transaction))
                }
                completion(results)
            }
        } else {
            completion([])
        }
    }
}
