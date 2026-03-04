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
            return AppStorePlatformWrapper(rawValue: "iOS")
        }
    }

    @objc public static var macOS: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.macOS)!
        } else {
            return AppStorePlatformWrapper(rawValue: "macOS")
        }
    }

    @objc public static var tvOS: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.tvOS)!
        } else {
            return AppStorePlatformWrapper(rawValue: "tvOS")
        }
    }

    @objc public static var visionOS: AppStorePlatformWrapper {
        if #available(iOS 18.4, tvOS 18.4, macOS 15.4, *) {
            return AppStorePlatformWrapper(swiftPlatform: AppStore.Platform.visionOS)!
        } else {
            return AppStorePlatformWrapper(rawValue: "visionOS")
        }
    }

    @objc public func isEqualToPlatform(_ other: AppStorePlatformWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}
