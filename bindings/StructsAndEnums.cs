public enum ExternalPurchaseCustomLinkNoticeType
{
	WithinApp = 0,
	Browser = 1
}

public enum PaymentMethodBindingErrorCode
{
	NotEligible = 0,
	InvalidPinningID = 1,
	Failed = 2,
	Unknown = 3
}

public enum PriceIncreaseStatus
{
	NoIncreasePending = 0,
	Pending = 1,
	Agreed = 2,
	Unknown = -1
}

public enum PurchaseErrorCode
{
	InvalidQuantity = 0,
	ProductUnavailable = 1,
	PurchaseNotAllowed = 2,
	IneligibleForOffer = 3,
	InvalidOfferIdentifier = 4,
	InvalidOfferPrice = 5,
	InvalidOfferSignature = 6,
	MissingOfferParameters = 7,
	Unknown = 8
}

public enum RefundRequestErrorCode
{
	DuplicateRequest = 0,
	Failed = 1,
	Unknown = -1
}

public enum RefundRequestStatus
{
	Success = 0,
	UserCancelled = 1,
	Failed = -1,
	Undefined = -2
}

public enum StoreKitErrorCode
{
	Unknown = 0,
	UserCancelled = 1,
	NetworkError = 2,
	SystemError = 3,
	NotAvailableInStorefront = 4,
	NotEntitled = 5,
	Unsupported = 6
}

public enum TransactionOfferType
{
	Introductory = 0,
	Promotional = 1,
	Code = 2,
	WinBack = 3,
	Unknown = -1
}

public enum TransactionRevocationReason
{
	DeveloperIssue = 0,
	Other = 1,
	Unknown = -1
}

public enum Unit
{
	Day = 0,
	Week = 1,
	Month = 2,
	Year = 3,
	Unknown = 4
}

public enum VerificationErrorCode
{
	RevokedCertificate = 0,
	InvalidCertificateChain = 1,
	InvalidDeviceVerification = 2,
	InvalidEncoding = 3,
	InvalidSignature = 4,
	MissingRequiredProperties = 5,
	None = 6,
	Unknown = -1
}

public enum Visibility
{
	AppStoreConnectDefault = 0,
	Visible = 1,
	Hidden = 2
}
