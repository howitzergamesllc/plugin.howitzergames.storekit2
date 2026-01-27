//
//  AppStoreKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/15/25.
//

import Foundation
import UIKit
import StoreKit

@objc(AppStoreEnvironment)
@available(iOS 16.0, tvOS 16.0, macOS 13.0, *)
public final class AppStoreEnvironmentWrapper: NSObject {

    // MARK: - Raw value
    @objc public let rawValue: String

    // MARK: - Init
    @objc public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    // Swift-to-ObjC bridging initializer
    public convenience init(swiftEnvironment: AppStore.Environment) {
        self.init(rawValue: swiftEnvironment.rawValue)
    }

    // MARK: - Static instances
    @objc public static var production: AppStoreEnvironmentWrapper {
        AppStoreEnvironmentWrapper(rawValue: AppStore.Environment.production.rawValue)
    }

    @objc public static var sandbox: AppStoreEnvironmentWrapper {
        AppStoreEnvironmentWrapper(rawValue: AppStore.Environment.sandbox.rawValue)
    }

    @objc public static var xcode: AppStoreEnvironmentWrapper {
        AppStoreEnvironmentWrapper(rawValue: AppStore.Environment.xcode.rawValue)
    }
    
    @objc public func isEqualToEnvironment(_ other: AppStoreEnvironmentWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}

@objc(AppStorePlatform)
@available(iOS 18.4, tvOS 18.4, macOS 15.4, *)
public final class AppStorePlatformWrapper: NSObject {

    // MARK: - Raw value
    @objc public let rawValue: String

    // MARK: - Init
    @objc public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    // Swift-to-ObjC bridging initializer
    public convenience init(swiftPlatform: AppStore.Platform) {
        self.init(rawValue: swiftPlatform.rawValue)
    }

    // MARK: - Static instances
    @objc public static var iOS: AppStorePlatformWrapper {
        AppStorePlatformWrapper(rawValue: AppStore.Platform.iOS.rawValue)
    }

    @objc public static var macOS: AppStorePlatformWrapper {
        AppStorePlatformWrapper(rawValue: AppStore.Platform.macOS.rawValue)
    }

    @objc public static var tvOS: AppStorePlatformWrapper {
        AppStorePlatformWrapper(rawValue: AppStore.Platform.tvOS.rawValue)
    }

    @objc public static var visionOS: AppStorePlatformWrapper {
        AppStorePlatformWrapper(rawValue: AppStore.Platform.visionOS.rawValue)
    }
    
    @objc public func isEqualToPlatform(_ other: AppStorePlatformWrapper?) -> Bool {
        guard let other = other else { return false }
        return self.rawValue == other.rawValue
    }
}
