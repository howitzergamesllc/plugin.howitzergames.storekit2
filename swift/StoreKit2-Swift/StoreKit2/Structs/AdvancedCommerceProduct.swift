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
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class AdvancedCommerceProductWrapper: NSObject {

    @objc public let id: String
    @objc public let type: ProductTypeWrapper
    
    private let swiftProduct: AdvancedCommerceProduct
    
    public init(swiftProduct: AdvancedCommerceProduct) {
        self.swiftProduct = swiftProduct
        self.id = swiftProduct.id
        self.type = ProductTypeWrapper(swiftValue: swiftProduct.type)
        super.init()
    }
    
    @objc public static func createAdvancedProductAsync(
        productID: String,
        completion: @escaping (AdvancedCommerceProductWrapper?, NSError?) -> Void
    ) {
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
        let swiftOptions = Set(options.map { $0.underlying })
        
        Task {
            do {
                let result = try await swiftProduct.purchase(compactJWS: compactJWS, confirmIn: viewController, options: swiftOptions)
                let objcResult = ProductPurchaseResultWrapper(result)
                completion(objcResult, nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
    
    @objc public func latestTransactionAsync(completion: @escaping (TransactionVerificationResultWrapper?) -> Void) {
        Task {
            guard let verificationResult = await swiftProduct.latestTransaction else {
                completion(nil)
                return
            }
            completion(TransactionVerificationResultWrapper(verification: verificationResult))
        }
    }
    
    @objc public func allTransactionsAsync(completion: @escaping ([TransactionWrapper]) -> Void) {
        Task {
            var results: [TransactionWrapper] = []
            var iterator = swiftProduct.allTransactions.makeAsyncIterator()
            
            while let verificationResult = await iterator.next() {
                let transaction: Transaction

                switch verificationResult {
                case .verified(let t):
                    transaction = t
                case .unverified(let t, _):
                    transaction = t
                }

                results.append(TransactionWrapper(swiftValue: transaction))
            }

            completion(results)
        }
    }

    @objc public func currentEntitlementsAsync(completion: @escaping ([TransactionWrapper]) -> Void) {
        Task {
            var results: [TransactionWrapper] = []
            var iterator = swiftProduct.currentEntitlements.makeAsyncIterator()
            
            while let verificationResult = await iterator.next() {
                let transaction: Transaction

                switch verificationResult {
                case .verified(let t):
                    transaction = t
                case .unverified(let t, _):
                    transaction = t
                }

                results.append(TransactionWrapper(swiftValue: transaction))
            }
            
            completion(results)
        }
    }
}
