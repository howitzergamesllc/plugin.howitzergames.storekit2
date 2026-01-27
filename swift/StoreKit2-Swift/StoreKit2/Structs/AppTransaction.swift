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
@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
public final class AppTransactionWrapper: NSObject {
    
    private let transaction: AppTransaction
    
    // MARK: - Properties
    
    @objc public let jsonRepresentation: Data
    @objc public let appID: NSNumber?        // UInt64 → NSNumber
    @objc public let appTransactionID: String
    @objc public let appVersion: String
    @objc public let appVersionID: NSNumber? // UInt64 → NSNumber
    @objc public let bundleID: String
    @objc public let environment: AppStoreEnvironmentWrapper
    @objc public let originalAppVersion: String
    @objc public let originalPurchaseDate: Date
    
    /// Only available on iOS 18.4+
    @objc
    @available(iOS 18.4, macOS 15.4, tvOS 18.4, *)
    public var originalPlatform: AppStorePlatformWrapper? {
        AppStorePlatformWrapper(swiftPlatform: transaction.originalPlatform)
    }
    
    /// Back-deployed for older OS versions
    @objc public let originalPlatformStringRepresentation: String?
    
    @objc public let preorderDate: Date?
    @objc public let deviceVerification: Data
    @objc public let deviceVerificationNonce: NSUUID
    @objc public let signedDate: Date
    
    // MARK: - Init
    
    public init(transaction: AppTransaction) {
        self.transaction = transaction
        self.jsonRepresentation = transaction.jsonRepresentation
        self.appID = transaction.appID.map { NSNumber(value: $0) }
        self.appTransactionID = transaction.appTransactionID
        self.appVersion = transaction.appVersion
        self.appVersionID = transaction.appVersionID.map { NSNumber(value: $0) }
        self.bundleID = transaction.bundleID
        self.environment = AppStoreEnvironmentWrapper(swiftEnvironment: transaction.environment)
        self.originalAppVersion = transaction.originalAppVersion
        self.originalPurchaseDate = transaction.originalPurchaseDate
        
        if #available(iOS 18.4, macOS 15.4, tvOS 18.4, watchOS 11.4, visionOS 2.4, *) {
            self.originalPlatformStringRepresentation = nil
        } else {
            self.originalPlatformStringRepresentation = transaction.originalPlatformStringRepresentation
        }
        
        self.preorderDate = transaction.preorderDate
        self.deviceVerification = transaction.deviceVerification
        self.deviceVerificationNonce = transaction.deviceVerificationNonce as NSUUID
        self.signedDate = transaction.signedDate
    }
    
    // MARK: - Async static methods exposed to Obj-C
    
    /// Get the shared AppTransaction
    @objc public static func getSharedTransactionAsync(completion: @escaping (AppTransactionWrapper?, NSError?) -> Void) {
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
    
    /// Refresh the AppTransaction
    @objc public static func refreshTransactionAsync(completion: @escaping (AppTransactionWrapper?, NSError?) -> Void) {
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
