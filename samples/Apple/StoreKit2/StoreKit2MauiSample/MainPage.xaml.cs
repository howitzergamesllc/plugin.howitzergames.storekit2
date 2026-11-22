
using StoreKit2;
using Foundation;
using UIKit;
using System.Diagnostics;
using CoreFoundation;
using System.IO.Pipelines;

namespace StoreKit2MauiSample;

public partial class MainPage : ContentPage
{
#if __IOS__ || __TVOS__
        internal static bool HasUIScene => UIKit.UIDevice.CurrentDevice.CheckSystemVersion(17, 0); // For UIKit-based Scene purchase
        internal static bool HasUIViewController => UIKit.UIDevice.CurrentDevice.CheckSystemVersion(18, 2); // For UIViewController-based purchase
#else
		static bool
        initUIScene, hasUIScene, initUIViewController, hasUIViewController;
        internal static bool HasUIScene
        {
            get
            {
                if (initUIScene) 
                    return hasUIScene;
                initUIScene = true;
                hasUIScene = false; //[NoMac]
                return hasUIScene;
            }
        }

        internal static bool HasUIViewController
        {
            get
            {
                if (initUIViewController) 
                    return hasUIViewController;
                initUIViewController = true;
                hasUIViewController = false; //[NoMac]
                return hasUIViewController;
            }
        }
#endif

	public MainPage()
	{
		InitializeComponent();
		Init();
	}

	AppleTransactionObserver? transactionObserver;

	void Init()
	{
		if(transactionObserver != null)
			return;

		Debug.WriteLine($"[StoreKit2] [LogPurchaseResult] Creating AppleTransactionObserver");
		Console.WriteLine($"[StoreKit2] [LogPurchaseResult] Creating AppleTransactionObserver");

		transactionObserver = new AppleTransactionObserver();
		transactionObserver.OnPurchaseUnverified += LogPurchaseResult;
		transactionObserver.OnPurchaseRevoked += LogPurchaseResult;
		transactionObserver.OnSubscriptionExpired += LogPurchaseResult;
		transactionObserver.OnSubscriptionUpgraded += LogPurchaseResult;
		transactionObserver.OnPurchaseSuccessful += LogPurchaseResult;
		transactionObserver.OnPurchaseConsumed += LogPurchaseResult;
	}

	private void LogPurchaseResult(object? sender, TransactionVerificationResult result)
	{
		Debug.WriteLine($"[StoreKit2] [LogPurchaseResult] TransactionVerificationResults " 
			+ $"TransactionId: {result.Transaction.Id}, ProductId: {result.Transaction.ProductID}, IsVerified: {result.IsVerified} "
			+ $"DatePurchased: {result.Transaction.PurchaseDate}, ExpirationDate: {result.Transaction.ExpirationDate}");
		Console.WriteLine($"[StoreKit2] [LogPurchaseResult] TransactionVerificationResults " 
			+ $"TransactionId: {result.Transaction.Id}, ProductId: {result.Transaction.ProductID}, IsVerified: {result.IsVerified} "
			+ $"DatePurchased: {result.Transaction.PurchaseDate}, ExpirationDate: {result.Transaction.ExpirationDate}");
	}

	private void OnPurchaseCoinsClicked(object? sender, EventArgs e)
	{
		_ = PurchaseAsync("coinbundle1");
	}        
	async Task<IEnumerable<Product>> GetProductAsync(string[] productIds)
	{
		return await Product.ProductsWithIdentifiersAsyncAsync(productIds);
	}

	public async Task PurchaseAsync(string productId, ProductPurchaseOptions[] options = null, CancellationToken cancellationToken = default)
	{
		Init();

		var products = await GetProductAsync([productId]);
		var product = products.FirstOrDefault();
		var result = await PurchaseAsync(product, [ProductPurchaseOptions.BillingPlanType(BillingPlanType.UpFront)]);
		await result.Verificationresult?.Transaction?.FinishAsyncAsync();
		LogPurchaseResult(this, result.Verificationresult);
	}

	async Task<ProductPurchaseResult> PurchaseAsync(Product product, ProductPurchaseOptions[] options = null)
	{
		if (product == null)
			throw new Exception("No products found");

		if(HasUIViewController)
		{
			var controller = UIViewControllerExtensions.GetCurrentViewController();
			return await product.PurchaseInViewControllerAsyncAsync(controller, options);
		}
		else if(HasUIScene)
		{
			var scene = UIViewControllerExtensions.GetCurrentScene();
			return await product.PurchaseInSceneAsyncAsync(scene, options);
		}
		else
		{
			var viewcontroller = UIViewControllerExtensions.GetCurrentViewController();
			return await product.PurchaseAsyncWithOptionsAsync(options);
		}
	}

    /// <summary>
    /// Observer for Apple transactions
    /// </summary>
    [Preserve(AllMembers = true)]
    class AppleTransactionObserver
    {
        public event EventHandler<TransactionVerificationResult> OnTransactionUpdated;
        public event EventHandler<TransactionVerificationResult> OnTransactionSuccessful;
        public event EventHandler<TransactionVerificationResult> OnPurchaseUnverified;
        public event EventHandler<TransactionVerificationResult> OnPurchaseRevoked;
        public event EventHandler<TransactionVerificationResult> OnSubscriptionExpired;
        public event EventHandler<TransactionVerificationResult> OnSubscriptionUpgraded;
        public event EventHandler<TransactionVerificationResult> OnPurchaseSuccessful;
        public event EventHandler<TransactionVerificationResult> OnPurchaseConsumed;

        public AppleTransactionObserver()
        {
            StartListening();
        }

        private void StartListening()
        {
            // Launch background listener for StoreKit transactions
            _ = Transaction.ObserveUpdatesAsyncWithTransactionHandlerAsync(transactionVerificationResultHandler: HandleTransactionUpdate).ContinueWith(t =>
            {
                if (t.IsFaulted || t.IsCanceled || t.IsCompletedSuccessfully || t.IsCompleted)
                {
                    Console.WriteLine($"Error in transaction update listener: {t.Exception}");
                    Debug.WriteLine($"Error in transaction update listener: {t.Exception}");
                }
            });
        }

        private void HandleTransactionUpdate(TransactionVerificationResult transactionResult)
        {
            if (transactionResult == null || transactionResult.Transaction == null)
            {
                Console.WriteLine("Null transaction result received in transaction update handler.");
                Debug.WriteLine("Null transaction result received in transaction update handler.");
                return;
            }

            if (!transactionResult.IsVerified)
            {
                DispatchQueue.MainQueue.DispatchAsync(() =>
                {
                    OnPurchaseUnverified?.Invoke(this, transactionResult);
                });
                //Do nothing, invalid transaction
                return;
            }

            OnTransactionUpdated?.Invoke(this, transactionResult);

            if (transactionResult.Transaction.RevocationDate != null)
            {
                DispatchQueue.MainQueue.DispatchAsync(() =>
                {
                    OnPurchaseRevoked?.Invoke(this, transactionResult);
                });
                // Handle revoked purchase
                // TODO: Remove entitlement for transaction.ProductId
            }
            else if (transactionResult.Transaction.ExpirationDate != null &&
                    transactionResult.Transaction.ExpirationDate.SecondsSince1970 < NSDate.Now.SecondsSince1970)
            {
                DispatchQueue.MainQueue.DispatchAsync(() =>
                {
                    OnSubscriptionExpired?.Invoke(this, transactionResult);
                });
                // Subscription expired — do nothing
                return;
            }
            else if (transactionResult.Transaction.IsUpgraded)
            {
                DispatchQueue.MainQueue.DispatchAsync(() =>
                {
                    OnSubscriptionUpgraded?.Invoke(this, transactionResult);
                });
                // Do nothing, there is an active transaction
                // Subscription upgraded — ignore lower level transaction
                return;
            }
            else
            {
                Console.WriteLine($"Updated Transaction | {transactionResult.Transaction.Description}");
                Debug.WriteLine($"Updated Transaction | {transactionResult.Transaction.Description}");
                MainThread.BeginInvokeOnMainThread(() =>
                {
                    OnTransactionSuccessful?.Invoke(this, transactionResult);
                    OnPurchaseSuccessful?.Invoke(this, transactionResult);
                });
				_ = FinishTransaction(transactionResult);
                // Handle successful purchase, unlock content and deliver consumables.
            }
        }

        private async Task FinishTransaction(TransactionVerificationResult result)
        {
            try
            {
                await result.Transaction.FinishAsyncAsync();                
                DispatchQueue.MainQueue.DispatchAsync(() =>
                {
                    OnPurchaseConsumed?.Invoke(this, result);
                });
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Error finishing transaction {result.Transaction.Id}: {ex}");
            }
        }
    }

    internal static class UIViewControllerExtensions
    {
        internal static UIViewController GetCurrentViewController()
        {
            var window = UIApplication.SharedApplication
                .ConnectedScenes
                .OfType<UIWindowScene>()
                .SelectMany(scene => scene.Windows)
                .FirstOrDefault(w => w.IsKeyWindow);

            var root = window?.RootViewController;
            if (root == null)
                return null;

            return GetPresentedViewController(root);
        }

        internal static UIViewController GetPresentedViewController(UIViewController controller)
        {
            if (controller.PresentedViewController != null)
                return GetPresentedViewController(controller.PresentedViewController);

            if (controller is UINavigationController nav && nav.VisibleViewController != null)
                return GetPresentedViewController(nav.VisibleViewController);

            if (controller is UITabBarController tab && tab.SelectedViewController != null)
                return GetPresentedViewController(tab.SelectedViewController);

            return controller;
        }

        /// <summary>
        /// Returns the first active UIWindowScene (or null if none found)
        /// </summary>
        public static UIWindowScene GetCurrentScene()
        {
            // Return the first foreground-active scene of type UIWindowScene
            var scene = UIApplication.SharedApplication
                .ConnectedScenes
                .OfType<UIWindowScene>()
                .FirstOrDefault(s => s.ActivationState == UISceneActivationState.ForegroundActive);

            return scene;
        }
    }
}
