using System;
using Foundation;
using ObjCRuntime;
using StoreKit2;

// @interface AdvancedCommerceProductPurchaseOption
[DisableDefaultCtor]
interface AdvancedCommerceProductPurchaseOption
{
	// +(AdvancedCommerceProductPurchaseOption * _Nullable)onStorefrontChangeWithShouldContinuePurchase:(id)shouldContinuePurchase __attribute__((warn_unused_result("")));
	[Static]
	[Export ("onStorefrontChangeWithShouldContinuePurchase:")]
	[return: NullAllowed]
	AdvancedCommerceProductPurchaseOption OnStorefrontChangeWithShouldContinuePurchase (NSObject shouldContinuePurchase);
}

// @interface AdvancedCommerceProduct
[DisableDefaultCtor]
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
	[Export ("createAdvancedProductAsyncWithProductID:completion:")]
	void CreateAdvancedProductAsyncWithProductID (string productID, Action<AdvancedCommerceProduct, NSError> completion);

	// -(void)purchaseAsyncWithCompactJWS:(NSString * _Nonnull)compactJWS viewController:(UIViewController * _Nonnull)viewController options:(id)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion;
	[Export ("purchaseAsyncWithCompactJWS:viewController:options:completion:")]
	void PurchaseAsyncWithCompactJWS (string compactJWS, UIViewController viewController, NSObject options, Action<ProductPurchaseResult, NSError> completion);

	// -(void)latestTransactionAsyncWithCompletion:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion;
	[Export ("latestTransactionAsyncWithCompletion:")]
	void LatestTransactionAsyncWithCompletion (Action<TransactionVerificationResult> completion);

	// -(void)allTransactionsAsyncWithCompletion:(void (^ _Nonnull)(int))completion;
	[Export ("allTransactionsAsyncWithCompletion:")]
	void AllTransactionsAsyncWithCompletion (Action<int> completion);

	// -(void)currentEntitlementsAsyncWithCompletion:(void (^ _Nonnull)(int))completion;
	[Export ("currentEntitlementsAsyncWithCompletion:")]
	void CurrentEntitlementsAsyncWithCompletion (Action<int> completion);
}

// @interface AppStoreEnvironment
[DisableDefaultCtor]
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

	// -(id)isEqualToEnvironment:(AppStoreEnvironment * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToEnvironment:")]
	NSObject IsEqualToEnvironment ([NullAllowed] AppStoreEnvironment other);
}

// @interface AppStoreMerchandisingKindPresentationResult
[DisableDefaultCtor]
interface AppStoreMerchandisingKindPresentationResult
{
	// @property (readonly, nonatomic) int isDismissed;
	[Export ("isDismissed")]
	int IsDismissed { get; }

	// @property (readonly, nonatomic, strong) ProductPurchaseResult * _Nullable purchaseResult;
	[NullAllowed, Export ("purchaseResult", ArgumentSemantic.Strong)]
	ProductPurchaseResult PurchaseResult { get; }
}

// @interface AppStoreMerchandisingKind
[DisableDefaultCtor]
interface AppStoreMerchandisingKind
{
	// +(void)subscriptionBundle:(NSString * _Nonnull)groupID completion:(void (^ _Nonnull)(AppStoreMerchandisingKind * _Nullable))completion;
	[Static]
	[Export ("subscriptionBundle:completion:")]
	void SubscriptionBundle (string groupID, Action<AppStoreMerchandisingKind> completion);
}

// @interface AppStorePlatform
[DisableDefaultCtor]
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

	// -(id)isEqualToPlatform:(AppStorePlatform * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToPlatform:")]
	NSObject IsEqualToPlatform ([NullAllowed] AppStorePlatform other);
}

// @interface AppStore
interface AppStore
{
	// +(id)canMakePayments __attribute__((warn_unused_result(""))) __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
	[TV (15, 0), Mac (12, 0), iOS (15, 0)]
	[Static]
	[Export ("canMakePayments")]
	[Verify (MethodToProperty)]
	NSObject CanMakePayments { get; }

	// +(NSString * _Nullable)deviceVerificationIdString __attribute__((warn_unused_result(""))) __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
	[TV (15, 0), Mac (12, 0), iOS (15, 0)]
	[Static]
	[NullAllowed, Export ("deviceVerificationIdString")]
	[Verify (MethodToProperty)]
	string DeviceVerificationIdString { get; }

	// +(void)syncAppStoreAsyncWithCompletion:(void (^ _Nonnull)(NSError * _Nullable))completion __attribute__((availability(ios, introduced=15.0)));
	[iOS (15,0)]
	[Static]
	[Export ("syncAppStoreAsyncWithCompletion:")]
	void SyncAppStoreAsyncWithCompletion (Action<NSError> completion);

	// +(void)showManageSubscriptionsAsyncIn:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(NSError * _Nullable))completion __attribute__((availability(ios, introduced=15.0)));
	[iOS (15,0)]
	[Static]
	[Export ("showManageSubscriptionsAsyncIn:completion:")]
	void ShowManageSubscriptionsAsyncIn (UIWindowScene scene, Action<NSError> completion);

	// +(void)showManageSubscriptionsAsyncIn:(UIWindowScene * _Nonnull)scene subscriptionGroupID:(NSString * _Nonnull)subscriptionGroupID completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("showManageSubscriptionsAsyncIn:subscriptionGroupID:completion:")]
	void ShowManageSubscriptionsAsyncIn (UIWindowScene scene, string subscriptionGroupID, Action<NSError> completion);

	// +(void)presentOfferCodeRedeemSheetAsyncIn:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("presentOfferCodeRedeemSheetAsyncIn:completion:")]
	void PresentOfferCodeRedeemSheetAsyncIn (UIWindowScene scene, Action<NSError> completion);

	// +(void)presentMerchandisingAsync:(AppStoreMerchandisingKind * _Nonnull)kind from:(UIViewController * _Nonnull)controller completion:(void (^ _Nonnull)(AppStoreMerchandisingKindPresentationResult * _Nonnull, NSError * _Nullable))completion;
	[Static]
	[Export ("presentMerchandisingAsync:from:completion:")]
	void PresentMerchandisingAsync (AppStoreMerchandisingKind kind, UIViewController controller, Action<AppStoreMerchandisingKindPresentationResult, NSError> completion);

	// +(void)requestReviewIn:(UIWindowScene * _Nonnull)scene;
	[Static]
	[Export ("requestReviewIn:")]
	void RequestReviewIn (UIWindowScene scene);
}

// @interface AppTransactionVerificationResult
[DisableDefaultCtor]
interface AppTransactionVerificationResult
{
	// @property (readonly, nonatomic) int isVerified;
	[Export ("isVerified")]
	int IsVerified { get; }

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
	NSUUID DeviceVerificationNonce { get; }

	// @property (readonly, nonatomic, strong) AppTransaction * _Nullable transaction;
	[NullAllowed, Export ("transaction", ArgumentSemantic.Strong)]
	AppTransaction Transaction { get; }

	// -(AppTransaction * _Nullable)getPayloadValueAndReturnError:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
	[Export ("getPayloadValueAndReturnError:")]
	[return: NullAllowed]
	AppTransaction GetPayloadValueAndReturnError ([NullAllowed] out NSError error);

	// -(AppTransaction * _Nullable)getUnsafePayloadValue __attribute__((warn_unused_result("")));
	[NullAllowed, Export ("getUnsafePayloadValue")]
	[Verify (MethodToProperty)]
	AppTransaction UnsafePayloadValue { get; }
}

// @interface AppTransaction
[DisableDefaultCtor]
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
	NSUUID DeviceVerificationNonce { get; }

	// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
	[Export ("signedDate", ArgumentSemantic.Copy)]
	NSDate SignedDate { get; }

	// +(void)getSharedTransactionAsyncWithCompletion:(void (^ _Nonnull)(AppTransaction * _Nullable, NSError * _Nullable))completion;
	[Static]
	[Export ("getSharedTransactionAsyncWithCompletion:")]
	void GetSharedTransactionAsyncWithCompletion (Action<AppTransaction, NSError> completion);

	// +(void)refreshTransactionAsyncWithCompletion:(void (^ _Nonnull)(AppTransaction * _Nullable, NSError * _Nullable))completion;
	[Static]
	[Export ("refreshTransactionAsyncWithCompletion:")]
	void RefreshTransactionAsyncWithCompletion (Action<AppTransaction, NSError> completion);
}

// @interface CurrencyWrapper
[DisableDefaultCtor]
interface CurrencyWrapper
{
	// -(NSString * _Nonnull)currencyCode __attribute__((warn_unused_result("")));
	[Export ("currencyCode")]
	[Verify (MethodToProperty)]
	string CurrencyCode { get; }

	// -(id)isISOCurrency __attribute__((warn_unused_result("")));
	[Export ("isISOCurrency")]
	[Verify (MethodToProperty)]
	NSObject IsISOCurrency { get; }

	// -(id)isEqualToCurrency:(CurrencyWrapper * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToCurrency:")]
	NSObject IsEqualToCurrency ([NullAllowed] CurrencyWrapper other);
}

// @interface ExpirationReason
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface ExpirationReason
{
	// @property (readonly, nonatomic) int rawValue;
	[Export ("rawValue")]
	int RawValue { get; }

	// -(instancetype _Nonnull)initWithRawValue:(id)rawValue __attribute__((objc_designated_initializer));
	[Export ("initWithRawValue:")]
	[DesignatedInitializer]
	NativeHandle Constructor (NSObject rawValue);

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

	// -(id)isEqualToReason:(ExpirationReason * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToReason:")]
	NSObject IsEqualToReason ([NullAllowed] ExpirationReason other);
}

// @interface ExternalLinkAccount
interface ExternalLinkAccount
{
	// +(void)canOpenAsyncWithCompletion:(id)completion;
	[Static]
	[Export ("canOpenAsyncWithCompletion:")]
	void CanOpenAsyncWithCompletion (NSObject completion);

	// +(void)openAsyncWithCompletion:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("openAsyncWithCompletion:")]
	void OpenAsyncWithCompletion (Action<NSError> completion);
}

// @interface ExternalPurchaseCustomLinkNoticeResult
[DisableDefaultCtor]
interface ExternalPurchaseCustomLinkNoticeResult
{
	// @property (readonly, nonatomic) int isCancelled;
	[Export ("isCancelled")]
	int IsCancelled { get; }
}

// @interface ExternalPurchaseCustomLinkToken
[DisableDefaultCtor]
interface ExternalPurchaseCustomLinkToken
{
	// @property (readonly, copy, nonatomic) NSString * _Nonnull value;
	[Export ("value")]
	string Value { get; }
}

// @interface ExternalPurchaseCustomLink
interface ExternalPurchaseCustomLink
{
	// +(void)isEligibleAsyncWithCompletion:(id)completion;
	[Static]
	[Export ("isEligibleAsyncWithCompletion:")]
	void IsEligibleAsyncWithCompletion (NSObject completion);

	// +(void)showNoticeAsyncWithType:(enum ExternalPurchaseCustomLinkNoticeType)type completion:(void (^ _Nonnull)(ExternalPurchaseCustomLinkNoticeResult * _Nullable, NSError * _Nullable))completion;
	[Static]
	[Export ("showNoticeAsyncWithType:completion:")]
	void ShowNoticeAsyncWithType (ExternalPurchaseCustomLinkNoticeType type, Action<ExternalPurchaseCustomLinkNoticeResult, NSError> completion);

	// +(void)getTokenAsyncFor:(NSString * _Nonnull)tokenType completion:(void (^ _Nonnull)(ExternalPurchaseCustomLinkToken * _Nullable, NSError * _Nullable))completion;
	[Static]
	[Export ("getTokenAsyncFor:completion:")]
	void GetTokenAsyncFor (string tokenType, Action<ExternalPurchaseCustomLinkToken, NSError> completion);
}

// @interface ExternalPurchaseLink
interface ExternalPurchaseLink
{
	// +(void)canOpenAsync:(id)completion;
	[Static]
	[Export ("canOpenAsync:")]
	void CanOpenAsync (NSObject completion);

	// +(void)openAsync:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("openAsync:")]
	void OpenAsync (Action<NSError> completion);

	// +(void)eligibleURLsAsync:(void (^ _Nonnull)(int))completion;
	[Static]
	[Export ("eligibleURLsAsync:")]
	void EligibleURLsAsync (Action<int> completion);

	// +(void)openAsync:(NSURL * _Nonnull)url completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("openAsync:completion:")]
	void OpenAsync (NSURL url, Action<NSError> completion);
}

// @interface ExternalPurchaseNoticeResult
[DisableDefaultCtor]
interface ExternalPurchaseNoticeResult
{
	// @property (readonly, nonatomic) int isCancelled;
	[Export ("isCancelled")]
	int IsCancelled { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nullable externalPurchaseToken;
	[NullAllowed, Export ("externalPurchaseToken")]
	string ExternalPurchaseToken { get; }
}

// @interface ExternalPurchase
interface ExternalPurchase
{
	// +(void)canPresentAsyncWithCompletion:(id)completion;
	[Static]
	[Export ("canPresentAsyncWithCompletion:")]
	void CanPresentAsyncWithCompletion (NSObject completion);

	// +(void)presentNoticeSheetAsyncWithCompletion:(void (^ _Nonnull)(ExternalPurchaseNoticeResult * _Nullable, NSError * _Nullable))completion;
	[Static]
	[Export ("presentNoticeSheetAsyncWithCompletion:")]
	void PresentNoticeSheetAsyncWithCompletion (Action<ExternalPurchaseNoticeResult, NSError> completion);
}

// @interface InvalidRequestError
[DisableDefaultCtor]
interface InvalidRequestError
{
	// @property (readonly, nonatomic) int code;
	[Export ("code")]
	int Code { get; }

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

// @interface MessageReason
[DisableDefaultCtor]
interface MessageReason
{
	// @property (readonly, nonatomic) int rawValue;
	[Export ("rawValue")]
	int RawValue { get; }

	// -(instancetype _Nonnull)initWithRawValue:(id)rawValue __attribute__((objc_designated_initializer));
	[Export ("initWithRawValue:")]
	[DesignatedInitializer]
	NativeHandle Constructor (NSObject rawValue);

	// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull generic;
	[Static]
	[Export ("generic", ArgumentSemantic.Strong)]
	MessageReason Generic { get; }

	// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull priceIncreaseConsent;
	[Static]
	[Export ("priceIncreaseConsent", ArgumentSemantic.Strong)]
	MessageReason PriceIncreaseConsent { get; }

	// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull billingIssue;
	[Static]
	[Export ("billingIssue", ArgumentSemantic.Strong)]
	MessageReason BillingIssue { get; }

	// @property (readonly, nonatomic, strong, class) MessageReason * _Nonnull winBackOffer;
	[Static]
	[Export ("winBackOffer", ArgumentSemantic.Strong)]
	MessageReason WinBackOffer { get; }

	// -(id)isEqualToReason:(MessageReason * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToReason:")]
	NSObject IsEqualToReason ([NullAllowed] MessageReason other);

	// @property (readonly, copy, nonatomic) NSString * _Nonnull localizedDescription;
	[Export ("localizedDescription")]
	string LocalizedDescription { get; }
}

// @interface Message
[DisableDefaultCtor]
interface Message
{
	// @property (readonly, nonatomic, strong) MessageReason * _Nullable reason;
	[NullAllowed, Export ("reason", ArgumentSemantic.Strong)]
	MessageReason Reason { get; }

	// -(id)displayIn:(UIWindowScene * _Nonnull)scene error:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
	[Export ("displayIn:error:")]
	NSObject DisplayIn (UIWindowScene scene, [NullAllowed] out NSError error);

	// +(void)getMessagesWithCompletion:(void (^ _Nonnull)(int))completion;
	[Static]
	[Export ("getMessagesWithCompletion:")]
	void GetMessagesWithCompletion (Action<int> completion);
}

// @interface PaymentMethodBindingError
[DisableDefaultCtor]
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

// @interface PaymentMethodBinding
[DisableDefaultCtor]
interface PaymentMethodBinding
{
	// +(void)createAsyncWithId:(NSString * _Nonnull)id completion:(void (^ _Nonnull)(PaymentMethodBinding * _Nullable, NSError * _Nullable))completion;
	[Static]
	[Export ("createAsyncWithId:completion:")]
	void CreateAsyncWithId (string id, Action<PaymentMethodBinding, NSError> completion);

	// -(void)bindAsyncWithCompletion:(void (^ _Nonnull)(PaymentMethodBindingError * _Nullable))completion;
	[Export ("bindAsyncWithCompletion:")]
	void BindAsyncWithCompletion (Action<PaymentMethodBindingError> completion);

	// @property (readonly, copy, nonatomic) NSString * _Nullable pinningID;
	[NullAllowed, Export ("pinningID")]
	string PinningID { get; }
}

// @interface PurchaseError
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

// @interface ProductPurchaseOptions
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface ProductPurchaseOptions
{
	// +(ProductPurchaseOptions * _Nonnull)appAccountToken:(NSUUID * _Nonnull)uuid __attribute__((warn_unused_result("")));
	[Static]
	[Export ("appAccountToken:")]
	ProductPurchaseOptions AppAccountToken (NSUUID uuid);

	// +(ProductPurchaseOptions * _Nonnull)customStringWithKey:(NSString * _Nonnull)key value:(NSString * _Nonnull)value __attribute__((warn_unused_result("")));
	[Static]
	[Export ("customStringWithKey:value:")]
	ProductPurchaseOptions CustomStringWithKey (string key, string value);

	// +(ProductPurchaseOptions * _Nonnull)customDoubleWithKey:(NSString * _Nonnull)key value:(double)value __attribute__((warn_unused_result("")));
	[Static]
	[Export ("customDoubleWithKey:value:")]
	ProductPurchaseOptions CustomDoubleWithKey (string key, double value);

	// +(ProductPurchaseOptions * _Nonnull)customBoolWithKey:(NSString * _Nonnull)key value:(id)value __attribute__((warn_unused_result("")));
	[Static]
	[Export ("customBoolWithKey:value:")]
	ProductPurchaseOptions CustomBoolWithKey (string key, NSObject value);

	// +(ProductPurchaseOptions * _Nonnull)customDataWithKey:(NSString * _Nonnull)key value:(NSData * _Nonnull)value __attribute__((warn_unused_result("")));
	[Static]
	[Export ("customDataWithKey:value:")]
	ProductPurchaseOptions CustomDataWithKey (string key, NSData value);

	// +(ProductPurchaseOptions * _Nonnull)onStorefrontChangeWithShouldContinuePurchase:(id)shouldContinuePurchase __attribute__((warn_unused_result("")));
	[Static]
	[Export ("onStorefrontChangeWithShouldContinuePurchase:")]
	ProductPurchaseOptions OnStorefrontChangeWithShouldContinuePurchase (NSObject shouldContinuePurchase);

	// +(ProductPurchaseOptions * _Nonnull)quantity:(id)quantity __attribute__((warn_unused_result("")));
	[Static]
	[Export ("quantity:")]
	ProductPurchaseOptions Quantity (NSObject quantity);

	// +(ProductPurchaseOptions * _Nonnull)simulateAskToBuy:(id)simulate __attribute__((warn_unused_result("")));
	[Static]
	[Export ("simulateAskToBuy:")]
	ProductPurchaseOptions SimulateAskToBuy (NSObject simulate);

	// +(ProductPurchaseOptions * _Nonnull)promotionalOfferLegacyWithOfferID:(NSString * _Nonnull)offerID keyID:(NSString * _Nonnull)keyID nonce:(NSUUID * _Nonnull)nonce signature:(NSData * _Nonnull)signature timestamp:(id)timestamp __attribute__((warn_unused_result("")));
	[Static]
	[Export ("promotionalOfferLegacyWithOfferID:keyID:nonce:signature:timestamp:")]
	ProductPurchaseOptions PromotionalOfferLegacyWithOfferID (string offerID, string keyID, NSUUID nonce, NSData signature, NSObject timestamp);

	// +(ProductPurchaseOptions * _Nonnull)promotionalOfferWithOfferID:(NSString * _Nonnull)offerID keyID:(NSString * _Nonnull)keyID nonce:(NSUUID * _Nonnull)nonce signature:(NSData * _Nonnull)signature timestamp:(id)timestamp __attribute__((warn_unused_result(""))) __attribute__((availability(tvos, introduced=15.0, deprecated=26.0))) __attribute__((availability(macos, introduced=12.0, deprecated=26.0))) __attribute__((availability(ios, introduced=15.0, deprecated=26.0)));
	[Introduced (PlatformName.TvOS, 15, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
	[Deprecated (PlatformName.TvOS, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
	[Introduced (PlatformName.MacOSX, 12, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
	[Deprecated (PlatformName.MacOSX, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
	[Introduced (PlatformName.iOS, 15, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
	[Deprecated (PlatformName.iOS, 26, 0, message: "Sign promotional offers with JWS and use promotionalOffer(_:compactJWS:) instead")]
	[Static]
	[Export ("promotionalOfferWithOfferID:keyID:nonce:signature:timestamp:")]
	ProductPurchaseOptions PromotionalOfferWithOfferID (string offerID, string keyID, NSUUID nonce, NSData signature, NSObject timestamp);

	// +(ProductPurchaseOptions * _Nullable)promotionalOfferWithOfferID:(NSString * _Nonnull)offerID signature:(SubscriptionOfferSignature * _Nonnull)signature __attribute__((warn_unused_result("")));
	[Static]
	[Export ("promotionalOfferWithOfferID:signature:")]
	[return: NullAllowed]
	ProductPurchaseOptions PromotionalOfferWithOfferID (string offerID, SubscriptionOfferSignature signature);

	// +(id)promotionalOfferWithOfferID:(NSString * _Nonnull)offerID compactJWS:(NSString * _Nonnull)compactJWS __attribute__((warn_unused_result("")));
	[Static]
	[Export ("promotionalOfferWithOfferID:compactJWS:")]
	NSObject PromotionalOfferWithOfferID (string offerID, string compactJWS);

	// +(ProductPurchaseOptions * _Nullable)winBackOffer:(SubscriptionOffer * _Nonnull)offer __attribute__((warn_unused_result("")));
	[Static]
	[Export ("winBackOffer:")]
	[return: NullAllowed]
	ProductPurchaseOptions WinBackOffer (SubscriptionOffer offer);

	// +(ProductPurchaseOptions * _Nonnull)introductoryOfferEligibilityWithCompactJWS:(NSString * _Nonnull)compactJWS __attribute__((warn_unused_result("")));
	[Static]
	[Export ("introductoryOfferEligibilityWithCompactJWS:")]
	ProductPurchaseOptions IntroductoryOfferEligibilityWithCompactJWS (string compactJWS);

	// -(id)isEqualToOptions:(ProductPurchaseOptions * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToOptions:")]
	NSObject IsEqualToOptions ([NullAllowed] ProductPurchaseOptions other);
}

// @interface ProductPurchaseResult
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface ProductPurchaseResult
{
	// @property (nonatomic, strong) TransactionVerificationResult * _Nullable verificationresult;
	[NullAllowed, Export ("verificationresult", ArgumentSemantic.Strong)]
	TransactionVerificationResult Verificationresult { get; set; }

	// @property (readonly, nonatomic) int isSuccess;
	[Export ("isSuccess")]
	int IsSuccess { get; }

	// @property (readonly, nonatomic) int isUserCancelled;
	[Export ("isUserCancelled")]
	int IsUserCancelled { get; }

	// @property (readonly, nonatomic) int isPending;
	[Export ("isPending")]
	int IsPending { get; }
}

// @interface ProductSubscriptionInfo
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface ProductSubscriptionInfo
{
	// @property (readonly, nonatomic, strong) SubscriptionOffer * _Nullable introductoryOffer;
	[NullAllowed, Export ("introductoryOffer", ArgumentSemantic.Strong)]
	SubscriptionOffer IntroductoryOffer { get; }

	// @property (readonly, nonatomic, strong) int * _Nonnull promotionalOffers;
	[Export ("promotionalOffers", ArgumentSemantic.Strong)]
	unsafe int* PromotionalOffers { get; }

	// @property (readonly, nonatomic, strong) int * _Nonnull winBackOffers;
	[Export ("winBackOffers", ArgumentSemantic.Strong)]
	unsafe int* WinBackOffers { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull subscriptionGroupID;
	[Export ("subscriptionGroupID")]
	string SubscriptionGroupID { get; }

	// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nonnull subscriptionPeriod;
	[Export ("subscriptionPeriod", ArgumentSemantic.Strong)]
	ProductSubscriptionPeriod SubscriptionPeriod { get; }

	// -(void)isEligibleForIntroOfferAsyncWithCompletion:(id)completion;
	[Export ("isEligibleForIntroOfferAsyncWithCompletion:")]
	void IsEligibleForIntroOfferAsyncWithCompletion (NSObject completion);

	// +(void)isEligibleForIntroOfferAsyncForGroupID:(NSString * _Nonnull)groupID completion:(id)completion;
	[Static]
	[Export ("isEligibleForIntroOfferAsyncForGroupID:completion:")]
	void IsEligibleForIntroOfferAsyncForGroupID (string groupID, NSObject completion);

	// -(void)statusAsync:(void (^ _Nonnull)(int))completion;
	[Export ("statusAsync:")]
	void StatusAsync (Action<int> completion);

	// +(void)statusForGroupIDAsync:(NSString * _Nonnull)groupID completion:(void (^ _Nonnull)(int))completion;
	[Static]
	[Export ("statusForGroupIDAsync:completion:")]
	void StatusForGroupIDAsync (string groupID, Action<int> completion);

	// +(void)statusForTransactionIDAsync:(NSNumber * _Nonnull)transactionID completion:(void (^ _Nonnull)(SubscriptionStatus * _Nullable, NSError * _Nullable))completion;
	[Static]
	[Export ("statusForTransactionIDAsync:completion:")]
	void StatusForTransactionIDAsync (NSNumber transactionID, Action<SubscriptionStatus, NSError> completion);

	// @property (readonly, nonatomic) int groupLevelValue;
	[Export ("groupLevelValue")]
	int GroupLevelValue { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull groupDisplayName;
	[Export ("groupDisplayName")]
	string GroupDisplayName { get; }

	// +(void)updateAsyncWithCompletion:(void (^ _Nonnull)(int))completion;
	[Static]
	[Export ("updateAsyncWithCompletion:")]
	void UpdateAsyncWithCompletion (Action<int> completion);

	// +(void)allStatusesAsyncWithCompletion:(void (^ _Nonnull)(int))completion;
	[Static]
	[Export ("allStatusesAsyncWithCompletion:")]
	void AllStatusesAsyncWithCompletion (Action<int> completion);
}

// @interface SubscriptionOffer
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

	// @property (readonly, nonatomic) int periodCount;
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

// @interface ProductSubscriptionPeriod
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface ProductSubscriptionPeriod
{
	// @property (readonly, nonatomic) enum Unit unit;
	[Export ("unit")]
	Unit Unit { get; }

	// @property (readonly, nonatomic) int value;
	[Export ("value")]
	int Value { get; }
}

// @interface ProductType
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

	// @property (readonly, nonatomic, strong, class) ProductType * _Nonnull unknown;
	[Static]
	[Export ("unknown", ArgumentSemantic.Strong)]
	ProductType Unknown { get; }

	// -(id)isEqualToType:(ProductType * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToType:")]
	NSObject IsEqualToType ([NullAllowed] ProductType other);
}

// @interface Product
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

	// @property (readonly, nonatomic) int isFamilyShareable;
	[Export ("isFamilyShareable")]
	int IsFamilyShareable { get; }

	// @property (readonly, copy, nonatomic) NSData * _Nonnull jsonRepresentation;
	[Export ("jsonRepresentation", ArgumentSemantic.Copy)]
	NSData JsonRepresentation { get; }

	// @property (readonly, nonatomic, strong) SWIFT_AVAILABILITY(tvos,introduced=15.0) ProductSubscriptionInfo * subscription __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
	[TV (15, 0), Mac (12, 0), iOS (15, 0)]
	[Export ("subscription", ArgumentSemantic.Strong)]
	ProductSubscriptionInfo Subscription { get; }

	// -(void)purchaseAsyncWithOptions:(id)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[Export ("purchaseAsyncWithOptions:completion:")]
	void PurchaseAsyncWithOptions (NSObject options, Action<ProductPurchaseResult, NSError> completion);

	// -(void)purchaseInSceneAsync:(UIScene * _Nonnull)scene options:(id)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion;
	[Export ("purchaseInSceneAsync:options:completion:")]
	void PurchaseInSceneAsync (UIScene scene, NSObject options, Action<ProductPurchaseResult, NSError> completion);

	// -(void)purchaseInViewControllerAsync:(UIViewController * _Nonnull)viewController options:(id)options completion:(void (^ _Nonnull)(ProductPurchaseResult * _Nullable, NSError * _Nullable))completion;
	[Export ("purchaseInViewControllerAsync:options:completion:")]
	void PurchaseInViewControllerAsync (UIViewController viewController, NSObject options, Action<ProductPurchaseResult, NSError> completion);

	// +(void)productsWithIdentifiersAsync:(id)identifiers completion:(void (^ _Nonnull)(int))completion;
	[Static]
	[Export ("productsWithIdentifiersAsync:completion:")]
	void ProductsWithIdentifiersAsync (NSObject identifiers, Action<int> completion);

	// -(void)latestTransactionWithCompletionAsync:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion;
	[Export ("latestTransactionWithCompletionAsync:")]
	void LatestTransactionWithCompletionAsync (Action<TransactionVerificationResult> completion);

	// -(void)currentEntitlementWithCompletionAsync:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable, NSError * _Nullable))completion __attribute__((availability(tvos, introduced=15.0, deprecated=18.4))) __attribute__((availability(macos, introduced=12.0, deprecated=15.4))) __attribute__((availability(ios, introduced=15.0, deprecated=18.4)));
	[Introduced (PlatformName.TvOS, 15, 0, message: "Use the currentEntitlements property instead.")]
	[Deprecated (PlatformName.TvOS, 18, 4, message: "Use the currentEntitlements property instead.")]
	[Introduced (PlatformName.MacOSX, 12, 0, message: "Use the currentEntitlements property instead.")]
	[Deprecated (PlatformName.MacOSX, 15, 4, message: "Use the currentEntitlements property instead.")]
	[Introduced (PlatformName.iOS, 15, 0, message: "Use the currentEntitlements property instead.")]
	[Deprecated (PlatformName.iOS, 18, 4, message: "Use the currentEntitlements property instead.")]
	[Export ("currentEntitlementWithCompletionAsync:")]
	void CurrentEntitlementWithCompletionAsync (Action<TransactionVerificationResult, NSError> completion);

	// -(void)currentEntitlementsWithCompletionAsync:(void (^ _Nonnull)(int))completion;
	[Export ("currentEntitlementsWithCompletionAsync:")]
	void CurrentEntitlementsWithCompletionAsync (Action<int> completion);
}

// @interface PromotionInfo
[DisableDefaultCtor]
interface PromotionInfo
{
	// @property (readonly, copy, nonatomic) NSString * _Nonnull productID;
	[Export ("productID")]
	string ProductID { get; }

	// @property (readonly, nonatomic) enum Visibility visibility;
	[Export ("visibility")]
	Visibility Visibility { get; }

	// -(void)updateAsync:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Export ("updateAsync:")]
	void UpdateAsync (Action<NSError> completion);

	// +(void)currentOrderAsync:(void (^ _Nonnull)(int))completion;
	[Static]
	[Export ("currentOrderAsync:")]
	void CurrentOrderAsync (Action<int> completion);

	// +(void)updateProductOrderAsyncByID:(id)order completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("updateProductOrderAsyncByID:completion:")]
	void UpdateProductOrderAsyncByID (NSObject order, Action<NSError> completion);

	// +(void)updateProductVisibilityAsync:(enum Visibility)visibility for:(NSString * _Nonnull)productID completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("updateProductVisibilityAsync:for:completion:")]
	void UpdateProductVisibilityAsync (Visibility visibility, string productID, Action<NSError> completion);

	// +(void)updateAllAsync:(id)promotions completion:(void (^ _Nonnull)(NSError * _Nullable))completion;
	[Static]
	[Export ("updateAllAsync:completion:")]
	void UpdateAllAsync (NSObject promotions, Action<NSError> completion);
}

// @interface PurchaseIntent
[DisableDefaultCtor]
interface PurchaseIntent
{
	// @property (readonly, nonatomic, strong) Product * _Nullable product;
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
	[Export ("observeIntentsAsyncWithIntentHandler:completion:")]
	void ObserveIntentsAsyncWithIntentHandler (Action<PurchaseIntent> intentHandler, Action completion);
}

// @interface RefundRequestError
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

// @interface RenewalInfoVerificationResult
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface RenewalInfoVerificationResult
{
	// @property (readonly, nonatomic) int isVerified;
	[Export ("isVerified")]
	int IsVerified { get; }

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
	NSUUID DeviceVerificationNonce { get; }

	// @property (readonly, nonatomic, strong) RenewalInfo * _Nonnull transaction;
	[Export ("transaction", ArgumentSemantic.Strong)]
	RenewalInfo Transaction { get; }

	// -(RenewalInfo * _Nullable)getPayloadValueAndReturnError:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
	[Export ("getPayloadValueAndReturnError:")]
	[return: NullAllowed]
	RenewalInfo GetPayloadValueAndReturnError ([NullAllowed] out NSError error);

	// -(RenewalInfo * _Nonnull)getUnsafePayloadValue __attribute__((warn_unused_result("")));
	[Export ("getUnsafePayloadValue")]
	[Verify (MethodToProperty)]
	RenewalInfo UnsafePayloadValue { get; }
}

// @interface RenewalInfo
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface RenewalInfo
{
	// @property (readonly, nonatomic, strong) NSNumber * _Nonnull originalTransactionID;
	[Export ("originalTransactionID", ArgumentSemantic.Strong)]
	NSNumber OriginalTransactionID { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull currentProductID;
	[Export ("currentProductID")]
	string CurrentProductID { get; }

	// @property (readonly, nonatomic) int willAutoRenew;
	[Export ("willAutoRenew")]
	int WillAutoRenew { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nullable autoRenewPreference;
	[NullAllowed, Export ("autoRenewPreference")]
	string AutoRenewPreference { get; }

	// @property (readonly, nonatomic, strong) ExpirationReason * _Nonnull expirationReason;
	[Export ("expirationReason", ArgumentSemantic.Strong)]
	ExpirationReason ExpirationReason { get; }

	// @property (readonly, nonatomic) enum PriceIncreaseStatus priceIncreaseStatus;
	[Export ("priceIncreaseStatus")]
	PriceIncreaseStatus PriceIncreaseStatus { get; }

	// @property (readonly, nonatomic) int isInBillingRetry;
	[Export ("isInBillingRetry")]
	int IsInBillingRetry { get; }

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
	[NullAllowed, Export ("currency", ArgumentSemantic.Strong)]
	CurrencyWrapper Currency { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nullable currencyCode;
	[NullAllowed, Export ("currencyCode")]
	string CurrencyCode { get; }

	// @property (readonly, nonatomic, strong) int * _Nonnull eligibleWinBackOfferIDs;
	[Export ("eligibleWinBackOfferIDs", ArgumentSemantic.Strong)]
	unsafe int* EligibleWinBackOfferIDs { get; }

	// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
	[Export ("deviceVerification", ArgumentSemantic.Copy)]
	NSData DeviceVerification { get; }

	// @property (readonly, copy, nonatomic) NSUUID * _Nonnull deviceVerificationNonce;
	[Export ("deviceVerificationNonce", ArgumentSemantic.Copy)]
	NSUUID DeviceVerificationNonce { get; }

	// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
	[Export ("signedDate", ArgumentSemantic.Copy)]
	NSDate SignedDate { get; }

	// @property (readonly, nonatomic, strong) SubcriptionAdvancedCommerceInfo * _Nullable advancedCommerceInfo;
	[NullAllowed, Export ("advancedCommerceInfo", ArgumentSemantic.Strong)]
	SubcriptionAdvancedCommerceInfo AdvancedCommerceInfo { get; }

	// @property (readonly, nonatomic, strong) NSUUID * _Nullable appAccountToken;
	[NullAllowed, Export ("appAccountToken", ArgumentSemantic.Strong)]
	NSUUID AppAccountToken { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull appTransactionID;
	[Export ("appTransactionID")]
	string AppTransactionID { get; }
}

// @interface RenewalState
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface RenewalState
{
	// @property (readonly, nonatomic) int rawValue;
	[Export ("rawValue")]
	int RawValue { get; }

	// -(instancetype _Nonnull)initWithRawValue:(id)rawValue __attribute__((objc_designated_initializer));
	[Export ("initWithRawValue:")]
	[DesignatedInitializer]
	NativeHandle Constructor (NSObject rawValue);

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

	// -(id)isEqualToState:(RenewalState * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToState:")]
	NSObject IsEqualToState ([NullAllowed] RenewalState other);
}

// @interface StoreFront
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface StoreFront
{
	// @property (readonly, copy, nonatomic) NSString * _Nonnull countryCode;
	[Export ("countryCode")]
	string CountryCode { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull identifier;
	[Export ("identifier")]
	string Identifier { get; }

	// @property (readonly, nonatomic, strong) CurrencyWrapper * _Nullable currency;
	[NullAllowed, Export ("currency", ArgumentSemantic.Strong)]
	CurrencyWrapper Currency { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nullable currencyCode;
	[NullAllowed, Export ("currencyCode")]
	string CurrencyCode { get; }

	// +(void)currentAsyncWithCompletion:(void (^ _Nonnull)(StoreFront * _Nullable))completion;
	[Static]
	[Export ("currentAsyncWithCompletion:")]
	void CurrentAsyncWithCompletion (Action<StoreFront> completion);

	// +(void)observeUpdatesAsyncWithUpdateHandler:(void (^ _Nonnull)(StoreFront * _Nonnull))updateHandler completion:(void (^ _Nonnull)(void))completion;
	[Static]
	[Export ("observeUpdatesAsyncWithUpdateHandler:completion:")]
	void ObserveUpdatesAsyncWithUpdateHandler (Action<StoreFront> updateHandler, Action completion);
}

// @interface StoreKitError
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

// @interface SubcriptionAdvancedCommerceInfo
[DisableDefaultCtor]
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
}

// @interface SubscriptionAdvancedCommerceItem
[DisableDefaultCtor]
interface SubscriptionAdvancedCommerceItem
{
	// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoItemDetails * _Nonnull details;
	[Export ("details", ArgumentSemantic.Strong)]
	TransactionAdvancedCommerceInfoItemDetails Details { get; }
}

// @interface SubscriptionOfferPaymentMode
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

	// -(id)isEqualToMode:(SubscriptionOfferPaymentMode * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToMode:")]
	NSObject IsEqualToMode ([NullAllowed] SubscriptionOfferPaymentMode other);
}

// @interface SubscriptionOfferSignature
[DisableDefaultCtor]
interface SubscriptionOfferSignature
{
	// @property (readonly, copy, nonatomic) NSString * _Nonnull keyID;
	[Export ("keyID")]
	string KeyID { get; }

	// @property (readonly, nonatomic, strong) NSUUID * _Nonnull nonce;
	[Export ("nonce", ArgumentSemantic.Strong)]
	NSUUID Nonce { get; }

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
	SubscriptionOfferSignature FromKeyID (string keyID, NSUUID nonce, NSNumber timestamp, NSData signatureData);
}

// @interface SubscriptionOfferType
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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
	[Static]
	[Export ("winBack", ArgumentSemantic.Strong)]
	SubscriptionOfferType WinBack { get; }

	// -(id)isEqualToType:(SubscriptionOfferType * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToType:")]
	NSObject IsEqualToType ([NullAllowed] SubscriptionOfferType other);
}

// @interface SubscriptionStatus
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

	// -(id)isEqualToStatus:(SubscriptionStatus * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToStatus:")]
	NSObject IsEqualToStatus ([NullAllowed] SubscriptionStatus other);
}

// @interface TransactionAdvancedCommerceInfoItemDetails
[DisableDefaultCtor]
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
}

// @interface TransactionAdvancedCommerceInfoItem
[DisableDefaultCtor]
interface TransactionAdvancedCommerceInfoItem
{
	// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoItemDetails * _Nullable details;
	[NullAllowed, Export ("details", ArgumentSemantic.Strong)]
	TransactionAdvancedCommerceInfoItemDetails Details { get; }

	// @property (readonly, nonatomic, strong) int * _Nullable refunds;
	[NullAllowed, Export ("refunds", ArgumentSemantic.Strong)]
	unsafe int* Refunds { get; }

	// @property (readonly, copy, nonatomic) NSDate * _Nullable revocationDate;
	[NullAllowed, Export ("revocationDate", ArgumentSemantic.Copy)]
	NSDate RevocationDate { get; }
}

// @interface TransactionAdvancedCommerceInfoOfferReason
[DisableDefaultCtor]
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

	// -(id)isEqualToReason:(TransactionAdvancedCommerceInfoOfferReason * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToReason:")]
	NSObject IsEqualToReason ([NullAllowed] TransactionAdvancedCommerceInfoOfferReason other);
}

// @interface TransactionAdvancedCommerceInfoOffer
[DisableDefaultCtor]
interface TransactionAdvancedCommerceInfoOffer
{
	// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nonnull price;
	[Export ("price", ArgumentSemantic.Strong)]
	NSDecimalNumber Price { get; }

	// @property (readonly, nonatomic, strong) ProductSubscriptionPeriod * _Nullable period;
	[NullAllowed, Export ("period", ArgumentSemantic.Strong)]
	ProductSubscriptionPeriod Period { get; }

	// @property (readonly, nonatomic, strong) NSNumber * _Nonnull periodCount;
	[Export ("periodCount", ArgumentSemantic.Strong)]
	NSNumber PeriodCount { get; }

	// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfoOfferReason * _Nullable reason;
	[NullAllowed, Export ("reason", ArgumentSemantic.Strong)]
	TransactionAdvancedCommerceInfoOfferReason Reason { get; }
}

// @interface TransactionAdvancedCommerceInfoRefundReason
[DisableDefaultCtor]
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

	// -(id)isEqualToReason:(TransactionAdvancedCommerceInfoRefundReason * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToReason:")]
	NSObject IsEqualToReason ([NullAllowed] TransactionAdvancedCommerceInfoRefundReason other);
}

// @interface TransactionAdvancedCommerceInfoRefundType
[DisableDefaultCtor]
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

	// -(id)isEqualToType:(TransactionAdvancedCommerceInfoRefundType * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToType:")]
	NSObject IsEqualToType ([NullAllowed] TransactionAdvancedCommerceInfoRefundType other);
}

// @interface TransactionAdvancedCommerceInfoRefund
[DisableDefaultCtor]
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

// @interface TransactionAdvancedCommerceInfo
[DisableDefaultCtor]
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
}

// @interface TransactionOfferPaymentMode
[DisableDefaultCtor]
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
	[Static]
	[Export ("oneTime", ArgumentSemantic.Strong)]
	TransactionOfferPaymentMode OneTime { get; }

	// -(id)isEqualToMode:(TransactionOfferPaymentMode * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToMode:")]
	NSObject IsEqualToMode ([NullAllowed] TransactionOfferPaymentMode other);
}

// @interface TransactionOffer
[DisableDefaultCtor]
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
	[NullAllowed, Export ("period", ArgumentSemantic.Strong)]
	ProductSubscriptionPeriod Period { get; }
}

// @interface TransactionOwnershipType
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

	// -(id)isEqualToType:(TransactionOwnershipType * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToType:")]
	NSObject IsEqualToType ([NullAllowed] TransactionOwnershipType other);
}

// @interface TransactionReason
[DisableDefaultCtor]
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

	// -(id)isEqualToReason:(TransactionReason * _Nullable)other __attribute__((warn_unused_result("")));
	[Export ("isEqualToReason:")]
	NSObject IsEqualToReason ([NullAllowed] TransactionReason other);
}

// @interface TransactionVerificationResult
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
interface TransactionVerificationResult
{
	// @property (readonly, nonatomic) int isVerified;
	[Export ("isVerified")]
	int IsVerified { get; }

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
	NSUUID DeviceVerificationNonce { get; }

	// @property (readonly, nonatomic, strong) Transaction * _Nonnull transaction;
	[Export ("transaction", ArgumentSemantic.Strong)]
	Transaction Transaction { get; }

	// -(Transaction * _Nullable)getPayloadValueAndReturnError:(NSError * _Nullable * _Nullable)error __attribute__((warn_unused_result("")));
	[Export ("getPayloadValueAndReturnError:")]
	[return: NullAllowed]
	Transaction GetPayloadValueAndReturnError ([NullAllowed] out NSError error);

	// -(Transaction * _Nonnull)getUnsafePayloadValue __attribute__((warn_unused_result("")));
	[Export ("getUnsafePayloadValue")]
	[Verify (MethodToProperty)]
	Transaction UnsafePayloadValue { get; }
}

// @interface Transaction
[TV (15,0), Mac (12,0), iOS (15,0)]
[DisableDefaultCtor]
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

	// @property (readonly, nonatomic) int purchasedQuantity;
	[Export ("purchasedQuantity")]
	int PurchasedQuantity { get; }

	// @property (readonly, nonatomic) int isUpgraded;
	[Export ("isUpgraded")]
	int IsUpgraded { get; }

	// @property (readonly, nonatomic, strong) TransactionOffer * _Nullable offer;
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

	// @property (readonly, nonatomic, strong) ProductType * _Nonnull productType;
	[Export ("productType", ArgumentSemantic.Strong)]
	ProductType ProductType { get; }

	// @property (readonly, copy, nonatomic) NSUUID * _Nullable appAccountToken;
	[NullAllowed, Export ("appAccountToken", ArgumentSemantic.Copy)]
	NSUUID AppAccountToken { get; }

	// @property (readonly, nonatomic, strong) AppStoreEnvironment * _Nullable environment;
	[NullAllowed, Export ("environment", ArgumentSemantic.Strong)]
	AppStoreEnvironment Environment { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull environmentStringRepresentation;
	[Export ("environmentStringRepresentation")]
	string EnvironmentStringRepresentation { get; }

	// @property (readonly, nonatomic, strong) TransactionReason * _Nullable reason;
	[NullAllowed, Export ("reason", ArgumentSemantic.Strong)]
	TransactionReason Reason { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull reasonStringRepresentation;
	[Export ("reasonStringRepresentation")]
	string ReasonStringRepresentation { get; }

	// @property (readonly, nonatomic, strong) StoreFront * _Nullable storefront;
	[NullAllowed, Export ("storefront", ArgumentSemantic.Strong)]
	StoreFront Storefront { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull storefrontCountryCode;
	[Export ("storefrontCountryCode")]
	string StorefrontCountryCode { get; }

	// @property (readonly, nonatomic, strong) NSDecimalNumber * _Nullable price;
	[NullAllowed, Export ("price", ArgumentSemantic.Strong)]
	NSDecimalNumber Price { get; }

	// @property (readonly, nonatomic, strong) CurrencyWrapper * _Nullable currency;
	[NullAllowed, Export ("currency", ArgumentSemantic.Strong)]
	CurrencyWrapper Currency { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nullable currencyCode;
	[NullAllowed, Export ("currencyCode")]
	string CurrencyCode { get; }

	// @property (readonly, copy, nonatomic) NSString * _Nonnull appTransactionID;
	[Export ("appTransactionID")]
	string AppTransactionID { get; }

	// @property (readonly, copy, nonatomic) NSData * _Nonnull deviceVerification;
	[Export ("deviceVerification", ArgumentSemantic.Copy)]
	NSData DeviceVerification { get; }

	// @property (readonly, copy, nonatomic) NSUUID * _Nullable deviceVerificationNonce;
	[NullAllowed, Export ("deviceVerificationNonce", ArgumentSemantic.Copy)]
	NSUUID DeviceVerificationNonce { get; }

	// @property (readonly, nonatomic, strong) TransactionOwnershipType * _Nonnull ownershipType;
	[Export ("ownershipType", ArgumentSemantic.Strong)]
	TransactionOwnershipType OwnershipType { get; }

	// @property (readonly, copy, nonatomic) NSDate * _Nonnull signedDate;
	[Export ("signedDate", ArgumentSemantic.Copy)]
	NSDate SignedDate { get; }

	// @property (readonly, nonatomic, strong) TransactionAdvancedCommerceInfo * _Nullable advancedCommerceInfo;
	[NullAllowed, Export ("advancedCommerceInfo", ArgumentSemantic.Strong)]
	TransactionAdvancedCommerceInfo AdvancedCommerceInfo { get; }

	// -(void)finishAsync:(void (^ _Nonnull)(void))completion;
	[Export ("finishAsync:")]
	void FinishAsync (Action completion);

	// +(void)updateTransactionsAsyncWithTransactionHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
	[Static]
	[Export ("updateTransactionsAsyncWithTransactionHandler:completion:")]
	void UpdateTransactionsAsyncWithTransactionHandler (Action<TransactionVerificationResult> transactionHandler, Action completion);

	// +(void)allTransactionsAsyncWithHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
	[Static]
	[Export ("allTransactionsAsyncWithHandler:completion:")]
	void AllTransactionsAsyncWithHandler (Action<TransactionVerificationResult> transactionHandler, Action completion);

	// +(void)currentEntitlementsAsyncWithHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
	[Static]
	[Export ("currentEntitlementsAsyncWithHandler:completion:")]
	void CurrentEntitlementsAsyncWithHandler (Action<TransactionVerificationResult> transactionHandler, Action completion);

	// +(void)currentEntitlementsAsyncForProductIDAsync:(NSString * _Nonnull)productID completion:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion __attribute__((availability(tvos, introduced=15.0, deprecated=18.4))) __attribute__((availability(macos, introduced=12.0, deprecated=15.4))) __attribute__((availability(ios, introduced=15.0, deprecated=18.4)));
	[Introduced (PlatformName.TvOS, 15, 0)]
	[Deprecated (PlatformName.TvOS, 18, 4)]
	[Introduced (PlatformName.MacOSX, 12, 0)]
	[Deprecated (PlatformName.MacOSX, 15, 4)]
	[Introduced (PlatformName.iOS, 15, 0)]
	[Deprecated (PlatformName.iOS, 18, 4)]
	[Static]
	[Export ("currentEntitlementsAsyncForProductIDAsync:completion:")]
	void CurrentEntitlementsAsyncForProductIDAsync (string productID, Action<TransactionVerificationResult> completion);

	// +(void)latestTransactionAsyncForProductID:(NSString * _Nonnull)productID completion:(void (^ _Nonnull)(TransactionVerificationResult * _Nullable))completion;
	[Static]
	[Export ("latestTransactionAsyncForProductID:completion:")]
	void LatestTransactionAsyncForProductID (string productID, Action<TransactionVerificationResult> completion);

	// +(void)unfinishedTransactionsAsyncWithTransactionHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
	[Static]
	[Export ("unfinishedTransactionsAsyncWithTransactionHandler:completion:")]
	void UnfinishedTransactionsAsyncWithTransactionHandler (Action<TransactionVerificationResult> transactionHandler, Action completion);

	// +(void)observeUpdatesAsyncWithTransactionHandler:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[Static]
	[Export ("observeUpdatesAsyncWithTransactionHandler:completion:")]
	void ObserveUpdatesAsyncWithTransactionHandler (Action<TransactionVerificationResult> transactionHandler, Action completion);

	// +(void)allTransactionsAsyncWithHandler:(NSString * _Nonnull)productID productID:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
	[Static]
	[Export ("allTransactionsAsyncWithHandler:productID:completion:")]
	void AllTransactionsAsyncWithHandler (string productID, Action<TransactionVerificationResult> transactionHandler, Action completion);

	// +(void)currentEntitlementsAsyncWithHandler:(NSString * _Nonnull)productID productID:(void (^ _Nonnull)(TransactionVerificationResult * _Nonnull))transactionHandler completion:(void (^ _Nonnull)(void))completion;
	[Static]
	[Export ("currentEntitlementsAsyncWithHandler:productID:completion:")]
	void CurrentEntitlementsAsyncWithHandler (string productID, Action<TransactionVerificationResult> transactionHandler, Action completion);

	// -(void)beginRefundRequestAsyncInScene:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(enum RefundRequestStatus, NSError * _Nullable))completion;
	[Export ("beginRefundRequestAsyncInScene:completion:")]
	void BeginRefundRequestAsyncInScene (UIWindowScene scene, Action<RefundRequestStatus, NSError> completion);

	// +(void)beginRefundRequestAsyncInScene:(id)transactionID transactionID:(UIWindowScene * _Nonnull)scene completion:(void (^ _Nonnull)(enum RefundRequestStatus, NSError * _Nullable))completion __attribute__((availability(tvos, unavailable))) __attribute__((availability(ios, introduced=15.0)));
	[NoTV, iOS (15,0)]
	[Static]
	[Export ("beginRefundRequestAsyncInScene:transactionID:completion:")]
	void BeginRefundRequestAsyncInScene (NSObject transactionID, UIWindowScene scene, Action<RefundRequestStatus, NSError> completion);

	// -(void)getSubscriptionStatusAsyncWithCompletion:(void (^ _Nonnull)(SubscriptionStatus * _Nullable))completion __attribute__((availability(tvos, introduced=15.0))) __attribute__((availability(macos, introduced=12.0))) __attribute__((availability(ios, introduced=15.0)));
	[TV (15,0), Mac (12,0), iOS (15,0)]
	[Export ("getSubscriptionStatusAsyncWithCompletion:")]
	void GetSubscriptionStatusAsyncWithCompletion (Action<SubscriptionStatus> completion);
}
