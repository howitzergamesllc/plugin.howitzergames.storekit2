//
//  StoreKitAppStoreBridge.swift
//  StoreKit2
//
//  Created by Ian Howard on 11/20/2025.
//

import Foundation
import UIKit
import StoreKit

@objc(AppStore)
public final class AppStoreWrapper : NSObject
{
    @objc
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    public static func canMakePayments() -> Bool {
        return AppStore.canMakePayments
    }

    @objc
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    public static func deviceVerificationIdString() -> String? {
        return AppStore.deviceVerificationID?.uuidString.lowercased()
    }
    
    @objc
    @available(iOS 15.0, *)
    public static func syncAppStoreAsync(completion: @escaping (NSError?) -> Void) {
        Task { @MainActor in
            do {
                try await AppStore.sync()
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }
    
    @objc
    @available(iOS 15.0, *)
    public static func showManageSubscriptionsAsync(in scene: UIWindowScene,
        completion: @escaping (NSError?) -> Void
    ) {
        Task { @MainActor in
            do {
                try await AppStore.showManageSubscriptions(in: scene)
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }

    @objc
    @available(iOS 17.0, *)
    public static func showManageSubscriptionsAsync(
        in scene: UIWindowScene,
        subscriptionGroupID: String,
        completion: @escaping (NSError?) -> Void
    ) {
        Task { @MainActor in
            do {
                try await AppStore.showManageSubscriptions(
                    in: scene,
                    subscriptionGroupID: subscriptionGroupID
                )
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }
    
    @objc
    @available(iOS 16.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    public static func presentOfferCodeRedeemSheetAsync(
        in scene: UIWindowScene,
        completion: @escaping (NSError?) -> Void
    ) {
        Task { @MainActor in
            do {
                try await AppStore.presentOfferCodeRedeemSheet(in: scene)
                completion(nil)
            } catch {
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(nsError)
            }
        }
    }
    
    @objc
    @available(iOS 26.0, tvOS 26.0, *)
    @available(macOS, unavailable)
    public static func presentMerchandisingAsync(
        _ kind: AppStoreMerchandisingKindWrapper,
        from controller: UIViewController,
        completion: @escaping (AppStoreMerchandisingKindPresentationResultWrapper, NSError?) -> Void
    ) {
        Task { @MainActor in
            do {
                let result = try await AppStore.presentMerchandising(kind.swiftValue, from: controller)

                // Wrap Swift result in Obj-C wrapper
                let wrapperResult = AppStoreMerchandisingKindPresentationResultWrapper(underlying: result)
                completion(wrapperResult, nil)
            } catch {
                let wrapperResult = AppStoreMerchandisingKindPresentationResultWrapper(underlying: .dismissed)
                let nsError = NSError(domain: "maui.storekit2.apple", code: 1001, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                completion(wrapperResult, nsError)
            }
        }
    }
    
    @objc
    @available(iOS 16.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    public static func requestReview(in scene: UIWindowScene) {
        Task { @MainActor in
            AppStore.requestReview(in: scene)
        }
    }
}
