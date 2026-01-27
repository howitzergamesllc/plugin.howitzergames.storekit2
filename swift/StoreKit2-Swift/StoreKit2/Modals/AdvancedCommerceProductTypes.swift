//
//  AdvancedCommerceProductKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/17/25.
//

import Foundation
import UIKit
import StoreKit

@objc(AdvancedCommerceProductPurchaseOption)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class AdvancedCommerceProductPurchaseOptionWrapper: NSObject {

    /// The underlying Swift PurchaseOption
    let underlying: AdvancedCommerceProduct.PurchaseOption

    init(_ option: AdvancedCommerceProduct.PurchaseOption) {
        self.underlying = option
        super.init()
    }
    
    /// Obj-C/C# factory for onStorefrontChange option
    @objc public static func onStorefrontChange(
        shouldContinuePurchase: @escaping @Sendable (StoreFrontWrapper) -> Bool
    ) -> AdvancedCommerceProductPurchaseOptionWrapper {

        // Wrap the Swift PurchaseOption closure
        let option = AdvancedCommerceProduct.PurchaseOption.onStorefrontChange { storefront in
            let wrapper = StoreFrontWrapper(storefront)
            return shouldContinuePurchase(wrapper)
        }

        return AdvancedCommerceProductPurchaseOptionWrapper(option)
    }
}
