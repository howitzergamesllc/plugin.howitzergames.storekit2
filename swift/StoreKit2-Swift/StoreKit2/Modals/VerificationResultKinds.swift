//
//  VerificationResultKinds.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/19/25.
//

import Foundation
import UIKit
import StoreKit

@objc(VerificationErrorCode)
@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public enum VerificationErrorCode: Int {
    case revokedCertificate = 0
    case invalidCertificateChain = 1
    case invalidDeviceVerification = 2
    case invalidEncoding = 3
    case invalidSignature = 4
    case missingRequiredProperties = 5
    case none = 6
    case unknown = -1  // fallback for future cases or unexpected values
}
