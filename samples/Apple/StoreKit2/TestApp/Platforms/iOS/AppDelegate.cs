using Foundation;
using StoreKit2;
using Microsoft.Maui;
using Microsoft.Maui.Hosting;
using UIKit;

namespace TestApp;

[Register("AppDelegate")]
public class AppDelegate : MauiUIApplicationDelegate
{
	public override async void OnActivated (UIApplication application)
	{
		base.OnActivated (application);
		await Product.ProductsWithIdentifiersAsyncAsync(new string[0]);
	}
	protected override MauiApp CreateMauiApp() => MauiProgram.CreateMauiApp();
}
