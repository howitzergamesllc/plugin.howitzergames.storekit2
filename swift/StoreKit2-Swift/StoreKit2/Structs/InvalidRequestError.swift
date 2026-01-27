//
//  InvalidRequestError.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(InvalidRequestError)
@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class InvalidRequestErrorWrapper: NSObject {
    
    @objc public let code: Int64
    @objc public let message: String
    
    /// Initialize from Swift `InvalidRequestError`
    public init(swiftError: InvalidRequestError) {
        self.code = swiftError.code
        self.message = swiftError.message
    }
    
    /// Convert to NSError for Objective-C compatibility
    @objc public var nsError: NSError {
        return NSError(
            domain: "maui.storekit2.apple",
            code: Int(code),
            userInfo: [NSLocalizedDescriptionKey: message]
        )
    }
}
