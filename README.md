# ExtensionsFramework

## Swift Package Manager (0.6.0)

In Xcode, add `https://github.com/Promptus/ExtensionsFramework.git` as a package dependency. Select version `0.6.0`. The package requires iOS 13 or later and Swift tools 5.9 or later. CocoaPods is not required.

Link the `ExtensionsFramework` product. Objective-C clients can `@import ExtensionsFrameworkObjC;`. Keep `-ObjC` in the app's Other Linker Flags so Objective-C categories load. Link the separate `Reachability` product if the app imports it directly.

`Sources/` contains the maintained SwiftPM implementation and its resource bundles. It includes the calculator, number pad, and browser. `WeekPicker` and `WeekPickerItem` are **not** in the Swift package. The legacy Xcode project and pod still use the original `ExtensionsFramework/` directory, including the picker and its `iCarousel` dependency.

The Reachability target includes [tonymillion/Reachability v3.7.7](https://github.com/tonymillion/Reachability/tree/v3.7.7), its license, and its privacy manifest. Its compatibility code still uses SystemConfiguration for host-specific flags; a general network path monitor does not supply those flags.
