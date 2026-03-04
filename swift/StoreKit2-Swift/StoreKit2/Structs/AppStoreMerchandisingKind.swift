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
//@available(iOS 26.0, tvOS 26.0, *)
public final class AppStoreMerchandisingKindWrapper: NSObject {

    private let underlying: Any?

    public var swiftValue: Any? {
        return underlying
    }

    public init(swiftValue: Any?) {
        self.underlying = swiftValue
    }

    @objc
    public static func subscriptionBundle(
        _ groupID: String,
        completion: @escaping (AppStoreMerchandisingKindWrapper?) -> Void
    ) {
        if #available(iOS 26.0, tvOS 26.0, *) {
            let value = AppStoreMerchandisingKind.subscriptionBundle(groupID)
            let wrapper = AppStoreMerchandisingKindWrapper(swiftValue: value)
            completion(wrapper)
        } else {
            completion(nil)
        }
    }
}
