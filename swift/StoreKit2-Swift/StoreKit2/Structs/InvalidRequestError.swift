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
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class InvalidRequestErrorWrapper: NSObject {
    
    @objc public let code: Int64
    @objc public let message: String
    
    /// Initialize from Swift `InvalidRequestError` if available at runtime
    @objc public init?(swiftError: Any?) {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *),
           let error = swiftError as? InvalidRequestError {
            self.code = error.code
            self.message = error.message
        } else {
            // Unsupported OS, provide fallback values
            self.code = -1
            self.message = "InvalidRequestError not available on this OS"
        }
        super.init()
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
