// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "capturesdk_flutter",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "capturesdk-flutter", targets: ["capturesdk_flutter"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/SocketMobile/swift-package-capturesdk.git", .upToNextMinor(from: "2.1.22"))
    ],
    targets: [
        .target(
            name: "capturesdk_flutter",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "CaptureSDK", package: "swift-package-capturesdk")
            ],
            cSettings: [
                .headerSearchPath("include/capturesdk_flutter")
            ]
        )
    ]
)
