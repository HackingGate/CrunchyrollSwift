// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "CrunchyrollSwift",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "CrunchyrollSwift",
            targets: ["CrunchyrollSwift"]),
        .library(
            name: "CrunchyrollSwiftWeb",
            targets: ["CrunchyrollSwiftWeb"]),
        .executable(
            name: "crunchyrollswift-dl",
            targets: ["CrunchyrollSwift-DL"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tid-kijyun/Kanna",
            from: "5.2.7"),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.1.3"),
        .package(
            url: "https://github.com/pvieito/PythonKit.git",
            .branch("master"))
    ],
    targets: [
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
                "PythonKit"
            ],
            path: "Sources/CrunchyrollSwift-DL"),
        .testTarget(
            name: "CrunchyrollSwiftTests",
            dependencies: ["CrunchyrollSwift"])
    ]
)
