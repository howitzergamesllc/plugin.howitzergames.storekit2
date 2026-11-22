using ObjCRuntime;

namespace StoreKit2 {
	[Native]
	public enum ExternalPurchaseCustomLinkNoticeType : long {
		WithinApp = 0,
		Browser = 1
	}

	[Native]
	public enum PaymentMethodBindingErrorCode : long {
		NotEligible = 0,
		InvalidPinningID = 1,
		Failed = 2,
		Unknown = 3
	}

	[Native]
	public enum PriceIncreaseStatus : long {
		NoIncreasePending = 0,
		Pending = 1,
		Agreed = 2,
		Unknown = -1
	}

	[Native]
	public enum PurchaseErrorCode : long {
		InvalidQuantity = 0,
		ProductUnavailable = 1,
		PurchaseNotAllowed = 2,
		IneligibleForOffer = 3,
		InvalidOfferIdentifier = 4,
		InvalidOfferPrice = 5,
		InvalidOfferSignature = 6,
		MissingOfferParameters = 7,
		PaymentMethodBindingConfigurationRequired = 8,
		Unknown = 9
	}

	[Native]
	public enum RefundRequestErrorCode : long {
		DuplicateRequest = 0,
		Failed = 1,
		Ineligible = 2,
		Unknown = -1
	}

	[Native]
	public enum RefundRequestStatus : long {
		Success = 0,
		UserCancelled = 1,
		Failed = -1,
		Undefined = -2
	}

	[Native]
	public enum StoreKitErrorCode : long {
		Unknown = 0,
		UserCancelled = 1,
		NetworkError = 2,
		SystemError = 3,
		NotAvailableInStorefront = 4,
		NotEntitled = 5,
		Unsupported = 6,
		InvalidPresentationContext = 7
	}

	[Native]
	public enum TransactionOfferType : long {
		Introductory = 0,
		Promotional = 1,
		Code = 2,
		WinBack = 3,
		Unknown = -1
	}

	[Native]
	public enum TransactionRevocationReason : long {
		DeveloperIssue = 0,
		Other = 1,
		UpgradedToBundle = 2,
		Unknown = -1
	}

	[Native]
	public enum Unit : long {
		Day = 0,
		Week = 1,
		Month = 2,
		Year = 3,
		Unknown = 4
	}

	[Native]
	public enum VerificationErrorCode : long {
		RevokedCertificate = 0,
		InvalidCertificateChain = 1,
		InvalidDeviceVerification = 2,
		InvalidEncoding = 3,
		InvalidSignature = 4,
		MissingRequiredProperties = 5,
		None = 6,
		Unknown = -1
	}

	[Native]
	public enum Visibility : long {
		AppStoreConnectDefault = 0,
		Visible = 1,
		Hidden = 2
	}
}
