# plugin.howitzergames.storekit2

## Todo:
- Add convenience named completion handlers and result classes.

# Reproducing the project
## Download the project
- Navigate to your projects
cd "$HOME/path/to/your/projects"

- Setup the project: Download/fork/pull the repo to a shortpath folder and document the base project repo filepath.
```zsh
git clone "https://github.com/howitzergamesllc/plugin.howitzergames.storekit2.git"
```
- Between changes always verify latest commit by fetching and pulling
```zsh
git fetch
```
```zsh
git pull
```
- Navigate to the root directory
```zsh
cd "plugin.howitzergames.storekit2"
```

## Build and extract the xcframework to the project externals folder:

- Navigate to the swift project.
```zsh
cd "swift/StoreKit2-swift"
```
### Make any desired improvements here
- Archive the build for iOS, iOS simulator, and MacCatalyst
    - iOS
```zsh
xcodebuild archive \
  -scheme StoreKit2 \
  -configuration Release \
  -destination "generic/platform=iOS" \
  -archivePath "./build/StoreKit2-iOS.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```
    - iOS Simulator
```zsh
xcodebuild archive \
  -scheme StoreKit2 \
  -configuration Release \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "./build/StoreKit2-Simulator.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```
    - MacCatalyst
```zsh
xcodebuild archive \
  -scheme StoreKit2 \
  -configuration Release \
  -destination "generic/platform=macOS,variant=Mac Catalyst" \
  -archivePath "./build/StoreKit2-MacCatalyst.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
```

- Verify the frameworks exist at these locations:
"/Users/yourname/path-to-yourprojects/plugin.howitzergames.storekit2/swift/StoreKit2-Swift/build/StoreKit2-iOS.xcarchive/Products/Library/Frameworks/StoreKit2.framework"

"/Users/yourname/path-to-yourprojects/plugin.howitzergames.storekit2/swift/StoreKit2-Swift/build/StoreKit2-Simulator.xcarchive/Products/Library/Frameworks/StoreKit2.framework"

"/Users/yourname/path-to-yourprojects/plugin.howitzergames.storekit2/swift/StoreKit2-Swift/build/StoreKit2-Maccatalyst.xcarchive/Products/Library/Frameworks/StoreKit2.framework"

- Build the dynamic xcframework
```zsh
xcodebuild -create-xcframework \
  -framework "/Users/yourname/path-to-yourprojects/plugin.howitzergames.storekit2/swift/StoreKit2-Swift/build/StoreKit2-iOS.xcarchive/Products/Library/Frameworks/StoreKit2.framework" \
  -framework "/Users/yourname/path-to-yourprojects/plugin.howitzergames.storekit2/swift/StoreKit2-Swift/build/StoreKit2-Simulator.xcarchive/Products/Library/Frameworks/StoreKit2.framework" \
  -framework "/Users/yourname/path-to-yourprojects/plugin.howitzergames.storekit2/swift/StoreKit2-Swift/build/StoreKit2-Maccatalyst.xcarchive/Products/Library/Frameworks/StoreKit2.framework" \
  -output "./StoreKit2.xcframework"
```

### Flattening the xcframework dSYMs

- Navigate back to the root
```zsh
cd "$Home/path/to/your/projects/plugin.howitzergames.storekit2"
```
- Make the flattening script executeable
```zsh
chmod +x flatten_storekit.sh
```
- Execute the script
```zsh
./flatten_storekit.sh
```

This should copy the xcframework to the externals folder at ./externals and remove dSYMs.

### Generate the C# Bindings Using ObjectiveSharpie
- Navigate to the bindings folder
```zsh
cd bindings
```
- Use objectivesharpie to generate ApiDefinitions, Enums, Structs
```zsh
sharpie bind ..../Release-iphoneos/StoreKit2.framework/Headers/StoreKit2-Swift.h --sdk iphoneos26.1
```

### Verify Bindings are Correct
- Navigate back to root
```zsh
cd ..
```
- Make the binding helper script executeable
```zsh
chmod +x fixbindings.sh
```
- Execute the script
```zsh
./fixbindings.sh
```

These scripts achieve the following:

Copy and paste from the root directory "plugin.howitzergames.storekit2/bindings" to the C# binding project directory "plugin.howitzergames.storekit2/source/Apple/StoreKit2"

Rename StructsandEnums.cs to "Enums.cs"

Wrap ApiDefinitions.cs and Enums.cs in namespace StoreKit2
Add using UIKit

Remove the following Attributes entirely
[Verify (MethodToProperty)]
[Introduced (PlatformName.VisionOS, 1, 0)]
Also remove Watch and NoWatch from these
[NoWatch, NoTV, NoMac, iOS (16,0)]
[Watch (8,0), TV (15,0), Mac (12,0), iOS (15,0)]

Then they become
[NoTV, NoMac, iOS (16,0)]
[TV (15,0), Mac (12,0), iOS (15,0)]

Rename all NSUUID to NSUuid
Rename all NSURL to NSUrl

Add [Async] properties to all async/throw swift type funcs.
Add [BaseType (typeof(NSObject))] to every class/interface that doesn't already inherit a different base type.

Corrections after running the script:

Some async types that return bool in swift will need correction in the C# binding. Objectivesharpie interprets direct Task(bool) types as NSObject when in fact the C# binding should be Action<bool>.
ExternalLinkAccount
ExternalPurchaseCustomLink
ExternalPurchaseLink
ExternalPurchase
ProductSubscriptionInfo

Type Arrays like[AdvancedCommerceProductPurchaseOptionWrapper] from swift will be converted to NSObject. Convertback to AdvancedCommerceProductPurchaseOptionWrapper[].

Check rawValue initializer that take Int types. They may have been converted to NSObject. Correct to "nint"

Change Int * pointers to NSArray

Verify inputs/outputs of every method. Suspicious types are int, bool, NSObject.

### Build Nuget Packages for Pushing:
- Debugging changes
```zsh
dotnet build source\Apple\StoreKit2\StoreKit2.csproj
```
- Publishing for testing changes
```zsh
dotnet build source\Apple\StoreKit2\StoreKit2.csproj -c release
```

### GitHub Publishing Commands
- Navigate back to root directory
```zsh
cd "C:\Users\yourname\patht-to-yourprojects\plugin.howitzergames.storekit2"
```
- Ensure remote origin connected
```zsh
git remote add origin https://github.com/yourname/plugin.howitzergames.storekit2.git
```
- Add local changes to the local repo
```zsh
git add .
```
- Commit the changes
```zsh 
git commit -m "Initial commit with project files"
```
- Verify fork branch
```zsh
git branch -m fork
```
- Push changes to the fork
```zsh
git push -u origin main
```

### Push packages for private publishing.
```zsh
dotnet nuget push "$HOME/path/to/your/projects/plugin.howitzergames.storekit2/source/Apple/StoreKit2/bin/StoreKit2/release/plugin.howitzergames.storekit2.10.0.20.nupkg" --source "https://nuget.pkg.github.com/howitzergamesllc/index.json" --api-key $GITHUBTOKEN
```

### Push packages for public publishing
```zsh
dotnet nuget push "$HOME/path/to/your/projects/plugin.howitzergames.storekit2/source/Apple/StoreKit2/bin/StoreKit2/release/plugin.howitzergames.storekit2.10.0.20.nupkg" --api-key "$NUGETTOKEN" --source https://api.nuget.org/v3/index.json
```

### Test Build the published package to verify changes work:
- Build the example for ios
```zsh
dotnet build samples/Apple/StoreKit2/TestApp/TestApp.csproj
```

