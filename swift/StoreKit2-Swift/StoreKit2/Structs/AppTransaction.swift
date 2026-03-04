//
//  AppTransactionManager.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/16/25.
//

import Foundation
import UIKit
import StoreKit

@objc(AppTransaction)
//@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
public final class AppTransactionWrapper: NSObject {
    
    private let transaction: Any?
    
    @objc public let jsonRepresentation: Data
    @objc public let appID: NSNumber?        // UInt64 → NSNumber
    @objc public let appTransactionID: String
    @objc public let appVersion: String
    @objc public let appVersionID: NSNumber? // UInt64 → NSNumber
    @objc public let bundleID: String
    @objc public let environment: AppStoreEnvironmentWrapper?
    @objc public let originalAppVersion: String
    @objc public let originalPurchaseDate: Date
    
    @objc
    //@available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public var originalPlatform: AppStorePlatformWrapper? {
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, *) {
            guard let appTransaction = transaction as? AppTransaction else { return nil }
            // Use map if originalPlatform is Optional, otherwise just wrap directly
            return AppStorePlatformWrapper(swiftPlatform: appTransaction.originalPlatform)
        }
        return nil
    }
    
    @objc public let originalPlatformStringRepresentation: String?
    
    @objc public let preorderDate: Date?
    @objc public let deviceVerification: Data
    @objc public let deviceVerificationNonce: NSUUID
    @objc public let signedDate: Date
    
    public init(transaction: Any?) {
        self.transaction = transaction
        
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, *),
           let t = transaction as? AppTransaction {
            self.jsonRepresentation = t.jsonRepresentation
            self.appID = t.appID.map { NSNumber(value: $0) }
            self.appTransactionID = t.appTransactionID
            self.appVersion = t.appVersion
            self.appVersionID = t.appVersionID.map { NSNumber(value: $0) }
            self.bundleID = t.bundleID
            self.environment = AppStoreEnvironmentWrapper(swiftEnvironment: t.environment)
            self.originalAppVersion = t.originalAppVersion
            self.originalPurchaseDate = t.originalPurchaseDate
            self.preorderDate = t.preorderDate
            self.deviceVerification = t.deviceVerification
            self.deviceVerificationNonce = t.deviceVerificationNonce as NSUUID
            self.signedDate = t.signedDate

            if #available(iOS 18.4, macOS 15.4, tvOS 18.4, watchOS 11.4, visionOS 2.4, *) {
                self.originalPlatformStringRepresentation = nil
            } else {
                self.originalPlatformStringRepresentation = t.originalPlatformStringRepresentation
            }
        } else {
            // Fallback defaults for unsupported OS
            self.jsonRepresentation = Data()
            self.appID = nil
            self.appTransactionID = ""
            self.appVersion = ""
            self.appVersionID = nil
            self.bundleID = ""
            self.environment = nil
            self.originalAppVersion = ""
            self.originalPurchaseDate = Date()
            self.originalPlatformStringRepresentation = nil
            self.preorderDate = nil
            self.deviceVerification = Data()
            self.deviceVerificationNonce = NSUUID()
            self.signedDate = Date()
        }
    }
    
    @objc public static func getSharedTransactionAsync(completion: @escaping (AppTransactionWrapper?, NSError?) -> Void) {
        guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) else {
            completion(nil, NSError(domain: "plugin.howitzergames.storekit2", code: 1003,
                                    userInfo: [NSLocalizedDescriptionKey: "Unsupported OS version"]))
            return
        }
        
        Task {
            do {
                let verification = try await AppTransaction.shared
                switch verification {
                case .verified(let transaction):
                    completion(AppTransactionWrapper(transaction: transaction), nil)
                case .unverified(_, let error):
                    let nsError = NSError(domain: "plugin.howitzergames.storekit2", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    completion(nil, nsError)
                }
            } catch {
                let nsError = NSError(domain: "plugin.howitzergames.storekit2", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
    
    @objc public static func refreshTransactionAsync(completion: @escaping (AppTransactionWrapper?, NSError?) -> Void) {
        guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) else {
            completion(nil, NSError(domain: "plugin.howitzergames.storekit2", code: 1003,
                                    userInfo: [NSLocalizedDescriptionKey: "Unsupported OS version"]))
            return
        }
        
        Task {
            do {
                let verification = try await AppTransaction.refresh()
                switch verification {
                case .verified(let transaction):
                    completion(AppTransactionWrapper(transaction: transaction), nil)
                case .unverified(_, let error):
                    let nsError = NSError(domain: "plugin.howitzergames.storekit2", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    completion(nil, nsError)
                }
            } catch {
                let nsError = NSError(domain: "plugin.howitzergames.storekit2", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
}
