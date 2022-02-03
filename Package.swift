// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "t",
    products: [
        .library(
            name: "t",
            targets: ["t"]
        ),
    ],
    targets: [
        .target(
            name: "t",
            dependencies: []
        ),
        .testTarget(
            name: "tTests",
            dependencies: ["t"]
        ),
    ]
)
