//
//  AppStoreMerchandisingKind.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(AppStoreMerchandisingKind)
@available(iOS 26.0, tvOS 26.0, *)
@available(macOS, unavailable)
public final class AppStoreMerchandisingKindWrapper: NSObject {

    // Stored Swift value
    let swiftValue: AppStoreMerchandisingKind

    public init(swiftValue: AppStoreMerchandisingKind) {
        self.swiftValue = swiftValue
    }
    
    @objc
    public static func subscriptionBundle(
        _ groupID: String,
        completion: @escaping (AppStoreMerchandisingKindWrapper?) -> Void
    ) {
        // Assuming AppStoreMerchandisingKind.subscriptionBundle(groupID) doesn't throw and just returns the value or something else
        let value = AppStoreMerchandisingKind.subscriptionBundle(groupID)
        
        // Wrap the result and pass it back to the completion block
        let wrapper = AppStoreMerchandisingKindWrapper(swiftValue: value)
        completion(wrapper)
    }
}
