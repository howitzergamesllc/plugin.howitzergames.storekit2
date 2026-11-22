using System;
using System.Runtime.CompilerServices;
using Foundation;
using ObjCRuntime;
using UIKit;

namespace StoreKit2 {


	// @interface AdvancedCommerceProductPurchaseOption : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AdvancedCommerceProductPurchaseOption
	{
		// +(AdvancedCommerceProductPurchaseOption * _Nullable)onStorefrontChangeWithShouldContinuePurchase:(BOOL (^ _Nonnull)(StoreFront * _Nonnull))shouldContinuePurchase __attribute__((warn_unused_result("")));
		[Static]
		[Export ("onStorefrontChangeWithShouldContinuePurchase:")]
		[return: NullAllowed]
		AdvancedCommerceProductPurchaseOption OnStorefrontChangeWithShouldContinuePurchase (Func<StoreFront, bool> shouldContinuePurchase);
	}

	delegate void AdvancedProductCreationHandler([NullAllowed] AdvancedCommerceProduct result, [NullAllowed] NSError error);
	delegate void PurchaseResultHandler([NullAllowed] ProductPurchaseResult result, [NullAllowed] NSError error);
	delegate void LatestAdvancedCommerceProductTransactionHandler([NullAllowed] TransactionVerificationResult result);
	delegate void AdvancedCommerceProductTransactionsHandler(Transaction[] transactions);

	// @interface AdvancedCommerceProduct : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AdvancedCommerceProduct
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull id;
		[Export ("id")]
		string Id { get; }

		// @property (readonly, nonatomic, strong) ProductType * _Nonnull type;
		[Export ("type", ArgumentSemantic.Strong)]
		ProductType Type { get; }

		// +(void)createAdvancedProductAsyncWithProductID:(NSString * _Nonnull)productID completion:(void (^ _Nonnull)(AdvancedCommerceProduct * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("createAdvancedProductAsyncWithProductID:completion:")]
		void CreateAdvancedProductAsyncWithProductID (string productID, AdvancedProductCreationHandler advancedProductCreationHandler);

		// -(void)purchaseAsyncWithCompactJWS:(NSString * _Nonnull)compactJWS viewController:(UIViewController * _Nonnull)viewController options:(NSArray<AdvancedCommerceProductPurchaseOption *> * _Nonnull)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion;
		[Async]
		[Export ("purchaseAsyncWithCompactJWS:viewController:options:completion:")]
		void PurchaseAsyncWithCompactJWS (string compactJWS, UIViewController viewController, AdvancedCommerceProductPurchaseOption[] options, PurchaseResultHandler advancedProductPurchaseResultHandler);

		// -(void)latestTransactionAsyncWithCompletion:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion;
		[Async]
		[Export ("latestTransactionAsyncWithCompletion:")]
		void LatestTransactionAsyncWithCompletion (LatestAdvancedCommerceProductTransactionHandler latestAdvancedCommerceProductTransactionHandler);

		// -(void)allTransactionsAsyncWithCompletion:(void (^ _Nonnull)(NSArray<Transaction *> * _Nonnull))completion;
		[Async]
		[Export ("allTransactionsAsyncWithCompletion:")]
		void AllTransactionsAsyncWithCompletion (AdvancedCommerceProductTransactionsHandler advancedCommerceProductTransactionsHandler);

		// -(void)currentEntitlementsAsyncWithCompletion:(void (^ _Nonnull)(NSArray<Transaction *> * _Nonnull))completion;
		[Async]
		[Export ("currentEntitlementsAsyncWithCompletion:")]
		void CurrentEntitlementsAsyncWithCompletion (AdvancedCommerceProductTransactionsHandler advancedCommerceProductTransactionsHandler);
	}

	// @interface AppStoreEnvironment : NSObject
	[TV (16,0), Mac (13,0), iOS (16,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AppStoreEnvironment
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) AppStoreEnvironment * _Nonnull production;
		[Static]
		[Export ("production", ArgumentSemantic.Strong)]
		AppStoreEnvironment Production { get; }

		// @property (readonly, nonatomic, strong, class) AppStoreEnvironment * _Nonnull sandbox;
		[Static]
		[Export ("sandbox", ArgumentSemantic.Strong)]
		AppStoreEnvironment Sandbox { get; }

		// @property (readonly, nonatomic, strong, class) AppStoreEnvironment * _Nonnull xcode;
		[Static]
		[Export ("xcode", ArgumentSemantic.Strong)]
		AppStoreEnvironment Xcode { get; }

		// -(BOOL)isEqualToEnvironment:(AppStoreEnvironment * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToEnvironment:")]
		bool IsEqualToEnvironment ([NullAllowed] AppStoreEnvironment other);
	}

	// @interface AppStoreMerchandisingKindPresentationResult : NSObject
	[TV (26,0), NoMac, iOS (26,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AppStoreMerchandisingKindPresentationResult
	{
		// @property (readonly, nonatomic) BOOL isDismissed;
		[Export ("isDismissed")]
		bool IsDismissed { get; }

		// @property (readonly, nonatomic, strong) ProductPurchaseResult * _Nullable purchaseResult;
		[NullAllowed, Export ("purchaseResult", ArgumentSemantic.Strong)]
		ProductPurchaseResult PurchaseResult { get; }
	}

	delegate void AppStoreMerchandisingKindSubscriptionBundleHandler([NullAllowed] AppStoreMerchandisingKind result);

	// @interface AppStoreMerchandisingKind : NSObject
	[TV (26,0), NoMac, iOS (26,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AppStoreMerchandisingKind
	{
		// +(void)subscriptionBundle:(NSString * _Nonnull)groupID completion:(void (^ _Nonnull)(AppStoreMerchandisingKind * _Nullable))completion;
		[Static]
		[Export ("subscriptionBundle:completion:")]
		void SubscriptionBundle (string groupID, AppStoreMerchandisingKindSubscriptionBundleHandler appStoreMerchandisingKindSubscriptionBundleHandler);
	}

	// @interface AppStorePlatform : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AppStorePlatform
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) AppStorePlatform * _Nonnull iOS;
		[Static]
		[Export ("iOS", ArgumentSemantic.Strong)]
		AppStorePlatform IOS { get; }

		// @property (readonly, nonatomic, strong, class) AppStorePlatform * _Nonnull macOS;
		[Static]
		[Export ("macOS", ArgumentSemantic.Strong)]
		AppStorePlatform MacOS { get; }

		// @property (readonly, nonatomic, strong, class) AppStorePlatform * _Nonnull tvOS;
		[Static]
		[Export ("tvOS", ArgumentSemantic.Strong)]
		AppStorePlatform TvOS { get; }

		// @property (readonly, nonatomic, strong, class) AppStorePlatform * _Nonnull visionOS;
		[Static]
		[Export ("visionOS", ArgumentSemantic.Strong)]
		AppStorePlatform VisionOS { get; }

		// @property (readonly, nonatomic, strong, class) AppStorePlatform * _Nonnull managed;
		[Static]
		[Export ("managed", ArgumentSemantic.Strong)]
		AppStorePlatform Managed { get; }

		// -(BOOL)isEqualToPlatform:(AppStorePlatform * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToPlatform:")]
		bool IsEqualToPlatform ([NullAllowed] AppStorePlatform other);
	}

	delegate void StoreErrorHandler([NullAllowed] NSError error);
	delegate void PresentOfferCodeRedeemSheetHandler ([NullAllowed] TransactionVerificationResult result, [NullAllowed] NSError error);
	delegate void PresentMerchandisingKindHandler(AppStoreMerchandisingKindPresentationResult result, [NullAllowed] NSError error);

	// @interface AppStore : NSObject
	[BaseType(typeof(NSObject))]
	interface AppStore
	{
		// +(BOOL)canMakePayments __attribute__((warn_unused_result(""))) __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
		[TV (15, 0), Mac (12, 0), iOS (15, 0)]
		[Static]
		[Export ("canMakePayments")]
		bool CanMakePayments { get; }

		// +(NSString * _Nullable)deviceVerificationIdString __attribute__((warn_unused_result(""))) __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
		[TV (15, 0), Mac (12, 0), iOS (15, 0)]
		[Static]
		[NullAllowed, Export ("deviceVerificationIdString")]
		string DeviceVerificationIdString { get; }

		// +(void)syncAppStoreAsyncWithCompletion:(void (^ _Nonnull)(NSError * _Nullable))completion __attribute__((availability(ios, introduced=15.0)));
		[iOS (15,0)]
		[Static]
		[Async]
		[Export ("syncAppStoreAsyncWithCompletion:")]
		void SyncAppStoreAsyncWithCompletion (StoreErrorHandler appStoreErrorHandler);

		// +(void)showManageSubscriptionsAsyncIn:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(NSError * _Nullable))completion __attribute__((availability(ios, introduced=15.0)));
		[iOS (15,0)]
		[Static]
		[Async]
		[Export ("showManageSubscriptionsAsyncIn:completion:")]
		void ShowManageSubscriptionsAsyncIn (UIWindowScene scene, StoreErrorHandler appStoreErrorHandler);

		// +(void)showManageSubscriptionsAsyncIn:(UIWindowScene * _Nonnull)scene subscriptionGroupID:(NSString * _Nonnull)subscriptionGroupID completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[iOS (17,0)]
		[Static]
		[Async]
		[Export ("showManageSubscriptionsAsyncIn:subscriptionGroupID:completion:")]
		void ShowManageSubscriptionsAsyncIn (UIWindowScene scene, string subscriptionGroupID, StoreErrorHandler appStoreErrorHandler);

		// +(void)presentOfferCodeRedeemSheetAsyncIn:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[NoTV, NoMac, iOS (16,0)]
		[Static]
		[Async]
		[Export ("presentOfferCodeRedeemSheetAsyncIn:completion:")]
		void PresentOfferCodeRedeemSheetAsyncIn (UIWindowScene scene, StoreErrorHandler appStoreErrorHandler);

		// +(void)presentOfferCodeRedeemSheetAsyncFrom:(UIViewController * _Nonnull)viewController options:(NSSet<RedeemOption *> * _Nonnull)options completion:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("presentOfferCodeRedeemSheetAsyncFrom:options:completion:")]
		void PresentOfferCodeRedeemSheetAsyncFrom (UIViewController viewController, RedeemOption[] options, PresentOfferCodeRedeemSheetHandler presentOfferCodeRedeemSheetHandler);

		// +(void)presentMerchandisingAsync:(AppStoreMerchandisingKind * _Nonnull)kind from:(UIViewController * _Nonnull)controller completion:(void (^ _Nonnull)(AppStoreMerchandisingKindPresentationResult * _Nonnull, NSError * _Nullable))completion;
		[TV (26,0), NoMac, iOS (26,0)]
		[Static]
		[Async]
		[Export ("presentMerchandisingAsync:from:completion:")]
		void PresentMerchandisingAsync (AppStoreMerchandisingKind kind, UIViewController controller, PresentMerchandisingKindHandler presentMerchandisingKindHandler);

		// +(void)requestReviewIn:(UIWindowScene * _Nonnull)scene;
		[NoTV, NoMac, iOS (16,0)]
		[Static]
		[Export ("requestReviewIn:")]
		void RequestReviewIn (UIWindowScene scene);
	}

	// @interface AppTransactionStoreType : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface AppTransactionStoreType {
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) AppTransactionStoreType * _Nonnull consumer;
		[Static]
		[Export ("consumer", ArgumentSemantic.Strong)]
		AppTransactionStoreType Consumer { get; }

		// @property (readonly, nonatomic, strong, class) AppTransactionStoreType * _Nonnull education;
		[Static]
		[Export ("education", ArgumentSemantic.Strong)]
		AppTransactionStoreType Education { get; }

		// @property (readonly, nonatomic, strong, class) AppTransactionStoreType * _Nonnull enterprise;
		[Static]
		[Export ("enterprise", ArgumentSemantic.Strong)]
		AppTransactionStoreType Enterprise { get; }

		// -(BOOL)isEqualToType:(AppTransactionStoreType * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToType:")]
		bool IsEqualToType ([NullAllowed] AppTransactionStoreType other);
	}

	// @interface AppTransactionVerificationResult : NSObject
	[TV (16,0), Mac (13,0), iOS (16,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AppTransactionVerificationResult
	{
		// @property (readonly, nonatomic) BOOL isVerified;
		[Export ("isVerified")]
		bool IsVerified { get; }

		// @property (readonly, nonatomic) enum VerificationErrorCode error;
		[Export ("error")]
		VerificationErrorCode Error { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull jwsRepresentation;
		[Export ("jwsRepresentation")]
		string JwsRepresentation { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull headerData;
		[Export ("headerData", ArgumentSemantic.Copy)]
		NSData HeaderData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull payloadData;
		[Export ("payloadData", ArgumentSemantic.Copy)]
		NSData PayloadData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull signatureData;
		[Export ("signatureData", ArgumentSemantic.Copy)]
		NSData SignatureData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull signedData;
		[Export ("signedData", ArgumentSemantic.Copy)]
		NSData SignedData { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
		[Export ("signedDate", ArgumentSemantic.Copy)]
		NSDate SignedDate { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
		[Export ("deviceVerification", ArgumentSemantic.Copy)]
		NSData DeviceVerification { get; }

		// @property (readonly, nonatomic, strong) NSUUID * _Nonnull deviceVerificationNonce;
		[Export ("deviceVerificationNonce", ArgumentSemantic.Strong)]
		NSUuid DeviceVerificationNonce { get; }

		// @property (readonly, nonatomic, strong) AppTransaction * _Nullable transaction;
		[NullAllowed, Export ("transaction", ArgumentSemantic.Strong)]
		AppTransaction Transaction { get; }

		// -(AppTransaction * _Nullable)getPayloadValueAndReturnError:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
		[Export ("getPayloadValueAndReturnError:")]
		[return: NullAllowed]
		AppTransaction GetPayloadValueAndReturnError ([NullAllowed] out NSError error);

		// -(AppTransaction * _Nullable)getUnsafePayloadValue __attribute__((warn_unused_result("")));
		[NullAllowed, Export ("getUnsafePayloadValue")]
		AppTransaction UnsafePayloadValue { get; }
	}

	delegate void AppTransactionsHandler([NullAllowed] AppTransaction[] appTransactions, [NullAllowed] NSError error);

	delegate void AppTransactionHandler([NullAllowed] AppTransaction appTransaction, [NullAllowed] NSError error);

	// @interface AppTransaction : NSObject
	[TV (16,0), Mac (13,0), iOS (16,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface AppTransaction
	{
		// @property (readonly, copy, nonatomic) NSData * _Nonnull jsonRepresentation;
		[Export ("jsonRepresentation", ArgumentSemantic.Copy)]
		NSData JsonRepresentation { get; }

		// @property (readonly, nonatomic, strong) NSNumber * _Nullable appID;
		[NullAllowed, Export ("appID", ArgumentSemantic.Strong)]
		NSNumber AppID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull appTransactionID;
		[Export ("appTransactionID")]
		string AppTransactionID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull appVersion;
		[Export ("appVersion")]
		string AppVersion { get; }

		// @property (readonly, nonatomic, strong) NSNumber * _Nullable appVersionID;
		[NullAllowed, Export ("appVersionID", ArgumentSemantic.Strong)]
		NSNumber AppVersionID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull bundleID;
		[Export ("bundleID")]
		string BundleID { get; }

		// @property (readonly, nonatomic, strong) AppStoreEnvironment * _Nullable environment;
		[NullAllowed, Export ("environment", ArgumentSemantic.Strong)]
		AppStoreEnvironment Environment { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull originalAppVersion;
		[Export ("originalAppVersion")]
		string OriginalAppVersion { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull originalPurchaseDate;
		[Export ("originalPurchaseDate", ArgumentSemantic.Copy)]
		NSDate OriginalPurchaseDate { get; }

		// @property (readonly, nonatomic, strong) AppStorePlatform * _Nullable originalPlatform;
		[TV (18, 4), Mac (15, 4), iOS (18, 4)]
		[NullAllowed, Export ("originalPlatform", ArgumentSemantic.Strong)]
		AppStorePlatform OriginalPlatform { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable originalPlatformStringRepresentation;
		[NullAllowed, Export ("originalPlatformStringRepresentation")]
		string OriginalPlatformStringRepresentation { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nullable preorderDate;
		[NullAllowed, Export ("preorderDate", ArgumentSemantic.Copy)]
		NSDate PreorderDate { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
		[Export ("deviceVerification", ArgumentSemantic.Copy)]
		NSData DeviceVerification { get; }

		// @property (readonly, nonatomic, strong) NSUUID * _Nonnull deviceVerificationNonce;
		[Export ("deviceVerificationNonce", ArgumentSemantic.Strong)]
		NSUuid DeviceVerificationNonce { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nullable revocationDate;
		[NullAllowed, Export ("revocationDate", ArgumentSemantic.Copy)]
		NSDate RevocationDate { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
		[Export ("signedDate", ArgumentSemantic.Copy)]
		NSDate SignedDate { get; }

		// @property (readonly, nonatomic, strong) AppTransactionStoreType * _Nullable storeType;
		[NullAllowed, Export ("storeType", ArgumentSemantic.Strong)]
		AppTransactionStoreType StoreType { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull storeTypeStringRepresentation;
		[Export ("storeTypeStringRepresentation")]
		string StoreTypeStringRepresentation { get; }

		// +(void)getAllTransactionsAsyncWithCompletion:(void (^ _Nonnull)(NSArray<AppTransaction *> * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("getAllTransactionsAsyncWithCompletion:")]
		void GetAllTransactionsAsyncWithCompletion (AppTransactionsHandler appTransactionsHandler);

		// +(void)getSharedTransactionAsyncWithCompletion:(void (^ _Nonnull)(AppTransaction * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("getSharedTransactionAsyncWithCompletion:")]
		void GetSharedTransactionAsyncWithCompletion (AppTransactionHandler appTransactionHandler);

		// +(void)refreshTransactionAsyncWithCompletion:(void (^ _Nonnull)(AppTransaction * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("refreshTransactionAsyncWithCompletion:")]
		void RefreshTransactionAsyncWithCompletion (AppTransactionHandler appTransactionHandler);
	}

	// @interface BillingPlanType : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface BillingPlanType {
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) BillingPlanType * _Nonnull monthly;
		[Static]
		[Export ("monthly", ArgumentSemantic.Strong)]
		BillingPlanType Monthly { get; }

		// @property (readonly, nonatomic, strong, class) BillingPlanType * _Nonnull upFront;
		[Static]
		[Export ("upFront", ArgumentSemantic.Strong)]
		BillingPlanType UpFront { get; }

		// -(BOOL)isEqualToType:(BillingPlanType * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToType:")]
		bool IsEqualToType ([NullAllowed] BillingPlanType other);
	}

	// @interface BundledSubscription : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface BundledSubscription {
		// @property (readonly, copy, nonatomic) NSString * _Nonnull id;
		[Export ("id")]
		string Id { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull displayName;
		[Export ("displayName")]
		string DisplayName { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull subscriptionDescription;
		[Export ("subscriptionDescription")]
		string SubscriptionDescription { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull price;
		[Export ("price", ArgumentSemantic.Strong)]
		NSDecimalNumber Price { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull displayPrice;
		[Export ("displayPrice")]
		string DisplayPrice { get; }

		// @property (readonly, nonatomic) BOOL isFamilyShareable;
		[Export ("isFamilyShareable")]
		bool IsFamilyShareable { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull subscriptionGroupID;
		[Export ("subscriptionGroupID")]
		string SubscriptionGroupID { get; }

		// @property (readonly, nonatomic) NSInteger subscriptionGroupLevel;
		[Export ("subscriptionGroupLevel")]
		nint SubscriptionGroupLevel { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull subscriptionGroupDisplayName;
		[Export ("subscriptionGroupDisplayName")]
		string SubscriptionGroupDisplayName { get; }
	}

	// @interface CommitmentInfo : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface CommitmentInfo {
		// @property (readonly, copy, nonatomic) NSString * _Nonnull autoRenewPreference;
		[Export ("autoRenewPreference")]
		string AutoRenewPreference { get; }

		// @property (readonly, nonatomic, strong) BillingPlanType * _Nonnull renewalBillingPlanType;
		[Export ("renewalBillingPlanType", ArgumentSemantic.Strong)]
		BillingPlanType RenewalBillingPlanType { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull renewalDate;
		[Export ("renewalDate", ArgumentSemantic.Copy)]
		NSDate RenewalDate { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull renewalPrice;
		[Export ("renewalPrice", ArgumentSemantic.Strong)]
		NSDecimalNumber RenewalPrice { get; }

		// @property (readonly, nonatomic) BOOL willAutoRenew;
		[Export ("willAutoRenew")]
		bool WillAutoRenew { get; }
	}

	// @interface CurrencyWrapper : NSObject
	[TV (16,0), Mac (13,0), iOS (16,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface CurrencyWrapper
	{
		// -(NSString * _Nonnull)currencyCode __attribute__((warn_unused_result("")));
		[Export ("currencyCode")]
		string CurrencyCode { get; }

		// -(BOOL)isISOCurrency __attribute__((warn_unused_result("")));
		[Export ("isISOCurrency")]
		bool IsISOCurrency { get; }

		// -(BOOL)isEqualToCurrency:(CurrencyWrapper * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToCurrency:")]
		bool IsEqualToCurrency ([NullAllowed] CurrencyWrapper other);
	}

	// @interface ExpirationReason : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ExpirationReason
	{
		// @property (readonly, nonatomic) NSInteger rawValue;
		[Export ("rawValue")]
		int RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSInteger)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (int rawValue);

		// @property (readonly, nonatomic, strong, class) ExpirationReason * _Nonnull autoRenewDisabled;
		[Static]
		[Export ("autoRenewDisabled", ArgumentSemantic.Strong)]
		ExpirationReason AutoRenewDisabled { get; }

		// @property (readonly, nonatomic, strong, class) ExpirationReason * _Nonnull billingError;
		[Static]
		[Export ("billingError", ArgumentSemantic.Strong)]
		ExpirationReason BillingError { get; }

		// @property (readonly, nonatomic, strong, class) ExpirationReason * _Nonnull didNotConsentToPriceIncrease;
		[Static]
		[Export ("didNotConsentToPriceIncrease", ArgumentSemantic.Strong)]
		ExpirationReason DidNotConsentToPriceIncrease { get; }

		// @property (readonly, nonatomic, strong, class) ExpirationReason * _Nonnull productUnavailable;
		[Static]
		[Export ("productUnavailable", ArgumentSemantic.Strong)]
		ExpirationReason ProductUnavailable { get; }

		// @property (readonly, nonatomic, strong, class) ExpirationReason * _Nonnull unknown;
		[Static]
		[Export ("unknown", ArgumentSemantic.Strong)]
		ExpirationReason Unknown { get; }

		// @property (readonly, nonatomic, strong, class) ExpirationReason * _Nonnull unbundled;
		[Static]
		[Export ("unbundled", ArgumentSemantic.Strong)]
		ExpirationReason Unbundled { get; }

		// -(BOOL)isEqualToReason:(ExpirationReason * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToReason:")]
		bool IsEqualToReason ([NullAllowed] ExpirationReason other);
	}

	delegate void ExternalLinkCanOpenHandler(bool canOpen);

	delegate void ExternalLinkOpenHandler([NullAllowed] NSError error);

	// @interface ExternalLinkAccount : NSObject
	[TV (16,4), NoMac, iOS (16,0)]
	[BaseType(typeof(NSObject))]
	interface ExternalLinkAccount
	{
		// +(void)canOpenAsyncWithCompletion:(void (^ _Nonnull)(BOOL))completion;
		[Static]
		[Async]
		[Export ("canOpenAsyncWithCompletion:")]
		void CanOpenAsyncWithCompletion (ExternalLinkCanOpenHandler externalLinkCanOpenHandler);

		// +(void)openAsyncWithCompletion:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("openAsyncWithCompletion:")]
		void OpenAsyncWithCompletion (ExternalLinkOpenHandler externalLinkOpenHandler);
	}

	// @interface ExternalPurchaseCustomLinkNoticeResult : NSObject
	[TV (18,1), Mac (15,1), iOS (18,1)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ExternalPurchaseCustomLinkNoticeResult
	{
		// @property (readonly, nonatomic) BOOL isCancelled;
		[Export ("isCancelled")]
		bool IsCancelled { get; }
	}

	// @interface ExternalPurchaseCustomLinkToken : NSObject
	[TV (18,1), Mac (15,1), iOS (18,1)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ExternalPurchaseCustomLinkToken
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull value;
		[Export ("value")]
		string Value { get; }
	}

	delegate void ExternalPurchaseCustomLinkEligibleHandler(bool isEligible);

	delegate void PresentExternalPurchaseCustomLinkHandler ([NullAllowed] ExternalPurchaseCustomLinkNoticeResult result, [NullAllowed] NSError error);

	// @interface ExternalPurchaseCustomLink
	[TV (18,1), Mac (15,1), iOS (18,1)]
	[BaseType(typeof(NSObject))]
	interface ExternalPurchaseCustomLink
	{
		// +(void)isEligibleAsyncWithCompletion:(void (^ _Nonnull)(BOOL))completion;
		[Static]
		[Async]
		[Export ("isEligibleAsyncWithCompletion:")]
		void IsEligibleAsyncWithCompletion (ExternalPurchaseCustomLinkEligibleHandler externalPurchaseCustomLinkEligibleHandler);

		// +(void)showNoticeAsyncWithType:(enum ExternalPurchaseCustomLinkNoticeType)type completion:(void (^ _Nonnull)(ExternalPurchaseCustomLinkNoticeResult * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("showNoticeAsyncWithType:completion:")]
		void ShowNoticeAsyncWithType (ExternalPurchaseCustomLinkNoticeType type, PresentExternalPurchaseCustomLinkHandler presentExternalPurchaseCustomLinkHandler);

		// +(void)getTokenAsyncFor:(NSString * _Nonnull)tokenType completion:(void (^ _Nonnull)(ExternalPurchaseCustomLinkToken * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("getTokenAsyncFor:completion:")]
		void GetTokenAsyncFor (string tokenType, PresentExternalPurchaseCustomLinkHandler presentExternalPurchaseCustomLinkHandler);
	}

	delegate void ExternalPurchaseLinkCanOpenHandler(bool canOpen);
	delegate void ExternalPurchaseLinkOpenHandler([NullAllowed] NSError error);
	delegate void ExternalPurchaseLinkEligibilityHandler([NullAllowed] NSUrl[] link);

	// @interface ExternalPurchaseLink : NSObject
	[TV (17,4), Mac (14,4), iOS (15,4)]
	[BaseType(typeof(NSObject))]
	interface ExternalPurchaseLink
	{
		// +(void)canOpenAsync:(void (^ _Nonnull)(BOOL))completion;
		[Static]
		[Async]
		[Export ("canOpenAsync:")]
		void CanOpenAsync (ExternalPurchaseLinkCanOpenHandler externalPurchaseLinkCanOpenHandler);

		// +(void)openAsync:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("openAsync:")]
		void OpenAsync (ExternalPurchaseLinkOpenHandler externalPurchaseLinkOpenHandler);

		// +(void)eligibleURLsAsync:(void (^ _Nonnull)(NSArray<NSURL *> * _Nullable))completion;
		[Static]
		[Async]
		[Export ("eligibleURLsAsync:")]
		void EligibleURLsAsync (ExternalPurchaseLinkEligibilityHandler externalPurchaseLinkEligibilityHandler);

		// +(void)openAsync:(NSURL * _Nonnull)url completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("openAsync:completion:")]
		void OpenAsync (NSUrl url, ExternalPurchaseLinkOpenHandler externalPurchaseLinkOpenHandler);
	}

	// @interface ExternalPurchaseNoticeResult : NSObject
	[TV (17,4), Mac (14,4), iOS (15,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ExternalPurchaseNoticeResult
	{
		// @property (readonly, nonatomic) BOOL isCancelled;
		[Export ("isCancelled")]
		bool IsCancelled { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable externalPurchaseToken;
		[NullAllowed, Export ("externalPurchaseToken")]
		string ExternalPurchaseToken { get; }
	}

	delegate void ExternalPurchaseCanPresentHandler(bool canPresent);
	delegate void PresentExternalPurchaseHandler ([NullAllowed] ExternalPurchaseNoticeResult result, [NullAllowed] NSError error);

	// @interface ExternalPurchase : NSObject
	[TV (17,4), Mac (14,4), iOS (15,4)]
	[BaseType(typeof(NSObject))]
	interface ExternalPurchase
	{
		// +(void)canPresentAsyncWithCompletion:(void (^ _Nonnull)(BOOL))completion;
		[Static]
		[Async]
		[Export ("canPresentAsyncWithCompletion:")]
		void CanPresentAsyncWithCompletion (ExternalPurchaseCanPresentHandler externalPurchaseCanPresentHandler);

		// +(void)presentNoticeSheetAsyncWithCompletion:(void (^ _Nonnull)(ExternalPurchaseNoticeResult * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("presentNoticeSheetAsyncWithCompletion:")]
		void PresentNoticeSheetAsyncWithCompletion (PresentExternalPurchaseHandler presentExternalPurchaseHandler);
	}

	// @interface InvalidRequestError : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface InvalidRequestError
	{
		// @property (readonly, nonatomic) int64_t code;
		[Export ("code")]
		long Code { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull message;
		[Export ("message")]
		string Message { get; }

		// -(instancetype _Nullable)initWithSwiftError:(id _Nullable)swiftError __attribute__((objc_designated_initializer));
		[Export ("initWithSwiftError:")]
		[DesignatedInitializer]
		NativeHandle Constructor ([NullAllowed] NSObject swiftError);

		// @property (readonly, nonatomic, strong) NSError * _Nonnull nsError;
		[Export ("nsError", ArgumentSemantic.Strong)]
		NSError NsError { get; }
	}

	// @interface MessageReason : NSObject
	[NoTV, NoMac, iOS (16,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface MessageReason
	{
		// @property (readonly, nonatomic) NSInteger rawValue;
		[Export ("rawValue")]
		int RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSInteger)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (nint rawValue);

		// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull generic;
		[Static]
		[Export ("generic", ArgumentSemantic.Strong)]
		MessageReason Generic { get; }

		// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull priceIncreaseConsent;
		[Static]
		[Export ("priceIncreaseConsent", ArgumentSemantic.Strong)]
		MessageReason PriceIncreaseConsent { get; }

		// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull billingIssue;
		[iOS (16, 4)]
		[Static]
		[Export ("billingIssue", ArgumentSemantic.Strong)]
		MessageReason BillingIssue { get; }

		// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull winBackOffer;
		[iOS (18, 0)]
		[Static]
		[Export ("winBackOffer", ArgumentSemantic.Strong)]
		MessageReason WinBackOffer { get; }

		// -(BOOL)isEqualToReason:(MessageReason * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToReason:")]
		bool IsEqualToReason ([NullAllowed] MessageReason other);

		// @property (readonly, copy, nonatomic) NSString * _Nonnull localizedDescription;
		[Export ("localizedDescription")]
		string LocalizedDescription { get; }
	}

	delegate void MessageCompletionHandler ([NullAllowed] Message[] messages, [NullAllowed] NSError error);

	// @interface Message : NSObject
	[NoTV, NoMac, iOS (16,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface Message
	{
		// @property (readonly, nonatomic, strong) MessageReason * _Nullable reason;
		[Export ("reason", ArgumentSemantic.Strong)]
		MessageReason Reason { get; }

		// -(BOOL)displayIn:(UIWindowScene * _Nonnull)scene error:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
		[Export ("displayIn:error:")]
		bool DisplayIn (UIWindowScene scene, [NullAllowed] out NSError error);

		// +(void)getMessagesWithCompletion:(void (^ _Nonnull)(NSArray<Message *> * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Export ("getMessagesWithCompletionHandler:")]
		void GetMessagesWithCompletionHandler (MessageCompletionHandler messageCompletionHandler);
	}

	// @interface PaymentMethodBindingError
	[NoTV, NoMac, iOS (16,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface PaymentMethodBindingError
	{
		// @property (readonly, nonatomic) enum PaymentMethodBindingErrorCode code;
		[Export ("code")]
		PaymentMethodBindingErrorCode Code { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable errorDescription;
		[NullAllowed, Export ("errorDescription")]
		string ErrorDescription { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable failureReason;
		[NullAllowed, Export ("failureReason")]
		string FailureReason { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable recoverySuggestion;
		[NullAllowed, Export ("recoverySuggestion")]
		string RecoverySuggestion { get; }

		// -(instancetype _Nonnull)initWithCode:(enum PaymentMethodBindingErrorCode)code description:(NSString * _Nullable)description reason:(NSString * _Nullable)reason suggestion:(NSString * _Nullable)suggestion __attribute__((objc_designated_initializer));
		[Export ("initWithCode:description:reason:suggestion:")]
		[DesignatedInitializer]
		NativeHandle Constructor (PaymentMethodBindingErrorCode code, [NullAllowed] string description, [NullAllowed] string reason, [NullAllowed] string suggestion);
	}

	delegate void PaymentMethodCreationHandler ([NullAllowed] PaymentMethodBinding methodBinding, [NullAllowed] NSError error);
	delegate void PaymentMethodBindingHandler ([NullAllowed] PaymentMethodBindingError methodBinding);

	// @interface PaymentMethodBinding
	[NoTV, NoMac, iOS (16,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface PaymentMethodBinding
	{
		// +(void)createAsyncWithId:(NSString * _Nonnull)id completion:(void (^ _Nonnull)(PaymentMethodBinding * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("createAsyncWithId:completion:")]
		void CreateAsyncWithId (string id, PaymentMethodCreationHandler paymentMethodCreationHandler);

		// -(void)bindAsyncWithCompletion:(void (^ _Nonnull)(PaymentMethodBindingError * _Nullable))completion;
		[Async]
		[Export ("bindAsyncWithCompletion:")]
		void BindAsyncWithCompletion (PaymentMethodBindingHandler paymentMethodBindingHandler);

		// @property (readonly, copy, nonatomic) NSString * _Nonnull pinningID;
		[NullAllowed, Export ("pinningID")]
		string PinningID { get; }
	}

	// @interface PricingTerms : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface PricingTerms {
		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull billingPrice;
		[Export ("billingPrice", ArgumentSemantic.Strong)]
		NSDecimalNumber BillingPrice { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull billingDisplayPrice;
		[Export ("billingDisplayPrice")]
		string BillingDisplayPrice { get; }

		// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nonnull billingPeriod;
		[Export ("billingPeriod", ArgumentSemantic.Strong)]
		ProductSubscriptionPeriod BillingPeriod { get; }

		// @property (readonly, nonatomic, strong) BillingPlanType * _Nonnull billingPlanType;
		[Export ("billingPlanType", ArgumentSemantic.Strong)]
		BillingPlanType BillingPlanType { get; }

		// @property (readonly, nonatomic, strong) CommitmentInfo * _Nullable commitmentInfo;
		[NullAllowed, Export ("commitmentInfo", ArgumentSemantic.Strong)]
		CommitmentInfo CommitmentInfo { get; }

		// @property (readonly, copy, nonatomic) NSArray<SubscriptionOffer *> * _Nonnull subscriptionOffers;
		[Export ("subscriptionOffers", ArgumentSemantic.Copy)]
		SubscriptionOffer [] SubscriptionOffers { get; }
	}

	// @interface PurchaseError : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface PurchaseError
	{
		// @property (readonly, nonatomic) enum PurchaseErrorCode code;
		[Export ("code")]
		PurchaseErrorCode Code { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable errorDescription;
		[NullAllowed, Export ("errorDescription")]
		string ErrorDescription { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable failureReason;
		[NullAllowed, Export ("failureReason")]
		string FailureReason { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable recoverySuggestion;
		[NullAllowed, Export ("recoverySuggestion")]
		string RecoverySuggestion { get; }
	}

	// @interface ProductPurchaseOptions : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ProductPurchaseOptions
	{
		// +(ProductPurchaseOptions * _Nonnull)appAccountToken:(NSUUID * _Nonnull)uuid __attribute__((warn_unused_result("")));
		[Static]
		[Export ("appAccountToken:")]
		ProductPurchaseOptions AppAccountToken (NSUuid uuid);

		// +(ProductPurchaseOptions * _Nullable)billingPlanType:(BillingPlanType * _Nonnull)type __attribute__((warn_unused_result("")));
		[Static]
		[Export ("billingPlanType:")]
		[return: NullAllowed]
		ProductPurchaseOptions BillingPlanType (BillingPlanType type);

		// +(ProductPurchaseOptions * _Nonnull)customStringWithKey:(NSString * _Nonnull)key value:(NSString * _Nonnull)value __attribute__((warn_unused_result("")));
		[Static]
		[Export ("customStringWithKey:value:")]
		ProductPurchaseOptions CustomStringWithKey (string key, string value);

		// +(ProductPurchaseOptions * _Nonnull)customDoubleWithKey:(NSString * _Nonnull)key value:(double)value __attribute__((warn_unused_result("")));
		[Static]
		[Export ("customDoubleWithKey:value:")]
		ProductPurchaseOptions CustomDoubleWithKey (string key, double value);

		// +(ProductPurchaseOptions * _Nonnull)customBoolWithKey:(NSString * _Nonnull)key value:(BOOL)value __attribute__((warn_unused_result("")));
		[Static]
		[Export ("customBoolWithKey:value:")]
		ProductPurchaseOptions CustomBoolWithKey (string key, bool value);

		// +(ProductPurchaseOptions * _Nonnull)customDataWithKey:(NSString * _Nonnull)key value:(NSData * _Nonnull)value __attribute__((warn_unused_result("")));
		[Static]
		[Export ("customDataWithKey:value:")]
		ProductPurchaseOptions CustomDataWithKey (string key, NSData value);

		// +(ProductPurchaseOptions * _Nonnull)onStorefrontChangeWithShouldContinuePurchase:(BOOL (^ _Nonnull)(StoreFront * _Nonnull))shouldContinuePurchase __attribute__((warn_unused_result("")));
		[Static]
		[Export ("onStorefrontChangeWithShouldContinuePurchase:")]
		ProductPurchaseOptions OnStorefrontChangeWithShouldContinuePurchase (Func<StoreFront, bool> callback);

		// +(ProductPurchaseOptions * _Nonnull)quantity:(NSInteger)quantity __attribute__((warn_unused_result("")));
		[Static]
		[Export ("quantity:")]
		ProductPurchaseOptions Quantity (nint quantity);

		// +(ProductPurchaseOptions * _Nonnull)simulateAskToBuy:(BOOL)simulate __attribute__((warn_unused_result("")));
		[Static]
		[Export ("simulateAskToBuy:")]
		ProductPurchaseOptions SimulateAskToBuy (bool simulate);

		// +(ProductPurchaseOptions * _Nonnull)promotionalOfferLegacyWithOfferID:(NSString * _Nonnull)offerID keyID:(NSString * _Nonnull)keyID nonce:(NSUUID * _Nonnull)nonce signature:(NSData * _Nonnull)signature timestamp:(NSInteger)timestamp __attribute__((warn_unused_result("")));
		[Static]
		[Export ("promotionalOfferLegacyWithOfferID:keyID:nonce:signature:timestamp:")]
		ProductPurchaseOptions PromotionalOfferLegacyWithOfferID (string offerID, string keyID, NSUuid nonce, NSData signature, nint timestamp);

		// +(ProductPurchaseOptions * _Nonnull)promotionalOfferWithOfferID:(NSString * _Nonnull)offerID keyID:(NSString * _Nonnull)keyID nonce:(NSUUID * _Nonnull)nonce signature:(NSData * _Nonnull)signature timestamp:(NSInteger)timestamp __attribute__((warn_unused_result(""))) __attribute__((availability(tvos, introduced=15.0, deprecated=26.0))) __attribute__((availability(macos, introduced=12.0, deprecated=26.0))) __attribute__((availability(ios, introduced=15.0, deprecated=26.0)));
		[Introduced (PlatformName.TvOS, 15, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Deprecated (PlatformName.TvOS, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Introduced (PlatformName.MacOSX, 12, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Deprecated (PlatformName.MacOSX, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Introduced (PlatformName.iOS, 15, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Deprecated (PlatformName.iOS, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Static]
		[Export ("promotionalOfferWithOfferID:keyID:nonce:signature:timestamp:")]
		ProductPurchaseOptions PromotionalOfferWithOfferID (string offerID, string keyID, NSUuid nonce, NSData signature, nint timestamp);

		// +(ProductPurchaseOptions * _Nullable)promotionalOfferWithOfferID:(NSString * _Nonnull)offerID signature:(SubscriptionOfferSignature * _Nonnull)signature __attribute__((warn_unused_result("")));
		[Introduced (PlatformName.TvOS, 17, 4, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Deprecated (PlatformName.TvOS, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Introduced (PlatformName.MacOSX, 14, 4, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Deprecated (PlatformName.MacOSX, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Introduced (PlatformName.iOS, 17, 4, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Deprecated (PlatformName.iOS, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
		[Static]
		[Export ("promotionalOfferWithOfferID:signature:")]
		[return: NullAllowed]
		ProductPurchaseOptions PromotionalOfferWithOfferID (string offerID, SubscriptionOfferSignature signature);

		// +(NSArray<ProductPurchaseOptions *> * _Nonnull)promotionalOfferWithOfferID:(NSString * _Nonnull)offerID compactJWS:(NSString * _Nonnull)compactJWS __attribute__((warn_unused_result("")));
		[Static]
		[Export ("promotionalOfferWithOfferID:compactJWS:")]
		ProductPurchaseOptions[] PromotionalOfferWithOfferID (string offerID, string compactJWS);

		// +(ProductPurchaseOptions * _Nullable)winBackOffer:(SubscriptionOffer * _Nonnull)offer __attribute__((warn_unused_result("")));
		[TV (18,0), Mac (15,0), iOS (18,0)]
		[Static]
		[Export ("winBackOffer:")]
		[return: NullAllowed]
		ProductPurchaseOptions WinBackOffer (SubscriptionOffer offer);

		// +(ProductPurchaseOptions * _Nonnull)introductoryOfferEligibilityWithCompactJWS:(NSString * _Nonnull)compactJWS __attribute__((warn_unused_result("")));
		[Static]
		[Export ("introductoryOfferEligibilityWithCompactJWS:")]
		ProductPurchaseOptions IntroductoryOfferEligibilityWithCompactJWS (string compactJWS);

		// -(BOOL)isEqualToOptions:(ProductPurchaseOptions * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToOptions:")]
		bool IsEqualToOptions ([NullAllowed] ProductPurchaseOptions other);
	}

	// @interface ProductPurchaseResult : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ProductPurchaseResult
	{
		// @property (nonatomic, strong) TransactionVerificationResult * _Nullable verificationresult;
		[NullAllowed, Export ("verificationresult", ArgumentSemantic.Strong)]
		TransactionVerificationResult Verificationresult { get; set; }
		
		// @property (readonly, nonatomic) BOOL isSuccess;
		[Export ("isSuccess")]
		bool IsSuccess { get; }

		// @property (readonly, nonatomic) BOOL isUserCancelled;
		[Export ("isUserCancelled")]
		bool IsUserCancelled { get; }

		// @property (readonly, nonatomic) BOOL isPending;
		[Export ("isPending")]
		bool IsPending { get; }
	}

	delegate void SubscriptionProductEligibilityHandler(bool isEligible);
	delegate void SubscriptionStatusesHandler([NullAllowed] SubscriptionStatus[] statuses, [NullAllowed] NSError error);
	delegate void SubscriptionStatusHandler([NullAllowed] SubscriptionStatus status, [NullAllowed] NSError error);
	delegate void UpdateSubscriptionStatusesHandler([NullAllowed] SubscriptionStatus[] status);
	delegate void AllSubscriptionStatusesHandler([NullAllowed] NSDictionary<NSString, NSArray> results);

	// @interface ProductSubscriptionInfo : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ProductSubscriptionInfo
	{
		// @property (readonly, nonatomic, strong) SubscriptionOffer * _Nullable introductoryOffer;
		[NullAllowed, Export ("introductoryOffer", ArgumentSemantic.Strong)]
		SubscriptionOffer IntroductoryOffer { get; }

		// @property (readonly, nonatomic, strong) NSArray * _Nonnull promotionalOffers;
		[Export ("promotionalOffers", ArgumentSemantic.Strong)]
		SubscriptionOffer[] PromotionalOffers { get; }

		// @property (readonly, nonatomic, strong) NSArray * _Nonnull winBackOffers;
		[TV (18, 0), Mac (15, 0), iOS (18, 0)]
		[Export ("winBackOffers", ArgumentSemantic.Strong)]
		SubscriptionOffer[] WinBackOffers { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull subscriptionGroupID;
		[Export ("subscriptionGroupID")]
		string SubscriptionGroupID { get; }

		// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nonnull subscriptionPeriod;
		[Export ("subscriptionPeriod", ArgumentSemantic.Strong)]
		ProductSubscriptionPeriod SubscriptionPeriod { get; }

		// @property (readonly, copy, nonatomic) NSArray<PricingTerms *> * _Nonnull pricingTerms;
		[Export ("pricingTerms", ArgumentSemantic.Copy)]
		PricingTerms [] PricingTerms { get; }

		// @property (readonly, copy, nonatomic) NSArray<BundledSubscription *> * _Nonnull bundledSubscriptions;
		[Export ("bundledSubscriptions", ArgumentSemantic.Copy)]
		BundledSubscription [] BundledSubscriptions { get; }

		// -(void)isEligibleForIntroOfferAsyncWithCompletion:(void (^ _Nonnull)(BOOL))completion;
		[Async]
		[Export ("isEligibleForIntroOfferAsyncWithCompletion:")]
		void IsEligibleForIntroOfferAsyncWithCompletion (SubscriptionProductEligibilityHandler productSubscriptionEligibilityHandler);

		// +(void)isEligibleForIntroOfferAsyncForGroupID:(NSString * _Nonnull)groupID completion:(void (^ _Nonnull)(BOOL))completion;
		[Static]
		[Async]
		[Export ("isEligibleForIntroOfferAsyncForGroupID:completion:")]
		void IsEligibleForIntroOfferAsyncForGroupID (string groupID, SubscriptionProductEligibilityHandler productSubscriptionEligibilityHandler);

		// -(void)statusAsync:(void (^ _Nonnull)(NSArray<SubscriptionStatus *> * _Nullable, NSError * _Nullable))completion;
		[Async]
		[Export ("statusAsync:")]
		void StatusAsync (SubscriptionStatusesHandler subscriptionStatusesHandler);

		// +(void)statusForGroupIDAsync:(NSString * _Nonnull)groupID completion:(void (^ _Nonnull)(NSArray<SubscriptionStatus *> * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("statusForGroupIDAsync:completion:")]
		void StatusForGroupIDAsync (string groupID, SubscriptionStatusesHandler subscriptionStatusesHandler);

		// +(void)statusForTransactionIDAsync:(NSNumber * _Nonnull)transactionID completion:(void (^ _Nonnull)(SubscriptionStatus * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("statusForTransactionIDAsync:completion:")]
		void StatusForTransactionIDAsync (NSNumber transactionID, SubscriptionStatusHandler subscriptionStatusHandler);

		// @property (readonly, nonatomic) NSInteger groupLevelValue;
		[TV (16, 4), Mac (13, 3), iOS (16, 4)]
		[Export ("groupLevelValue")]
		int GroupLevelValue { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull groupDisplayName;
		[TV (16, 4), Mac (13, 3), iOS (16, 4)]
		[Export ("groupDisplayName")]
		string GroupDisplayName { get; }

		// +(void)updateAsyncWithCompletion:(void (^ _Nonnull)(NSArray<SubscriptionStatus *> * _Nonnull))completion;
		[TV (18,4), Mac (15,4), iOS (18,4)]
		[Static]
		[Async]
		[Export ("updateAsyncWithCompletion:")]
		void UpdateAsyncWithCompletion (UpdateSubscriptionStatusesHandler updateSubscriptionStatusesHandler);

		// +(void)allStatusesAsyncWithCompletion:(void (^ _Nonnull)(NSDictionary<NSString *,NSArray<SubscriptionStatus *> *> * _Nonnull))completion;
		[TV (17,0), Mac (14,0), iOS (17,0)]
		[Static]
		[Async]
		[Export ("allStatusesAsyncWithCompletion:")]
		void AllStatusesAsyncWithCompletion (AllSubscriptionStatusesHandler allSubscriptionStatusesHandler);
	}

	// @interface SubscriptionOffer
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface SubscriptionOffer
	{
		// @property (readonly, copy, nonatomic) NSString * _Nullable offerId;
		[NullAllowed, Export ("offerId")]
		string OfferId { get; }

		// @property (readonly, nonatomic, strong) SubscriptionOfferType * _Nonnull offerType;
		[Export ("offerType", ArgumentSemantic.Strong)]
		SubscriptionOfferType OfferType { get; }

		// @property (readonly, nonatomic, strong) SubscriptionOfferPaymentMode * _Nonnull paymentMode;
		[Export ("paymentMode", ArgumentSemantic.Strong)]
		SubscriptionOfferPaymentMode PaymentMode { get; }

		// @property (readonly, nonatomic) NSInteger periodCount;
		[Export ("periodCount")]
		int PeriodCount { get; }

		// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nonnull period;
		[Export ("period", ArgumentSemantic.Strong)]
		ProductSubscriptionPeriod Period { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull displayPrice;
		[Export ("displayPrice")]
		string DisplayPrice { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull price;
		[Export ("price", ArgumentSemantic.Strong)]
		NSDecimalNumber Price { get; }
	}

	// @interface ProductSubscriptionPeriod : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ProductSubscriptionPeriod
	{
		// @property (readonly, nonatomic) enum Unit unit;
		[Export ("unit")]
		Unit Unit { get; }

		// @property (readonly, nonatomic) NSInteger value;
		[Export ("value")]
		int Value { get; }
	}

	// @interface ProductType : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface ProductType
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull consumable;
		[Static]
		[Export ("consumable", ArgumentSemantic.Strong)]
		ProductType Consumable { get; }

		// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull nonConsumable;
		[Static]
		[Export ("nonConsumable", ArgumentSemantic.Strong)]
		ProductType NonConsumable { get; }

		// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull nonRenewable;
		[Static]
		[Export ("nonRenewable", ArgumentSemantic.Strong)]
		ProductType NonRenewable { get; }

		// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull autoRenewable;
		[Static]
		[Export ("autoRenewable", ArgumentSemantic.Strong)]
		ProductType AutoRenewable { get; }

		// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull subscriptionBundle;
		[Static]
		[Export ("subscriptionBundle", ArgumentSemantic.Strong)]
		ProductType SubscriptionBundle { get; }

		// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull subscriptionSuite;
		[Static]
		[Export ("subscriptionSuite", ArgumentSemantic.Strong)]
		ProductType SubscriptionSuite { get; }

		// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull unknown;
		[Static]
		[Export ("unknown", ArgumentSemantic.Strong)]
		ProductType Unknown { get; }

		// -(BOOL)isEqualToType:(ProductType * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToType:")]
		bool IsEqualToType ([NullAllowed] ProductType other);
	}

	delegate void ProductsForIdentifiersHandler([NullAllowed] Product[] products, [NullAllowed] NSError error);
	delegate void TransactionResultHandler([NullAllowed] TransactionVerificationResult transaction);
	delegate void ProductEntitlementHandler([NullAllowed] TransactionVerificationResult transaction, [NullAllowed] NSError error);
	delegate void ProductEntitlementsHandler(TransactionVerificationResult[] transactions, [NullAllowed] NSError error);

	// @interface Product : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface Product
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull productID;
		[Export ("productID")]
		string ProductID { get; }

		// @property (readonly, nonatomic, strong) ProductType * _Nonnull type;
		[Export ("type", ArgumentSemantic.Strong)]
		ProductType Type { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull displayName;
		[Export ("displayName")]
		string DisplayName { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull productDescription;
		[Export ("productDescription")]
		string ProductDescription { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull price;
		[Export ("price", ArgumentSemantic.Strong)]
		NSDecimalNumber Price { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull displayPrice;
		[Export ("displayPrice")]
		string DisplayPrice { get; }

		// @property (readonly, nonatomic) BOOL isFamilyShareable;
		[Export ("isFamilyShareable")]
		bool IsFamilyShareable { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull jsonRepresentation;
		[Export ("jsonRepresentation", ArgumentSemantic.Copy)]
		NSData JsonRepresentation { get; }

		// @property (readonly, nonatomic, strong) SWIFT_AVAILABILITY(tvos,introduced=15.0) ProductSubscriptionInfo * subscription __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
		[TV (15,0), Mac (12,0), iOS (15,0)]
		[Export ("subscription", ArgumentSemantic.Strong)]
		ProductSubscriptionInfo Subscription { get; }

		// -(void)purchaseAsyncWithOptions:(NSArray<ProductPurchaseOptions *> * _Nonnull)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
		[TV (15,0), Mac (12,0), iOS (15,0)]
		[Async]
		[Export ("purchaseAsyncWithOptions:completion:")]
		void PurchaseAsyncWithOptions (ProductPurchaseOptions[] options, PurchaseResultHandler purchaseResultHandler);

		// -(void)purchaseInSceneAsync:(UIScene * _Nonnull)scene options:(NSArray<ProductPurchaseOptions *> * _Nonnull)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion;
		[TV (17,0), NoMac, iOS (17,0)]
		[Async]
		[Export ("purchaseInSceneAsync:options:completion:")]
		void PurchaseInSceneAsync (UIScene scene, ProductPurchaseOptions[] options, PurchaseResultHandler purchaseResultHandler);

		// -(void)purchaseInViewControllerAsync:(UIViewController * _Nonnull)viewController options:(NSArray<ProductPurchaseOptions *> * _Nonnull)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion;
		[TV (18,2), NoMac, iOS (18,2)]
		[Async]
		[Export ("purchaseInViewControllerAsync:options:completion:")]
		void PurchaseInViewControllerAsync (UIViewController viewController, ProductPurchaseOptions[] options, PurchaseResultHandler purchaseResultHandler);

		// +(void)productsWithIdentifiersAsync:(NSArray<NSString *> * _Nonnull)identifiers completion:(void (^ _Nonnull)(NSArray<Product *> * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("productsWithIdentifiersAsync:completion:")]
		void ProductsWithIdentifiersAsync (string[] identifiers, ProductsForIdentifiersHandler productsForIdentifiersHandler);

		// -(void)latestTransactionWithCompletionAsync:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion;
		[Async]
		[Export ("latestTransactionWithCompletionAsync:")]
		void LatestTransactionWithCompletionAsync (TransactionResultHandler transactionResultHandler);

		// -(void)currentEntitlementWithCompletionAsync:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable, NSError * _Nullable))completion __attribute__((availability(tvos, introduced=15.0, deprecated=18.4))) __attribute__((availability(macos, introduced=12.0, deprecated=15.4))) __attribute__((availability(ios, introduced=15.0, deprecated=18.4)));
		[Introduced (PlatformName.TvOS, 15, 0, message: "Use the currentEntitlements property instead.")]
		[Deprecated (PlatformName.TvOS, 18, 4, message: "Use the currentEntitlements property instead.")]
		[Introduced (PlatformName.MacOSX, 12, 0, message: "Use the currentEntitlements property instead.")]
		[Deprecated (PlatformName.MacOSX, 15, 4, message: "Use the currentEntitlements property instead.")]
		[Introduced (PlatformName.iOS, 15, 0, message: "Use the currentEntitlements property instead.")]
		[Deprecated (PlatformName.iOS, 18, 4, message: "Use the currentEntitlements property instead.")]
		[Async]
		[Export ("currentEntitlementWithCompletionAsync:")]
		void CurrentEntitlementWithCompletionAsync (ProductEntitlementHandler productEntitlementHandler);

		// -(void)currentEntitlementsWithCompletionAsync:(void (^ _Nonnull)(NSArray<TransactionVerificationResult *> * _Nonnull, NSError * _Nullable))completion;
		[TV (18,4), Mac (15,4), iOS (18,4)]
		[Async]
		[Export ("currentEntitlementsWithCompletionAsync:")]
		void CurrentEntitlementsWithCompletionAsync (ProductEntitlementsHandler productEntitlementsHandler);
	}

	delegate void PromotionCurrentOrderHandler([NullAllowed] PromotionInfo promotion, [NullAllowed] NSError error);

	// @interface PromotionInfo : NSObject
	[NoTV, NoMac, iOS (16,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface PromotionInfo
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull productID;
		[Export ("productID")]
		string ProductID { get; }

		// @property (readonly, nonatomic) enum Visibility visibility;
		[Export ("visibility")]
		Visibility Visibility { get; }

		// -(void)updateAsync:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[Async]
		[Export ("updateAsync:")]
		void UpdateAsync (StoreErrorHandler errorHandler);

		// +(void)currentOrderAsync:(void (^ _Nonnull)(NSArray<PromotionInfo *> * _Nullable, NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("currentOrderAsync:")]
		void CurrentOrderAsync (PromotionCurrentOrderHandler promotionCurrentOrderHandler);

		// +(void)updateProductOrderAsyncByID:(NSArray<NSString *> * _Nonnull)order completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("updateProductOrderAsyncByID:completion:")]
		void UpdateProductOrderAsyncByID (string[] order, StoreErrorHandler errorHandler);

		// +(void)updateProductVisibilityAsync:(enum Visibility)visibility for:(NSString * _Nonnull)productID completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("updateProductVisibilityAsync:for:completion:")]
		void UpdateProductVisibilityAsync (Visibility visibility, string productID, StoreErrorHandler errorHandler);

		// +(void)updateAllAsync:(NSArray<PromotionInfo *> * _Nonnull)promotions completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
		[Static]
		[Async]
		[Export ("updateAllAsync:completion:")]
		void UpdateAllAsync (PromotionInfo[] promotions, StoreErrorHandler errorHandler);
	}

	delegate void ObservePurchaseIntentHandler([NullAllowed] PurchaseIntent intent);

	// @interface PurchaseIntent : NSObject
	[NoTV, Mac (14,4), iOS (16,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface PurchaseIntent
	{
		// @property (readonly, nonatomic, strong) Product * _Nonnull product;
		[NullAllowed, Export ("product", ArgumentSemantic.Strong)]
		Product Product { get; }

		// @property (readonly, nonatomic, strong) SubscriptionOffer * _Nullable offer;
		[NullAllowed, Export ("offer", ArgumentSemantic.Strong)]
		SubscriptionOffer Offer { get; }

		// @property (readonly, nonatomic, strong) NSString * _Nonnull identifier;
		[Export ("identifier", ArgumentSemantic.Strong)]
		string Identifier { get; }

		// +(void)observeIntentsAsyncWithIntentHandler:(void (^ _Nonnull)(PurchaseIntent * _Nullable))intentHandler completion:(void (^ _Nonnull)(void))completion;
		[Static]
		[Async]
		[Export ("observeIntentsAsyncWithIntentHandler:completion:")]
		void ObserveIntentsAsyncWithIntentHandler (ObservePurchaseIntentHandler intentHandler, Action completion);
	}

	// @interface RedeemOption : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface RedeemOption {
	}

	// @interface RefundRequestError : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface RefundRequestError
	{
		// @property (readonly, nonatomic) enum RefundRequestErrorCode code;
		[Export ("code")]
		RefundRequestErrorCode Code { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable errorDescription;
		[NullAllowed, Export ("errorDescription")]
		string ErrorDescription { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable failureReason;
		[NullAllowed, Export ("failureReason")]
		string FailureReason { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable recoverySuggestion;
		[NullAllowed, Export ("recoverySuggestion")]
		string RecoverySuggestion { get; }
	}

	// @interface RenewalInfoVerificationResult : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface RenewalInfoVerificationResult
	{
		// @property (readonly, nonatomic) BOOL isVerified;
		[Export ("isVerified")]
		bool IsVerified { get; }

		// @property (readonly, nonatomic) enum VerificationErrorCode error;
		[Export ("error")]
		VerificationErrorCode Error { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull jwsRepresentation;
		[Export ("jwsRepresentation")]
		string JwsRepresentation { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull headerData;
		[Export ("headerData", ArgumentSemantic.Copy)]
		NSData HeaderData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull payloadData;
		[Export ("payloadData", ArgumentSemantic.Copy)]
		NSData PayloadData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull signatureData;
		[Export ("signatureData", ArgumentSemantic.Copy)]
		NSData SignatureData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull signedData;
		[Export ("signedData", ArgumentSemantic.Copy)]
		NSData SignedData { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
		[Export ("signedDate", ArgumentSemantic.Copy)]
		NSDate SignedDate { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
		[Export ("deviceVerification", ArgumentSemantic.Copy)]
		NSData DeviceVerification { get; }

		// @property (readonly, nonatomic, strong) NSUUID * _Nonnull deviceVerificationNonce;
		[Export ("deviceVerificationNonce", ArgumentSemantic.Strong)]
		NSUuid DeviceVerificationNonce { get; }

		// @property (readonly, nonatomic, strong) RenewalInfo * _Nonnull transaction;
		[Export ("transaction", ArgumentSemantic.Strong)]
		RenewalInfo Transaction { get; }

		// -(RenewalInfo * _Nullable)getPayloadValueAndReturnError:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
		[Export ("getPayloadValueAndReturnError:")]
		[return: NullAllowed]
		RenewalInfo GetPayloadValueAndReturnError ([NullAllowed] out NSError error);

		// -(RenewalInfo * _Nonnull)getUnsafePayloadValue __attribute__((warn_unused_result("")));
		[Export ("getUnsafePayloadValue")]
		RenewalInfo UnsafePayloadValue { get; }
	}

	// @interface RenewalInfo : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface RenewalInfo
	{
		// @property (readonly, nonatomic, strong) NSNumber * _Nonnull originalTransactionID;
		[Export ("originalTransactionID", ArgumentSemantic.Strong)]
		NSNumber OriginalTransactionID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull currentProductID;
		[Export ("currentProductID")]
		string CurrentProductID { get; }

		// @property (readonly, nonatomic) BOOL willAutoRenew;
		[Export ("willAutoRenew")]
		bool WillAutoRenew { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable autoRenewPreference;
		[NullAllowed, Export ("autoRenewPreference")]
		string AutoRenewPreference { get; }

		// @property (readonly, nonatomic, strong) ExpirationReason * _Nonnull expirationReason;
		[Export ("expirationReason", ArgumentSemantic.Strong)]
		ExpirationReason ExpirationReason { get; }

		// @property (readonly, nonatomic) enum PriceIncreaseStatus priceIncreaseStatus;
		[Export ("priceIncreaseStatus")]
		PriceIncreaseStatus PriceIncreaseStatus { get; }

		// @property (readonly, nonatomic) BOOL willAutoRenew;
		[Export ("isInBillingRetry")]
		bool IsInBillingRetry { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nullable gracePeriodExpirationDate;
		[NullAllowed, Export ("gracePeriodExpirationDate", ArgumentSemantic.Copy)]
		NSDate GracePeriodExpirationDate { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable offerID;
		[NullAllowed, Export ("offerID")]
		string OfferID { get; }

		// @property (readonly, nonatomic) enum TransactionOfferType offerType;
		[Export ("offerType")]
		TransactionOfferType OfferType { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull environmentStringRepresentation;
		[Export ("environmentStringRepresentation")]
		string EnvironmentStringRepresentation { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull recentSubscriptionStartDate;
		[Export ("recentSubscriptionStartDate", ArgumentSemantic.Copy)]
		NSDate RecentSubscriptionStartDate { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nullable renewalDate;
		[NullAllowed, Export ("renewalDate", ArgumentSemantic.Copy)]
		NSDate RenewalDate { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nullable renewalPrice;
		[NullAllowed, Export ("renewalPrice", ArgumentSemantic.Strong)]
		NSDecimalNumber RenewalPrice { get; }

		// @property (readonly, nonatomic, strong) CurrencyWrapper * _Nullable currency;
		[TV (16, 0), Mac (13, 0), iOS (16, 0)]
		[Export ("currency", ArgumentSemantic.Strong)]
		CurrencyWrapper Currency { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable currencyCode;
		[NullAllowed, Export ("currencyCode")]
		string CurrencyCode { get; }

		// @property (readonly, nonatomic, strong) NSArray * _Nonnull eligibleWinBackOfferIDs;
		[TV (18, 0), Mac (15, 0), iOS (18, 0)]
		[Export ("eligibleWinBackOfferIDs", ArgumentSemantic.Strong)]
		string[] EligibleWinBackOfferIDs { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
		[Export ("deviceVerification", ArgumentSemantic.Copy)]
		NSData DeviceVerification { get; }

		// @property (readonly, copy, nonatomic) NSUUID * _Nonnull deviceVerificationNonce;
		[Export ("deviceVerificationNonce", ArgumentSemantic.Copy)]
		NSUuid DeviceVerificationNonce { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
		[Export ("signedDate", ArgumentSemantic.Copy)]
		NSDate SignedDate { get; }

		// @property (readonly, nonatomic, strong) SubcriptionAdvancedCommerceInfo * _Nullable advancedCommerceInfo;
		[TV (18, 4), Mac (15, 4), iOS (18, 4)]
		[NullAllowed, Export ("advancedCommerceInfo", ArgumentSemantic.Strong)]
		SubcriptionAdvancedCommerceInfo AdvancedCommerceInfo { get; }

		// @property (readonly, nonatomic, strong) NSUUID * _Nullable appAccountToken;
		[NullAllowed, Export ("appAccountToken", ArgumentSemantic.Strong)]
		NSUuid AppAccountToken { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull appTransactionID;
		[Export ("appTransactionID")]
		string AppTransactionID { get; }

		// @property (readonly, nonatomic, strong) CommitmentInfo * _Nullable commitmentInfo;
		[NullAllowed, Export ("commitmentInfo", ArgumentSemantic.Strong)]
		CommitmentInfo CommitmentInfo { get; }

		// @property (readonly, nonatomic, strong) BillingPlanType * _Nullable renewalBillingPlanType;
		[NullAllowed, Export ("renewalBillingPlanType", ArgumentSemantic.Strong)]
		BillingPlanType RenewalBillingPlanType { get; }
	}

	// @interface RenewalState : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface RenewalState
	{
		// @property (readonly, nonatomic) NSInteger rawValue;
		[Export ("rawValue")]
		int RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSInteger)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (nint rawValue);

		// @property (readonly, nonatomic, strong, class) RenewalState * _Nonnull subscribed;
		[Static]
		[Export ("subscribed", ArgumentSemantic.Strong)]
		RenewalState Subscribed { get; }

		// @property (readonly, nonatomic, strong, class) RenewalState * _Nonnull expired;
		[Static]
		[Export ("expired", ArgumentSemantic.Strong)]
		RenewalState Expired { get; }

		// @property (readonly, nonatomic, strong, class) RenewalState * _Nonnull inBillingRetryPeriod;
		[Static]
		[Export ("inBillingRetryPeriod", ArgumentSemantic.Strong)]
		RenewalState InBillingRetryPeriod { get; }

		// @property (readonly, nonatomic, strong, class) RenewalState * _Nonnull inGracePeriod;
		[Static]
		[Export ("inGracePeriod", ArgumentSemantic.Strong)]
		RenewalState InGracePeriod { get; }

		// @property (readonly, nonatomic, strong, class) RenewalState * _Nonnull revoked;
		[Static]
		[Export ("revoked", ArgumentSemantic.Strong)]
		RenewalState Revoked { get; }

		// -(BOOL)isEqualToState:(RenewalState * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToState:")]
		bool IsEqualToState ([NullAllowed] RenewalState other);
	}

	delegate void StoreFrontUpdateHandler([NullAllowed] StoreFront storeFront);

	// @interface StoreFront : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface StoreFront
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull countryCode;
		[Export ("countryCode")]
		string CountryCode { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull identifier;
		[Export ("identifier")]
		string Identifier { get; }

		// @property (readonly, nonatomic, strong) CurrencyWrapper * _Nullable currency;
		[TV (16, 0), Mac (13, 0), iOS (16, 0)]
		[NullAllowed, Export ("currency", ArgumentSemantic.Strong)]
		CurrencyWrapper Currency { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable currencyCode;
		[NullAllowed, Export ("currencyCode")]
		string CurrencyCode { get; }

		// +(void)currentAsyncWithCompletion:(void (^ _Nonnull)(StoreFront * _Nullable))completion;
		[Static]
		[Async]
		[Export ("currentAsyncWithCompletion:")]
		void CurrentAsyncWithCompletion (StoreFrontUpdateHandler storeFrontUpdateHandler);

		// +(void)observeUpdatesAsyncWithUpdateHandler:(void (^ _Nonnull)(StoreFront * _Nonnull))updateHandler completion:(void (^ _Nonnull)(void))completion;
		[Static]
		[Async]
		[Export ("observeUpdatesAsyncWithUpdateHandler:completion:")]
		void ObserveUpdatesAsyncWithUpdateHandler (StoreFrontUpdateHandler updateHandler, Action completion);
	}

	// @interface StoreKitError : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface StoreKitError
	{
		// @property (readonly, nonatomic) enum StoreKitErrorCode code;
		[Export ("code")]
		StoreKitErrorCode Code { get; }

		// @property (readonly, nonatomic, strong) NSError * _Nullable underlyingError;
		[NullAllowed, Export ("underlyingError", ArgumentSemantic.Strong)]
		NSError UnderlyingError { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable errorDescription;
		[NullAllowed, Export ("errorDescription")]
		string ErrorDescription { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable failureReason;
		[NullAllowed, Export ("failureReason")]
		string FailureReason { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable recoverySuggestion;
		[NullAllowed, Export ("recoverySuggestion")]
		string RecoverySuggestion { get; }
	}

	// @interface SubcriptionAdvancedCommerceInfo : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface SubcriptionAdvancedCommerceInfo
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull consistencyToken;
		[Export ("consistencyToken")]
		string ConsistencyToken { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull requestReferenceID;
		[Export ("requestReferenceID")]
		string RequestReferenceID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull taxCode;
		[Export ("taxCode")]
		string TaxCode { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull descriptionText;
		[Export ("descriptionText")]
		string DescriptionText { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull displayName;
		[Export ("displayName")]
		string DisplayName { get; }

		// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nonnull period;
		[Export ("period", ArgumentSemantic.Strong)]
		ProductSubscriptionPeriod Period { get; }

		// @property (readonly, copy, nonatomic) NSArray<SubscriptionAdvancedCommerceItem *> * _Nonnull items;
		[Export ("items", ArgumentSemantic.Copy)]
		SubscriptionAdvancedCommerceItem[] Items { get; }
	}

	// @interface SubscriptionAdvancedCommerceItem : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface SubscriptionAdvancedCommerceItem
	{
		// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoItemDetails * _Nonnull details;
		[Export ("details", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoItemDetails Details { get; }
	}

	// @interface SubscriptionOfferPaymentMode : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface SubscriptionOfferPaymentMode
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) SubscriptionOfferPaymentMode * _Nonnull payAsYouGo;
		[Static]
		[Export ("payAsYouGo", ArgumentSemantic.Strong)]
		SubscriptionOfferPaymentMode PayAsYouGo { get; }

		// @property (readonly, nonatomic, strong, class) SubscriptionOfferPaymentMode * _Nonnull payUpFront;
		[Static]
		[Export ("payUpFront", ArgumentSemantic.Strong)]
		SubscriptionOfferPaymentMode PayUpFront { get; }

		// @property (readonly, nonatomic, strong, class) SubscriptionOfferPaymentMode * _Nonnull freeTrial;
		[Static]
		[Export ("freeTrial", ArgumentSemantic.Strong)]
		SubscriptionOfferPaymentMode FreeTrial { get; }

		// -(BOOL)isEqualToMode:(SubscriptionOfferPaymentMode * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToMode:")]
		bool IsEqualToMode ([NullAllowed] SubscriptionOfferPaymentMode other);
	}

	// @interface SubscriptionOfferSignature : NSObject
	[Introduced (PlatformName.TvOS, 17, 4, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")]
	[Deprecated (PlatformName.TvOS, 26, 0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")]
	[Introduced (PlatformName.MacOSX, 14, 4, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")]
	[Deprecated (PlatformName.MacOSX, 26, 0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")]
	[Introduced (PlatformName.iOS, 17, 4, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")]
	[Deprecated (PlatformName.iOS, 26, 0, message: "Sign promotional offers with JWS and use PurchaseOption.promotionalOffer(_:compactJWS:) instead")]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface SubscriptionOfferSignature
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull keyID;
		[Export ("keyID")]
		string KeyID { get; }

		// @property (readonly, nonatomic, strong) NSUUID * _Nonnull nonce;
		[Export ("nonce", ArgumentSemantic.Strong)]
		NSUuid Nonce { get; }

		// @property (readonly, nonatomic, strong) NSNumber * _Nonnull timestamp;
		[Export ("timestamp", ArgumentSemantic.Strong)]
		NSNumber Timestamp { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull signatureData;
		[Export ("signatureData", ArgumentSemantic.Copy)]
		NSData SignatureData { get; }

		// +(SubscriptionOfferSignature * _Nullable)fromKeyID:(NSString * _Nonnull)keyID nonce:(NSUUID * _Nonnull)nonce timestamp:(NSNumber * _Nonnull)timestamp signatureData:(NSData * _Nonnull)signatureData __attribute__((warn_unused_result("")));
		[Static]
		[Export ("fromKeyID:nonce:timestamp:signatureData:")]
		[return: NullAllowed]
		SubscriptionOfferSignature FromKeyID (string keyID, NSUuid nonce, NSNumber timestamp, NSData signatureData);
	}

	// @interface SubscriptionOfferType : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface SubscriptionOfferType
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) SubscriptionOfferType * _Nonnull introductory;
		[Static]
		[Export ("introductory", ArgumentSemantic.Strong)]
		SubscriptionOfferType Introductory { get; }

		// @property (readonly, nonatomic, strong, class) SubscriptionOfferType * _Nonnull promotional;
		[Static]
		[Export ("promotional", ArgumentSemantic.Strong)]
		SubscriptionOfferType Promotional { get; }

		// @property (readonly, nonatomic, strong, class) SubscriptionOfferType * _Nonnull winBack;
		[TV (18, 0), Mac (15, 0), iOS (18, 0)]
		[Static]
		[Export ("winBack", ArgumentSemantic.Strong)]
		SubscriptionOfferType WinBack { get; }

		// -(BOOL)isEqualToType:(SubscriptionOfferType * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToType:")]
		bool IsEqualToType ([NullAllowed] SubscriptionOfferType other);
	}

	// @interface SubscriptionStatus : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface SubscriptionStatus
	{
		// @property (readonly, nonatomic, strong) RenewalState * _Nonnull state;
		[Export ("state", ArgumentSemantic.Strong)]
		RenewalState State { get; }

		// @property (readonly, nonatomic, strong) TransactionVerificationResult * _Nonnull transaction;
		[Export ("transaction", ArgumentSemantic.Strong)]
		TransactionVerificationResult Transaction { get; }

		// @property (readonly, nonatomic, strong) RenewalInfoVerificationResult * _Nonnull renewalInfo;
		[Export ("renewalInfo", ArgumentSemantic.Strong)]
		RenewalInfoVerificationResult RenewalInfo { get; }

		// -(BOOL)isEqualToStatus:(SubscriptionStatus * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToStatus:")]
		bool IsEqualToStatus ([NullAllowed] SubscriptionStatus other);
	}

	// @interface TransactionAdvancedCommerceInfoItemDetails : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfoItemDetails
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull sku;
		[Export ("sku")]
		string Sku { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull displayName;
		[Export ("displayName")]
		string DisplayName { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull itemDescription;
		[Export ("itemDescription")]
		string ItemDescription { get; }

		// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoOffer * _Nullable offer;
		[NullAllowed, Export ("offer", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoOffer Offer { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull price;
		[Export ("price", ArgumentSemantic.Strong)]
		NSDecimalNumber Price { get; }

		// @property (readonly, nonatomic, strong) NSArray * _Nonnull partners;
		[Export ("partners", ArgumentSemantic.Strong)]
		TransactionAdvancedCommercePartner[] Partners { get; }
	}

	// @interface TransactionAdvancedCommerceInfoItem : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfoItem
	{
		// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoItemDetails * _Nullable details;
		[NullAllowed, Export ("details", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoItemDetails Details { get; }

		// @property (readonly, nonatomic, strong) NSArray * _Nullable refunds;
		[NullAllowed, Export ("refunds", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefund[] Refunds { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nullable revocationDate;
		[NullAllowed, Export ("revocationDate", ArgumentSemantic.Copy)]
		NSDate RevocationDate { get; }
	}

	// @interface TransactionAdvancedCommerceInfoOfferReason : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfoOfferReason
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoOfferReason * _Nonnull acquisition;
		[Static]
		[Export ("acquisition", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoOfferReason Acquisition { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoOfferReason * _Nonnull retention;
		[Static]
		[Export ("retention", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoOfferReason Retention { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoOfferReason * _Nonnull winBack;
		[Static]
		[Export ("winBack", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoOfferReason WinBack { get; }

		// -(BOOL)isEqualToReason:(TransactionAdvancedCommerceInfoOfferReason * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToReason:")]
		bool IsEqualToReason ([NullAllowed] TransactionAdvancedCommerceInfoOfferReason other);
	}

	// @interface TransactionAdvancedCommerceInfoOffer : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfoOffer
	{
		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull price;
		[Export ("price", ArgumentSemantic.Strong)]
		NSDecimalNumber Price { get; }

		// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nullable period;
		[Export ("period", ArgumentSemantic.Strong)]
		ProductSubscriptionPeriod Period { get; }

		// @property (readonly, nonatomic, strong) NSNumber * _Nonnull periodCount;
		[Export ("periodCount", ArgumentSemantic.Strong)]
		NSNumber PeriodCount { get; }

		// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoOfferReason * _Nullable reason;
		[Export ("reason", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoOfferReason Reason { get; }
	}

	// @interface TransactionAdvancedCommerceInfoRefundReason : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfoRefundReason
	{
		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundReason * _Nonnull legal;
		[Static]
		[Export ("legal", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason Legal { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundReason * _Nonnull modifyItems;
		[Static]
		[Export ("modifyItems", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason ModifyItems { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundReason * _Nonnull unintended;
		[Static]
		[Export ("unintended", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason Unintended { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundReason * _Nonnull unfulfilled;
		[Static]
		[Export ("unfulfilled", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason Unfulfilled { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundReason * _Nonnull unsatisfied;
		[Static]
		[Export ("unsatisfied", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason Unsatisfied { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundReason * _Nonnull other;
		[Static]
		[Export ("other", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason Other { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundReason * _Nonnull unknown;
		[Static]
		[Export ("unknown", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason Unknown { get; }

		// -(BOOL)isEqualToReason:(TransactionAdvancedCommerceInfoRefundReason * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToReason:")]
		bool IsEqualToReason ([NullAllowed] TransactionAdvancedCommerceInfoRefundReason other);
	}

	// @interface TransactionAdvancedCommerceInfoRefundType : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfoRefundType
	{
		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundType * _Nonnull custom;
		[Static]
		[Export ("custom", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundType Custom { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundType * _Nonnull proRated;
		[Static]
		[Export ("proRated", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundType ProRated { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundType * _Nonnull full;
		[Static]
		[Export ("full", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundType Full { get; }

		// @property (readonly, nonatomic, strong, class) TransactionAdvancedCommerceInfoRefundType * _Nonnull unknown;
		[Static]
		[Export ("unknown", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundType Unknown { get; }

		// -(BOOL)isEqualToType:(TransactionAdvancedCommerceInfoRefundType * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToType:")]
		bool IsEqualToType ([NullAllowed] TransactionAdvancedCommerceInfoRefundType other);
	}

	// @interface TransactionAdvancedCommerceInfoRefund : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfoRefund
	{
		// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoRefundReason * _Nullable reason;
		[NullAllowed, Export ("reason", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundReason Reason { get; }

		// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoRefundType * _Nullable type;
		[NullAllowed, Export ("type", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfoRefundType Type { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull date;
		[Export ("date", ArgumentSemantic.Copy)]
		NSDate Date { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull amount;
		[Export ("amount", ArgumentSemantic.Strong)]
		NSDecimalNumber Amount { get; }
	}

	// @interface TransactionAdvancedCommerceInfo : NSObject
	[TV (18,4), Mac (15,4), iOS (18,4)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionAdvancedCommerceInfo
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull requestReferenceID;
		[Export ("requestReferenceID")]
		string RequestReferenceID { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull estimatedTax;
		[Export ("estimatedTax", ArgumentSemantic.Strong)]
		NSDecimalNumber EstimatedTax { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull taxRate;
		[Export ("taxRate", ArgumentSemantic.Strong)]
		NSDecimalNumber TaxRate { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull taxCode;
		[Export ("taxCode")]
		string TaxCode { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull taxExclusivePrice;
		[Export ("taxExclusivePrice", ArgumentSemantic.Strong)]
		NSDecimalNumber TaxExclusivePrice { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable infoDescription;
		[NullAllowed, Export ("infoDescription")]
		string InfoDescription { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable displayName;
		[NullAllowed, Export ("displayName")]
		string DisplayName { get; }

		// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nullable period;
		[NullAllowed, Export ("period", ArgumentSemantic.Strong)]
		ProductSubscriptionPeriod Period { get; }

		// @property (readonly, copy, nonatomic) NSArray<SubscriptionAdvancedCommerceItem *> * _Nonnull items;
		[Export ("items", ArgumentSemantic.Copy)]
		TransactionAdvancedCommerceInfoItem[] Items { get; }
	}

	// @interface TransactionAdvancedCommercePartner : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface TransactionAdvancedCommercePartner {
		// @property (readonly, copy, nonatomic) NSString * _Nonnull id;
		[Export ("id")]
		string Id { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable name;
		[NullAllowed, Export ("name")]
		string Name { get; }

		// -(instancetype _Nonnull)initWithId:(NSString * _Nonnull)id name:(NSString * _Nullable)name __attribute__((objc_designated_initializer));
		[Export ("initWithId:name:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string id, [NullAllowed] string name);

		// -(BOOL)isEqualToPartner:(TransactionAdvancedCommercePartner * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToPartner:")]
		bool IsEqualToPartner ([NullAllowed] TransactionAdvancedCommercePartner other);
	}

	// @interface TransactionOfferPaymentMode : NSObject
	[TV (17,2), Mac (14,2), iOS (17,2)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionOfferPaymentMode
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// @property (readonly, nonatomic, strong, class) TransactionOfferPaymentMode * _Nonnull freeTrial;
		[Static]
		[Export ("freeTrial", ArgumentSemantic.Strong)]
		TransactionOfferPaymentMode FreeTrial { get; }

		// @property (readonly, nonatomic, strong, class) TransactionOfferPaymentMode * _Nonnull payAsYouGo;
		[Static]
		[Export ("payAsYouGo", ArgumentSemantic.Strong)]
		TransactionOfferPaymentMode PayAsYouGo { get; }

		// @property (readonly, nonatomic, strong, class) TransactionOfferPaymentMode * _Nonnull payUpFront;
		[Static]
		[Export ("payUpFront", ArgumentSemantic.Strong)]
		TransactionOfferPaymentMode PayUpFront { get; }

		// @property (readonly, nonatomic, strong, class) TransactionOfferPaymentMode * _Nonnull oneTime;
		[TV (17, 2), Mac (14, 2), iOS (17, 2)]
		[Static]
		[Export ("oneTime", ArgumentSemantic.Strong)]
		TransactionOfferPaymentMode OneTime { get; }

		// -(BOOL)isEqualToMode:(TransactionOfferPaymentMode * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToMode:")]
		bool IsEqualToMode ([NullAllowed] TransactionOfferPaymentMode other);
	}

	// @interface TransactionOffer : NSObject
	[TV (17,2), Mac (14,2), iOS (17,2)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionOffer
	{
		// @property (readonly, copy, nonatomic) NSString * _Nullable id;
		[NullAllowed, Export ("id")]
		string Id { get; }

		// @property (readonly, nonatomic) enum TransactionOfferType type;
		[Export ("type")]
		TransactionOfferType Type { get; }

		// @property (readonly, nonatomic, strong) TransactionOfferPaymentMode * _Nullable paymentMode;
		[NullAllowed, Export ("paymentMode", ArgumentSemantic.Strong)]
		TransactionOfferPaymentMode PaymentMode { get; }

		// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nullable period;
		[TV (18, 4), Mac (15, 4), iOS (18, 4)]
		[NullAllowed, Export ("period", ArgumentSemantic.Strong)]
		ProductSubscriptionPeriod Period { get; }
	}

	// @interface TransactionOwnershipType : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionOwnershipType
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// @property (readonly, nonatomic, strong, class) TransactionOwnershipType * _Nonnull purchased;
		[Static]
		[Export ("purchased", ArgumentSemantic.Strong)]
		TransactionOwnershipType Purchased { get; }

		// @property (readonly, nonatomic, strong, class) TransactionOwnershipType * _Nonnull familyShared;
		[Static]
		[Export ("familyShared", ArgumentSemantic.Strong)]
		TransactionOwnershipType FamilyShared { get; }

		// @property (readonly, nonatomic, strong, class) TransactionOwnershipType * _Nonnull assigned;
		[Static]
		[Export ("assigned", ArgumentSemantic.Strong)]
		TransactionOwnershipType Assigned { get; }

		// -(BOOL)isEqualToType:(TransactionOwnershipType * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToType:")]
		bool IsEqualToType ([NullAllowed] TransactionOwnershipType other);
	}

	// @interface TransactionReason : NSObject
	[TV (17,0), Mac (14,0), iOS (17,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionReason
	{
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// @property (readonly, nonatomic, strong, class) TransactionReason * _Nullable purchase;
		[Static]
		[NullAllowed, Export ("purchase", ArgumentSemantic.Strong)]
		TransactionReason Purchase { get; }

		// @property (readonly, nonatomic, strong, class) TransactionReason * _Nullable renewal;
		[Static]
		[NullAllowed, Export ("renewal", ArgumentSemantic.Strong)]
		TransactionReason Renewal { get; }

		// -(BOOL)isEqualToReason:(TransactionReason * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToReason:")]
		bool IsEqualToReason ([NullAllowed] TransactionReason other);
	}

	// @interface TransactionRevocationType : NSObject
	[BaseType (typeof (NSObject))]
	[DisableDefaultCtor]
	interface TransactionRevocationType {
		// @property (readonly, copy, nonatomic) NSString * _Nonnull rawValue;
		[Export ("rawValue")]
		string RawValue { get; }

		// -(instancetype _Nonnull)initWithRawValue:(NSString * _Nonnull)rawValue __attribute__((objc_designated_initializer));
		[Export ("initWithRawValue:")]
		[DesignatedInitializer]
		NativeHandle Constructor (string rawValue);

		// @property (readonly, nonatomic, strong, class) TransactionRevocationType * _Nonnull familyRevocation;
		[Static]
		[Export ("familyRevocation", ArgumentSemantic.Strong)]
		TransactionRevocationType FamilyRevocation { get; }

		// @property (readonly, nonatomic, strong, class) TransactionRevocationType * _Nonnull fullRefund;
		[Static]
		[Export ("fullRefund", ArgumentSemantic.Strong)]
		TransactionRevocationType FullRefund { get; }

		// @property (readonly, nonatomic, strong, class) TransactionRevocationType * _Nonnull proratedRefund;
		[Static]
		[Export ("proratedRefund", ArgumentSemantic.Strong)]
		TransactionRevocationType ProratedRefund { get; }

		// @property (readonly, nonatomic, strong, class) TransactionRevocationType * _Nonnull assignmentRevocation;
		[Static]
		[Export ("assignmentRevocation", ArgumentSemantic.Strong)]
		TransactionRevocationType AssignmentRevocation { get; }

		// -(BOOL)isEqualToType:(TransactionRevocationType * _Nullable)other __attribute__((warn_unused_result("")));
		[Export ("isEqualToType:")]
		bool IsEqualToType ([NullAllowed] TransactionRevocationType other);
	}

	// @interface TransactionVerificationResult : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface TransactionVerificationResult
	{
		// @property (readonly, nonatomic) BOOL isVerified;
		[Export ("isVerified")]
		bool IsVerified { get; }

		// @property (readonly, nonatomic) enum VerificationErrorCode error;
		[Export ("error")]
		VerificationErrorCode Error { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull jwsRepresentation;
		[Export ("jwsRepresentation")]
		string JwsRepresentation { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull headerData;
		[Export ("headerData", ArgumentSemantic.Copy)]
		NSData HeaderData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull payloadData;
		[Export ("payloadData", ArgumentSemantic.Copy)]
		NSData PayloadData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull signatureData;
		[Export ("signatureData", ArgumentSemantic.Copy)]
		NSData SignatureData { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull signedData;
		[Export ("signedData", ArgumentSemantic.Copy)]
		NSData SignedData { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
		[Export ("signedDate", ArgumentSemantic.Copy)]
		NSDate SignedDate { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
		[Export ("deviceVerification", ArgumentSemantic.Copy)]
		NSData DeviceVerification { get; }

		// @property (readonly, nonatomic, strong) NSUUID * _Nonnull deviceVerificationNonce;
		[Export ("deviceVerificationNonce", ArgumentSemantic.Strong)]
		NSUuid DeviceVerificationNonce { get; }

		// @property (readonly, nonatomic, strong) Transaction * _Nonnull transaction;
		[Export ("transaction", ArgumentSemantic.Strong)]
		Transaction Transaction { get; }

		// -(Transaction * _Nullable)getPayloadValueAndReturnError:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
		[Export ("getPayloadValueAndReturnError:")]
		[return: NullAllowed]
		Transaction GetPayloadValueAndReturnError ([NullAllowed] out NSError error);

		// -(Transaction * _Nonnull)getUnsafePayloadValue __attribute__((warn_unused_result("")));
		[Export ("getUnsafePayloadValue")]
		
		Transaction UnsafePayloadValue { get; }
	}

	delegate void TransactionVerificationResultHandler(TransactionVerificationResult result);
	delegate void TransactionRefundRequestStatusHandler(RefundRequestStatus status, [NullAllowed] NSError error);
	delegate void TransactionSubscriptionStatusHandler([NullAllowed] SubscriptionStatus status);

	// @interface Transaction : NSObject
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[DisableDefaultCtor]
	[BaseType(typeof(NSObject))]
	interface Transaction
	{
		// @property (readonly, copy, nonatomic) NSData * _Nonnull jsonRepresentation;
		[Export ("jsonRepresentation", ArgumentSemantic.Copy)]
		NSData JsonRepresentation { get; }

		// @property (readonly, nonatomic, strong) NSNumber * _Nonnull id;
		[Export ("id", ArgumentSemantic.Strong)]
		NSNumber Id { get; }

		// @property (readonly, nonatomic, strong) NSNumber * _Nonnull originalID;
		[Export ("originalID", ArgumentSemantic.Strong)]
		NSNumber OriginalID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable webOrderLineItemID;
		[NullAllowed, Export ("webOrderLineItemID")]
		string WebOrderLineItemID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull productID;
		[Export ("productID")]
		string ProductID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable subscriptionGroupID;
		[NullAllowed, Export ("subscriptionGroupID")]
		string SubscriptionGroupID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull appBundleID;
		[Export ("appBundleID")]
		string AppBundleID { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull purchaseDate;
		[Export ("purchaseDate", ArgumentSemantic.Copy)]
		NSDate PurchaseDate { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull originalPurchaseDate;
		[Export ("originalPurchaseDate", ArgumentSemantic.Copy)]
		NSDate OriginalPurchaseDate { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nullable expirationDate;
		[NullAllowed, Export ("expirationDate", ArgumentSemantic.Copy)]
		NSDate ExpirationDate { get; }

		// @property (readonly, nonatomic) NSInteger purchasedQuantity;
		[Export ("purchasedQuantity")]
		int PurchasedQuantity { get; }

		// @property (readonly, nonatomic) BOOL isUpgraded;
		[Export ("isUpgraded")]
		bool IsUpgraded { get; }

		// @property (readonly, nonatomic, strong) TransactionOffer * _Nullable offer;
		[TV (17, 2), Mac (14, 2), iOS (17, 2)]
		[NullAllowed, Export ("offer", ArgumentSemantic.Strong)]
		TransactionOffer Offer { get; }

		// @property (readonly, nonatomic) enum TransactionOfferType offerType;
		[Export ("offerType")]
		TransactionOfferType OfferType { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable offerID;
		[NullAllowed, Export ("offerID")]
		string OfferID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable offerPaymentModeStringRepresentation;
		[NullAllowed, Export ("offerPaymentModeStringRepresentation")]
		string OfferPaymentModeStringRepresentation { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable offerPeriodStringRepresentation;
		[NullAllowed, Export ("offerPeriodStringRepresentation")]
		string OfferPeriodStringRepresentation { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nullable revocationDate;
		[NullAllowed, Export ("revocationDate", ArgumentSemantic.Copy)]
		NSDate RevocationDate { get; }

		// @property (readonly, nonatomic) enum TransactionRevocationReason revocationReason;
		[Export ("revocationReason")]
		TransactionRevocationReason RevocationReason { get; }

		// @property (readonly, nonatomic, strong) TransactionRevocationType * _Nullable revocationType;
		[NullAllowed, Export ("revocationType", ArgumentSemantic.Strong)]
		TransactionRevocationType RevocationType { get; }

		// @property (readonly, nonatomic, strong) ProductType * _Nonnull productType;
		[Export ("productType", ArgumentSemantic.Strong)]
		ProductType ProductType { get; }

		// @property (readonly, copy, nonatomic) NSUUID * _Nullable appAccountToken;
		[NullAllowed, Export ("appAccountToken", ArgumentSemantic.Copy)]
		NSUuid AppAccountToken { get; }

		// @property (readonly, nonatomic, strong) AppStoreEnvironment * _Nullable environment;
		[TV (16, 0), Mac (13, 0), iOS (16, 0)]
		[NullAllowed, Export ("environment", ArgumentSemantic.Strong)]
		AppStoreEnvironment Environment { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull environmentStringRepresentation;
		[Export ("environmentStringRepresentation")]
		string EnvironmentStringRepresentation { get; }

		// @property (readonly, nonatomic, strong) TransactionReason * _Nullable reason;
		[TV (17, 0), Mac (14, 0), iOS (17, 0)]
		[NullAllowed, Export ("reason", ArgumentSemantic.Strong)]
		TransactionReason Reason { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull reasonStringRepresentation;
		[Export ("reasonStringRepresentation")]
		string ReasonStringRepresentation { get; }

		// @property (readonly, nonatomic, strong) StoreFront * _Nullable storefront;
		[TV (17, 0), Mac (14, 0), iOS (17, 0)]
		[NullAllowed, Export ("storefront", ArgumentSemantic.Strong)]
		StoreFront Storefront { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull storefrontCountryCode;
		[Export ("storefrontCountryCode")]
		string StorefrontCountryCode { get; }

		// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nullable price;
		[NullAllowed, Export ("price", ArgumentSemantic.Strong)]
		NSDecimalNumber Price { get; }

		// @property (readonly, nonatomic, strong) CurrencyWrapper * _Nullable currency;
		[TV (16, 0), Mac (13, 0), iOS (16, 0)]
		[NullAllowed, Export ("currency", ArgumentSemantic.Strong)]
		CurrencyWrapper Currency { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable currencyCode;
		[NullAllowed, Export ("currencyCode")]
		string CurrencyCode { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable bundleProductID;
		[NullAllowed, Export ("bundleProductID")]
		string BundleProductID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable bundleSubscriptionGroupID;
		[NullAllowed, Export ("bundleSubscriptionGroupID")]
		string BundleSubscriptionGroupID { get; }

		// @property (readonly, nonatomic, strong) NSNumber * _Nullable previousOriginalTransactionID;
		[NullAllowed, Export ("previousOriginalTransactionID", ArgumentSemantic.Strong)]
		NSNumber PreviousOriginalTransactionID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable bundleTransactionID;
		[NullAllowed, Export ("bundleTransactionID")]
		string BundleTransactionID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nullable bundleOriginalTransactionID;
		[NullAllowed, Export ("bundleOriginalTransactionID")]
		string BundleOriginalTransactionID { get; }

		// @property (readonly, copy, nonatomic) NSString * _Nonnull appTransactionID;
		[Export ("appTransactionID")]
		string AppTransactionID { get; }

		// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
		[Export ("deviceVerification", ArgumentSemantic.Copy)]
		NSData DeviceVerification { get; }

		// @property (readonly, copy, nonatomic) NSUUID * _Nullable deviceVerificationNonce;
		[NullAllowed, Export ("deviceVerificationNonce", ArgumentSemantic.Copy)]
		NSUuid DeviceVerificationNonce { get; }

		// @property (readonly, nonatomic, strong) TransactionOwnershipType * _Nonnull ownershipType;
		[Export ("ownershipType", ArgumentSemantic.Strong)]
		TransactionOwnershipType OwnershipType { get; }

		// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
		[Export ("signedDate", ArgumentSemantic.Copy)]
		NSDate SignedDate { get; }

		// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfo * _Nullable advancedCommerceInfo;
		[TV (18, 4), Mac (15, 4), iOS (18, 4)]
		[NullAllowed, Export ("advancedCommerceInfo", ArgumentSemantic.Strong)]
		TransactionAdvancedCommerceInfo AdvancedCommerceInfo { get; }

		// @property (readonly, nonatomic, strong) CommitmentInfo * _Nullable commitmentInfo;
		[NullAllowed, Export ("commitmentInfo", ArgumentSemantic.Strong)]
		CommitmentInfo CommitmentInfo { get; }

		// @property (readonly, nonatomic, strong) BillingPlanType * _Nullable renewalBillingPlanType;
		[NullAllowed, Export ("renewalBillingPlanType", ArgumentSemantic.Strong)]
		BillingPlanType RenewalBillingPlanType { get; }

		// -(void)finishAsync:(void (^ _Nonnull)(void))completion;
		[Async]
		[Export ("finishAsync:")]
		void FinishAsync (Action completion);

		// +(void)updateTransactionsAsyncWithTransactionHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
		[Static]
		[Async]
		[Export ("updateTransactionsAsyncWithTransactionHandler:completion:")]
		void UpdateTransactionsAsyncWithTransactionHandler (TransactionVerificationResultHandler transactionVerificationResultHandler, Action completion);

		// +(void)allTransactionsAsyncWithHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
		[Static]
		[Async]
		[Export ("allTransactionsAsyncWithHandler:completion:")]
		void AllTransactionsAsyncWithHandler (TransactionVerificationResultHandler transactionVerificationResultHandler, Action completion);

		// +(void)currentEntitlementsAsyncWithHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
		[Static]
		[Async]
		[Export ("currentEntitlementsAsyncWithHandler:completion:")]
		void CurrentEntitlementsAsyncWithHandler (TransactionVerificationResultHandler transactionVerificationResultHandler, Action completion);

		// +(void)currentEntitlementsAsyncForProductIDAsync:(NSString * _Nonnull)productID completion:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion __attribute__((availability(tvos, introduced=15.0, deprecated=18.4))) __attribute__((availability(macos, introduced=12.0, deprecated=15.4))) __attribute__((availability(ios, introduced=15.0, deprecated=18.4)));
		[Introduced (PlatformName.TvOS, 15, 0)]
		[Deprecated (PlatformName.TvOS, 18, 4)]
		[Introduced (PlatformName.MacOSX, 12, 0)]
		[Deprecated (PlatformName.MacOSX, 15, 4)]
		[Introduced (PlatformName.iOS, 15, 0)]
		[Deprecated (PlatformName.iOS, 18, 4)]
		[Static]
		[Async]
		[Export ("currentEntitlementsAsyncForProductIDAsync:completion:")]
		void CurrentEntitlementsAsyncForProductIDAsync (string productID, TransactionVerificationResultHandler transactionVerificationResultHandler);

		// +(void)latestTransactionAsyncForProductID:(NSString * _Nonnull)productID completion:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion;
		[Static]
		[Async]
		[Export ("latestTransactionAsyncForProductID:completion:")]
		void LatestTransactionAsyncForProductID (string productID, TransactionResultHandler transactionResultHandler);

		// +(void)unfinishedTransactionsAsyncWithTransactionHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
		[Static]
		[Async]
		[Export ("unfinishedTransactionsAsyncWithTransactionHandler:completion:")]
		void UnfinishedTransactionsAsyncWithTransactionHandler (TransactionVerificationResultHandler transactionVerificationResultHandler, Action completion);

		// +(void)observeUpdatesAsyncWithTransactionHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
		[TV (15,0), Mac (12,0), iOS (15,0)]
		[Static]
		[Async]
		[Export ("observeUpdatesAsyncWithTransactionHandler:completion:")]
		void ObserveUpdatesAsyncWithTransactionHandler (TransactionVerificationResultHandler transactionVerificationResultHandler, Action completion);

		// +(void)allTransactionsAsyncWithHandler:(NSString * _Nonnull)productID productID:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion __attribute__((availability(tvos, introduced=18.4))) __attribute__((availability(macos, introduced=15.4))) __attribute__((availability(ios, introduced=18.4)));
		[TV (18,4), Mac (15,4), iOS (18,4)]
		[Static]
		[Async]
		[Export ("allTransactionsAsyncWithHandler:productID:completion:")]
		void AllTransactionsAsyncWithHandler (string productID, TransactionVerificationResultHandler transactionVerificationResultHandler, Action completion);

		// +(void)currentEntitlementsWithHandler:(NSString * _Nonnull)productID productID:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion __attribute__((availability(tvos, introduced=18.4))) __attribute__((availability(macos, introduced=15.4))) __attribute__((availability(ios, introduced=18.4)));
		[TV (18,4), Mac (15,4), iOS (18,4)]
		[Static]
		[Async]
		[Export ("currentEntitlementsAsyncWithHandler:productID:completion:")]
		void CurrentEntitlementsAsyncWithHandler (string productID, TransactionVerificationResultHandler transactionVerificationResultHandler, Action completion);

		// -(void)beginRefundRequestAsyncInScene:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(enum RefundRequestStatus, NSError * _Nullable))completion;
		[Async]
		[Export ("beginRefundRequestAsyncInScene:completion:")]
		void BeginRefundRequestAsyncInScene (UIWindowScene scene, TransactionRefundRequestStatusHandler transactionRefundRequestStatusHandler);

		// +(void)beginRefundRequestAsyncInScene:(id)transactionID transactionID:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(enum RefundRequestStatus, NSError * _Nullable))completion __attribute__((availability(tvos, unavailable))) __attribute__((availability(ios, introduced=15.0)));
		[NoTV, iOS (15,0)]
		[Static]
		[Async]
		[Export ("beginRefundRequestAsyncInScene:transactionID:completion:")]
		void BeginRefundRequestAsyncInScene (NSNumber transactionID, UIWindowScene scene, TransactionRefundRequestStatusHandler transactionRefundRequestStatusHandler);

		// -(void)getSubscriptionStatusAsyncWithCompletion:(void (^ _Nonnull)(SubscriptionStatus * _Nullable))completion __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
		[TV (15,0), Mac (12,0), iOS (15,0)]
		[Async]
		[Export ("getSubscriptionStatusAsyncWithCompletion:")]
		void GetSubscriptionStatusAsyncWithCompletion (TransactionSubscriptionStatusHandler transactionSubscriptionStatusHandler);
	}
}
