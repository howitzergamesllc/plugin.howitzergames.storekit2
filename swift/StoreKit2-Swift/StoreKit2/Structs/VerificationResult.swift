//
//  VerificationResult.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/18/25.
//

import Foundation
import UIKit
import StoreKit

// MARK: - VerificationResult<AppTransaction>
// Verification result signing sale of the app.
@objc(AppTransactionVerificationResult)
@available(iOS 16.0, macOS 13.0, tvOS 16.0, *)
public final class AppTransactionVerificationResultWrapper : NSObject {
    
    @objc public let isVerified: Bool
    @objc public let error: VerificationErrorCode

    @objc public let jwsRepresentation: String
    @objc public let headerData: Data
    @objc public let payloadData: Data
    @objc public let signatureData: Data
    @objc public let signedData: Data
    @objc public let signedDate: Date
    @objc public let deviceVerification: Data
    @objc public let deviceVerificationNonce: NSUUID
    
    @objc public let transaction: AppTransactionWrapper

    internal init(verification: VerificationResult<AppTransaction>) {

        switch verification {
        case .verified(let transaction):
            self.transaction = AppTransactionWrapper(transaction: transaction)
            self.isVerified = true
            self.error = .none
            // Keep a reference to the wrapped transaction if needed
            // let wrappedTransaction = AppTransactionWrapper(transaction: transaction)

        case .unverified(let transaction, let error):
            self.transaction = AppTransactionWrapper(transaction: transaction)
            self.isVerified = false
            switch error {
            case .revokedCertificate: self.error = .revokedCertificate
            case .invalidCertificateChain: self.error = .invalidCertificateChain
            case .invalidDeviceVerification: self.error = .invalidDeviceVerification
            case .invalidEncoding: self.error = .invalidEncoding
            case .invalidSignature: self.error = .invalidSignature
            case .missingRequiredProperties: self.error = .missingRequiredProperties
            @unknown default: self.error = .unknown
            }
            // let wrappedTransaction = AppTransactionWrapper(transaction: transaction)
        }

        // Fill JWS data (same for both cases)
        self.jwsRepresentation = verification.jwsRepresentation
        self.headerData = verification.headerData
        self.payloadData = verification.payloadData
        self.signatureData = verification.signatureData
        self.signedData = verification.signedData
        self.signedDate = verification.signedDate
        self.deviceVerification = verification.deviceVerification
        self.deviceVerificationNonce = verification.deviceVerificationNonce as NSUUID
    }

    // AppTransactionVerificationResultWrapper
    @objc public func getPayloadValue() throws -> AppTransactionWrapper {
        if !self.isVerified {
            let verificationerror = VerificationErrorCode(rawValue: error.rawValue)
            let nsError = NSError(
                domain: "maui.storekit2.apple",
                code: self.error.rawValue,
                userInfo: [
                    NSLocalizedDescriptionKey: "VerificationError",
                    "VerificationCase": String(describing: verificationerror),
                    "VerificationCode": String(describing: verificationerror?.rawValue),
                    "IsVerified": false,
                    // Transaction context
                    "AppTransactionID": transaction.appTransactionID,
                    "AppID": transaction.appID ?? NSNull(),
                    "BundleID": transaction.bundleID,
                    "AppVersionID": transaction.appVersionID ?? NSNull()
                ]
            )
            throw nsError
        }
        return transaction  // store this internally in the wrapper
    }

    @objc public func getUnsafePayloadValue() -> AppTransactionWrapper {
        return transaction
    }
}

// MARK: - VerificationResult<Transaction>
//Verification result signing and in-app-purchase.
@objc(TransactionVerificationResult)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class TransactionVerificationResultWrapper: NSObject {

    @objc public let isVerified: Bool
    @objc public let error: VerificationErrorCode

    @objc public let jwsRepresentation: String
    @objc public let headerData: Data
    @objc public let payloadData: Data
    @objc public let signatureData: Data
    @objc public let signedData: Data
    @objc public let signedDate: Date
    @objc public let deviceVerification: Data
    @objc public let deviceVerificationNonce: NSUUID
    @objc public let transaction: TransactionWrapper

    internal init(verification: VerificationResult<Transaction>) {

        switch verification {
        case .verified(let transaction):
            self.transaction = TransactionWrapper(swiftValue: transaction)
            self.isVerified = true
            self.error = .none
            // private let wrappedTransaction = TransactionWrapper(swiftValue: transaction)

        case .unverified(let transaction, let error):
            self.transaction = TransactionWrapper(swiftValue: transaction)
            self.isVerified = false
            switch error {
            case .revokedCertificate: self.error = .revokedCertificate
            case .invalidCertificateChain: self.error = .invalidCertificateChain
            case .invalidDeviceVerification: self.error = .invalidDeviceVerification
            case .invalidEncoding: self.error = .invalidEncoding
            case .invalidSignature: self.error = .invalidSignature
            case .missingRequiredProperties: self.error = .missingRequiredProperties
            @unknown default: self.error = .unknown
            }
            // private let wrappedTransaction = TransactionWrapper(swiftValue: transaction)
        }

        self.jwsRepresentation = verification.jwsRepresentation
        self.headerData = verification.headerData
        self.payloadData = verification.payloadData
        self.signatureData = verification.signatureData
        self.signedData = verification.signedData
        self.signedDate = verification.signedDate
        self.deviceVerification = verification.deviceVerification
        self.deviceVerificationNonce = verification.deviceVerificationNonce as NSUUID
    }

    // TransactionVerificationResultWrapper
    @objc public func getPayloadValue() throws -> TransactionWrapper {
        if !self.isVerified {
            let nsError = NSError(
                domain: "maui.storekit2.apple",
                code: self.error.rawValue,
                userInfo: [
                    NSLocalizedDescriptionKey: "VerificationError",
                    "VerificationCase": String(describing: self.error),
                    "VerificationCode": self.error.rawValue,
                    "IsVerified": false,
                    // Transaction context
                    "TransactionID": transaction.id,
                    "OriginalID": transaction.originalID,
                    "AppTransactionID": transaction.appTransactionID,
                    "ProductID": transaction.productID,
                    "PurchaseDate": transaction.purchaseDate,
                    "OriginalPurchaseDate": transaction.originalPurchaseDate,
                    "ExpirationDate": transaction.expirationDate as Any,
                    "Price": transaction.price as Any,
                    "CurrencyCode": transaction.currencyCode as Any,
                    "Environment": transaction.environmentStringRepresentation
                ]
            )
            throw nsError
        }
        return transaction  // store this internally in the wrapper
    }

    @objc public func getUnsafePayloadValue() -> TransactionWrapper {
        return transaction
    }
}

// MARK: - VerificationResult<Product.SubscriptionInfo.RenewalInfo>
//Verification result signing a subscription renewal.
@objc(RenewalInfoVerificationResult)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public final class RenewalInfoVerificationResultWrapper: NSObject {
    
    @objc public let isVerified: Bool
    @objc public let error: VerificationErrorCode
    
    @objc public let jwsRepresentation: String
    @objc public let headerData: Data
    @objc public let payloadData: Data
    @objc public let signatureData: Data
    @objc public let signedData: Data
    @objc public let signedDate: Date
    @objc public let deviceVerification: Data
    @objc public let deviceVerificationNonce: NSUUID
    
    @objc public let transaction: RenewalInfoWrapper
    
    internal init(verification: VerificationResult<Product.SubscriptionInfo.RenewalInfo>) {
        
        switch verification {
        case .verified(let info):
            self.transaction = RenewalInfoWrapper(renewalInfo: info)
            self.isVerified = true
            self.error = .none
            // private let wrappedInfo = RenewalInfoWrapper(renewalInfo: info)
            
        case .unverified(let info, let error):
            self.transaction = RenewalInfoWrapper(renewalInfo: info)
            self.isVerified = false
            switch error {
            case .revokedCertificate: self.error = .revokedCertificate
            case .invalidCertificateChain: self.error = .invalidCertificateChain
            case .invalidDeviceVerification: self.error = .invalidDeviceVerification
            case .invalidEncoding: self.error = .invalidEncoding
            case .invalidSignature: self.error = .invalidSignature
            case .missingRequiredProperties: self.error = .missingRequiredProperties
            @unknown default: self.error = .unknown
            }
            // private let wrappedInfo = RenewalInfoWrapper(renewalInfo: info)
        }
        
        self.jwsRepresentation = verification.jwsRepresentation
        self.headerData = verification.headerData
        self.payloadData = verification.payloadData
        self.signatureData = verification.signatureData
        self.signedData = verification.signedData
        self.signedDate = verification.signedDate
        self.deviceVerification = verification.deviceVerification
        self.deviceVerificationNonce = verification.deviceVerificationNonce as NSUUID
    }
    
    // RenewalInfoVerificationResultWrapper
    @objc public func getPayloadValue() throws -> RenewalInfoWrapper {
        if !self.isVerified {
            let nsError = NSError(
                domain: "maui.storekit2.apple",
                code: self.error.rawValue,
                userInfo: [
                    NSLocalizedDescriptionKey: "VerificationError",
                    "VerificationCase": String(describing: self.error),
                    "VerificationCode": self.error.rawValue,
                    "IsVerified": false,
                    //Renewal Info
                    "OriginalTransactionID": transaction.originalTransactionID,
                    "CurrentProductID": transaction.currentProductID,
                    "AppTransactionID": transaction.appTransactionID,
                    "OfferID": transaction.offerID ?? NSNull(),
                    "AutoRenewPreference": transaction.autoRenewPreference ?? NSNull()
                ]
            )
            throw nsError
        }
        return transaction  // store this internally in the wrapper
    }
    
    @objc public func getUnsafePayloadValue() -> RenewalInfoWrapper {
        return transaction
    }
}
