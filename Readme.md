# Overview

This is a C# binding project that binds to an xcode project that wrapped swift from StoreKit v2 API from Apple in ObjC.

### This project has no affiliation with Microsoft, the Maui/Xamarin teams, or Apple.

Microsoft's current recommendation to iOS.NET developers is that they should write their own bindings using this slim binding demo project: https://github.com/Redth/DotNet.Platform.SlimBindings

# Adding the Project

```cmd
dotnet add package plugin.howitzergames.storekit2
```

# Notes

# StoreKit Apple SDK and NuGet Releases

| SDK Name                        | SDK Version |NuGet Package Version|
|:-------------------------------:|:-----------:|:-------------------:|
| plugin.howitzergames.storekit2  |  10.0.10    | 10.0.10             |

# Nuget.org
[![NuGet](https://img.shields.io/nuget/v/plugin.howitzergames.storekit2.svg)](https://www.nuget.org/packages/plugin.howitzergames.storekit2/)

# Troubleshooting

# NuGet package consumption
Ensure proper Condition in .csproj for iOS / MacCatalyst:

```xml
<ItemGroup Condition="'$(TargetFramework)' == 'net10.0-ios' OR '$(TargetFramework)' == 'net10.0-maccatalyst'">
  <PackageReference Include="plugin.howitzergames.storekit2" Version="10.0.10" />
</ItemGroup>
```

# Contributing
To reproduce this package and make improvements, see MacBuildNotes.md. 
