# plugin.howitzergames.storekit2

## Todo:

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

- Use objectivesharpie to generate ApiDefinitions, Enums, Structs
```zsh
sharpie bind \
    --framework=./externals/StoreKit2.xcframework/ios-arm64/StoreKit2.framework \
    --output=source/Apple/StoreKit2/sharpie \
    --namespace=StoreKit2 \
    --sdk=iphoneos27.2 \
    --verbose
```

### BUild Nuget Packages for Testing:

- Clean
```zsh
./clean.sh
```

- Build the source code nuget packages first for use in the .Nuget.sln and Nuget.Local.Config
```zsh
dotnet build plugin.howitzergames.storekit2.slnx --configfile Nuget.Config
```

- Clean the Sample Projects
```zsh
./cleansamples.sh
```

- Now build the nuget solution to inject the local nuget packages for sample building and deployment testing.
```zsh
dotnet build plugin.howitzergames.storekit2.NuGet.slnx --configfile Nuget.Local.Config
```

### Build Nuget Packages for Pushing:
- Debugging changes
```zsh
dotnet build source/Apple/StoreKit2/StoreKit2.csproj
```
- Publishing for testing changes
```zsh
dotnet build source/Apple/StoreKit2/StoreKit2.csproj -c release
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

### Push packages for remote use on github.
```zsh
dotnet nuget push "$HOME/path/to/your/projects/plugin.howitzergames.storekit2/source/Apple/StoreKit2/bin/StoreKit2/release/plugin.howitzergames.storekit2.11.0.0.nupkg" --source "https://nuget.pkg.github.com/howitzergamesllc/index.json" --api-key $GITHUBTOKEN
```

### Test Build the published package to verify changes work:
- Build the example for ios
```zsh
dotnet build samples/Apple/StoreKit2/TestApp/TestApp.csproj
```

