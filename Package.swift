// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Teapot",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "Teapot",
            targets: ["Teapot"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kareman/SwiftShell.git", from: Version(4, 1, 2)),
        .package(url: "https://github.com/kylef/PathKit.git", from: Version(0, 9, 2)),
        .package(url: "https://github.com/behrang/YamlSwift.git", from: Version(3, 4, 0)),
        .package(url: "https://github.com/bannzai/Ocha.git", from: Version(1, 1, 0)),
        .package(url: "https://github.com/kylef/Commander.git", from: Version(0, 8, 0))
    ],
    targets: [
        .target(
            name: "Teapot",
            dependencies: ["TeapotCore", "Commander"]),
        .target(
            name: "TeapotCore",
            dependencies: ["Ocha", "SwiftShell", "PathKit", "Yaml"]),
        .testTarget(
            name: "TeapotCoreTests",
            dependencies: ["TeapotCore"]),
    ]
)
