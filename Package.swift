// swift-tools-version: 5.6

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
            type: .dynamic,
            targets: ["Logger"]
        ),
    ],
    targets: [
        .target(
            name: "Logger"
        )
    ]
)
