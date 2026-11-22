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
    
    @objc public var revocationDate: Date? {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
            guard let appTransaction = transaction as? AppTransaction else { return nil }
            return appTransaction.revocationDate
        }
        return nil
    }
    
    @objc public let signedDate: Date
    
    @objc
    public var storeType: AppTransactionStoreTypeWrapper? {
        if #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) {
            guard let transaction = transaction as? AppTransaction else {
                return nil
            }
            return AppTransactionStoreTypeWrapper(
                swiftValue: transaction.storeType
            )
        }
        return nil
    }
    
    @objc
    public var storeTypeStringRepresentation: String {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
            guard let transaction = transaction as? AppTransaction else {
                return "unknown"
            }
            return transaction.storeTypeStringRepresentation
        }
        return "unknown"
    }
    
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
    
    @objc
    public static func getAllTransactionsAsync(
        completion: @escaping ([AppTransactionWrapper]?, NSError?) -> Void
    ) {
        guard #available(iOS 27.0, macOS 27.0, tvOS 27.0, watchOS 27.0, *) else {
            completion(nil, NSError(
                domain: "maui.storekit2.apple",
                code: 1003,
                userInfo: [NSLocalizedDescriptionKey: "Unsupported OS version"]
            ))
            return
        }

        Task {
            let transactions = AppTransaction.all
            var wrappers: [AppTransactionWrapper] = []

            for await verification in transactions {
                switch verification {
                case .verified(let transaction):
                    wrappers.append(
                        AppTransactionWrapper(transaction: transaction)
                    )

                case .unverified(_, let error):
                    completion(nil, NSError(
                        domain: "maui.storekit2.apple",
                        code: 1001,
                        userInfo: [
                            NSLocalizedDescriptionKey: error.localizedDescription
                        ]
                    ))
                    return
                }
            }

            completion(wrappers, nil)
        }
    }
    
    @objc public static func getSharedTransactionAsync(completion: @escaping (AppTransactionWrapper?, NSError?) -> Void) {
        guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) else {
            completion(nil, NSError(domain: "maui.storekit2.apple", code: 1003,
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
                    let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    completion(nil, nsError)
                }
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
    
    @objc public static func refreshTransactionAsync(completion: @escaping (AppTransactionWrapper?, NSError?) -> Void) {
        guard #available(iOS 16.0, macOS 13.0, tvOS 16.0, *) else {
            completion(nil, NSError(domain: "maui.storekit2.apple", code: 1003,
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
                    let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    completion(nil, nsError)
                }
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nil, nsError)
            }
        }
    }
}
