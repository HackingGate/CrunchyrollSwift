// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrunchyrollSwift",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CrunchyrollSwift",
            targets: ["CrunchyrollSwift"]),
        .library(
            name: "CrunchyrollSwiftWeb",
            targets: ["CrunchyrollSwiftWeb"]),
        .executable(
            name: "crunchyrollswift-dl",
            targets: ["CrunchyrollSwift-DL"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            url: "https://github.com/tid-kijyun/Kanna",
            from: "5.2.4"),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "0.3.0"),
        .package(
            url: "https://github.com/pvieito/PythonKit.git",
            .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CrunchyrollSwift",
            dependencies: [],
            path: "Sources/CrunchyrollSwift"),
        .target(
            name: "CrunchyrollSwiftWeb",
            dependencies: ["Kanna"],
            path: "Sources/CrunchyrollSwiftWeb"),
        .target(
            name: "CrunchyrollSwift-DL",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"),
                "CrunchyrollSwift",
                "CrunchyrollSwiftWeb",
                "PythonKit",
            ],
            path: "Sources/CrunchyrollSwift-DL"),
        .testTarget(
            name: "CrunchyrollSwiftTests",
            dependencies: ["CrunchyrollSwift"]),
    ]
)
