// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "darwin-logger",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .macCatalyst(.v14)
    ],
    products: [
        .library(
            name: "Logger",
            targets: ["Logger"]
        ),
    ],
    targets: [
        .target(
            name: "Logger",
            path: "Sources"
        )
    ]
)
