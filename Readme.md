# Overview
This is a C# binding project that binds to an xcode project that wrapped swift from StoreKit v2 API from Apple in ObjC.

### This project has no affiliation with Microsoft, the Maui/Xamarin teams, or Apple.
Microsoft's current recommendation to iOS.NET developers is that they should write their own bindings using this slim binding demo project: https://github.com/Redth/DotNet.Platform.SlimBindings


# StoreKit Apple SDK and NuGet Releases
| SDK Name                        | SDK Version |NuGet Package Version|
|:-------------------------------:|:-----------:|:-------------------:|
| plugin.howitzergames.storekit2  |             | 11.0.0             |


# Nuget.org
[![NuGet](https://img.shields.io/nuget/v/plugin.howitzergames.storekit2.svg)](https://www.nuget.org/packages/plugin.howitzergames.storekit2/)


# NuGet package consumption
```zsh
dotnet add package plugin.howitzergames.storekit2
```

### Ensure proper Condition in .csproj for iOS / MacCatalyst:
```xml
<ItemGroup Condition="'$(TargetFramework)' == 'net11.0-ios' OR '$(TargetFramework)' == 'net11.0-maccatalyst'">
  <PackageReference Include="plugin.howitzergames.storekit2" Version="11.0.0" />
</ItemGroup>
```


# Building
See the build notes for specific instructions on building this nuget here: [BuildNotes(Mac)](https://github.com/howitzergamesllc/plugin.howitzergames.storekit2/blob/main/BuildNotes(Mac).md)


# License
The license developers are required to accept is a generic MIT license located at: [License](https://github.com/howitzergamesllc/plugin.howitzergames.storekit2/blob/main/License.md)


# Apple SDK Notices
Apple SDK notices can be found here:
[ExternalDependencyInfo](https://github.com/howitzergamesllc/plugin.howitzergames.storekit2/blob/main/source/Apple/StoreKit2/External-Dependency-Info.txt)


# Release Notes:

### Version 11.0.0:
    - net11.0 target added.
    - StoreKit2 Updates
        - PurchaseError.paymentMethodBindingConfigurationRequired
        - AppTransaction.RevocationDate added
        - AppTransaction.all added
        - AppTransaction.StoreType added
        - AppStore.Platform.Managed type added
        - RedeemOption added
        - Transaction.AdvancedCommerceInfo.Partner added
        - Transaction.RevocationType string enum added
        - Transaction.RevocationReason.UpgradedToBundle enum added
        - StoreKitError.invalidPresentationContext enum added
        - PricingTerms implemented
        - BundledSubscription implemented
        - BillingPlanType implemented
        - CommitmentInfo implemented

### Version 10.0.30:
    - Update C# bindings to address the updates to the xcframework (see below).
    - Updated xcframework to be runtime safe.
        - Removed/commented all @available attributes to prevent runtime crashes and ensure backwards compatability back to iOS 15.0.
        - Added runtime safety checks to all @available methods and classes to ensure functionality is the same.
        - Added fallback behaviors for methods and classes that are not available on older iOS versions.

### Version 10.0.20:
    - Removed old reference names.

### Version 10.0.10:
    - Initial build of StoreKit2 framework.
