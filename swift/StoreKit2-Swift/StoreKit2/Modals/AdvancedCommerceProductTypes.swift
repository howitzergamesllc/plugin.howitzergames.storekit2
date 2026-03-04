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
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class AdvancedCommerceProductPurchaseOptionWrapper: NSObject {

    /// The underlying Swift PurchaseOption, optional for runtime safety
    private let underlying: Any?

    /// Expose for runtime checks in C#/Obj-C
    public var swiftValue: Any? { underlying }

    /// Private initializer to prevent misuse on unsupported OS
    private init(_ option: Any) {
        self.underlying = option
        super.init()
    }
    
    /// Obj-C/C# factory for onStorefrontChange option
    @objc public static func onStorefrontChange(
        shouldContinuePurchase: @escaping @Sendable (StoreFrontWrapper) -> Bool
    ) -> AdvancedCommerceProductPurchaseOptionWrapper? {
        
        guard #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) else {
            return nil
        }
        
        let option = AdvancedCommerceProduct.PurchaseOption.onStorefrontChange { storefront in
            let wrapper = StoreFrontWrapper(storefront)
            return shouldContinuePurchase(wrapper)
        }
        
        return AdvancedCommerceProductPurchaseOptionWrapper(option)
    }
}
