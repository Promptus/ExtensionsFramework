// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ExtensionsFramework",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "ExtensionsFramework", targets: ["ExtensionsFramework"]),
        .library(name: "Reachability", targets: ["Reachability"]),
    ],
    targets: [
        .target(
            name: "ExtensionsFramework",
            dependencies: ["ExtensionsFrameworkObjC"],
            resources: [.process("Calculator/CalculatorViewController.xib")]
        ),
        .target(
            name: "ExtensionsFrameworkObjC",
            dependencies: ["Reachability"],
            resources: [
                .process("Controls/NumberPad.xib"),
                .process("Controllers/PPWebBrowserViewController.xib"),
                .process("ExtensionsFramework.xcassets"),
                .process("Resources"),
            ],
            linkerSettings: [
                .linkedFramework("CoreData"),
                .linkedFramework("UIKit"),
                .linkedFramework("WebKit"),
            ]
        ),
        .target(
            name: "Reachability",
            exclude: ["LICENCE.txt"],
            resources: [.copy("PrivacyInfo.xcprivacy")],
            linkerSettings: [.linkedFramework("SystemConfiguration")]
        ),
    ]
)
