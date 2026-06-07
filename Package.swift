// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EarthDrift",
    platforms: [.macOS(.v15)],
    products: [
        .executable(name: "EarthDrift", targets: ["EarthDrift"])
    ],
    targets: [
        .executableTarget(
            name: "EarthDrift",
            resources: [.process("Resources")],
            swiftSettings: [.unsafeFlags(["-swift-version", "5"])]
        )
    ]
)
