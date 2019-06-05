// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "MUToast",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "MUToast",
            targets: ["MUToast"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/MoveUpwards/MUHeader", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "MUToast",
            dependencies: ["MUHeader"],
            path: "Sources"
        ),
        .testTarget(
            name: "MUToastTests",
            dependencies: ["MUToast"],
            path: "Tests"
        ),
    ]
)
