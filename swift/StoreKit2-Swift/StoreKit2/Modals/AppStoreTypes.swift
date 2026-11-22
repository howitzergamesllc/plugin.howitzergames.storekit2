//
//  AppStoreKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/15/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - AppStoreEnvironment
@objc(AppStoreEnvironment)
//@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
public final class AppStoreEnvironmentWrapper: NSObject {

    @objc public let rawValue: String
    
    @objc public init(rawValue: String) {
        self.rawValue = rawValue
        super.init()
    }
    
    public convenience init?(swiftEnvironment: Any?) {
        if #available(iOS 16.0, tvOS 16.0, macOS 13.0, *),
           let env = swiftEnvironment as? AppStore.Environment {
            self.init(rawValue: env.rawValue)
        } else {
            // Older OS or unsupported type
            self.init(rawValue: "unsupported")
        }
    }

    @objc public static var production: AppStoreEnvironmentWrapper {
        if #available(iOS 16.0, tvOS 16.0, macOS 13.0, *) {
            return AppStoreEnvironmentWrapper(swiftEnvironment: AppStore.Environment.production)!
        } else {
            return AppStoreEnvironmentWrapper(rawValue: "production")
        }
    }

    @objc public static var sandbox: AppStoreEnvironmentWrapper {
        if #available(iOS 16.0, tvOS 16.0, macOS 13.0, *) {
            return AppStoreEnvironmentWrapper(swiftEnvironment: AppStore.Environment.sandbox)!
        } else {
            return AppStoreEnvironmentWrapper(rawValue: "sandbox")
        }
    }

    @objc public static var xcode: AppStoreEnvironmentWrapper {
        if #available(iOS 16.0, tvOS 16.0, macOS 13.0, *) {
            return AppStoreEnvironmentWrapper(swiftEnvironment: AppStore.Environment.xcode)!
        } else {
            return AppStoreEnvironmentWrapper(rawValue: "xcode")
        }
    }

    @objc public func isEqualToEnvironment(_ other: AppStoreEnvironmentWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - AppStorePlatform
@objc(AppStorePlatform)
//@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
public final class AppStorePlatformWrapper: NSObject {

    @objc public let rawValue: String

    @objc public init(rawValue: String) {
        self.rawValue = rawValue
        super.init()
    }

    public convenience init?(swiftPlatform: Any?) {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *),
           let platform = swiftPlatform as? AppStore.Platform {
            self.init(rawValue: platform.rawValue)
        } else {
            // Fallback for older OS or unsupported type
            self.init(rawValue: "unsupported")
        }
    }

    @objc public static var iOS: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.iOS)!
        } else {
            return AppStorePlatformWrapper(rawValue: "unsupported")
        }
    }

    @objc public static var macOS: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.macOS)!
        } else {
            return AppStorePlatformWrapper(rawValue: "unsupported")
        }
    }

    @objc public static var tvOS: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.tvOS)!
        } else {
            return AppStorePlatformWrapper(rawValue: "unsupported")
        }
    }

    @objc public static var visionOS: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.visionOS)!
        } else {
            return AppStorePlatformWrapper(rawValue: "unsupported")
        }
    }
    
    @objc public static var managed: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.managed)!
        }
        return AppStorePlatformWrapper(rawValue: "unsupported")
    }

    @objc public func isEqualToPlatform(_ other: AppStorePlatformWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

// MARK: - AppTransactionStoreType
@objc(AppTransactionStoreType)
public final class AppTransactionStoreTypeWrapper: NSObject {

    private let storedValue: Any?

    @objc public let rawValue: String

    @nonobjc
    public init?(swiftValue: Any?) {
        guard #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) else {
            self.rawValue = "unsupported"
            return nil
        }

        guard let value = swiftValue as? AppTransaction.StoreType else {
            return nil
        }

        self.storedValue = value
        self.rawValue = value.rawValue
        super.init()
    }

    @objc public init(rawValue: String) {
        self.storedValue = nil
        self.rawValue = rawValue
        super.init()
    }

    @nonobjc
    public var swiftValue: Any? {
        guard #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) else {
            return nil
        }

        return storedValue as? AppTransaction.StoreType
    }

    @objc public static var consumer: AppTransactionStoreTypeWrapper {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) {
            return AppTransactionStoreTypeWrapper(
                rawValue: AppTransaction.StoreType.consumer.rawValue
            )
        }
        return AppTransactionStoreTypeWrapper(rawValue: "unsupported")
    }

    @objc public static var education: AppTransactionStoreTypeWrapper {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) {
            return AppTransactionStoreTypeWrapper(
                rawValue: AppTransaction.StoreType.education.rawValue
            )
        }
        return AppTransactionStoreTypeWrapper(rawValue: "unsupported")
    }

    @objc public static var enterprise: AppTransactionStoreTypeWrapper {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) {
            return AppTransactionStoreTypeWrapper(
                rawValue: AppTransaction.StoreType.enterprise.rawValue
            )
        }
        return AppTransactionStoreTypeWrapper(rawValue: "unsupported")
    }

    @objc public func isEqualToType(_ other: AppTransactionStoreTypeWrapper?) -> Bool {
        guard let other else { return false }
        return rawValue == other.rawValue
    }
}
