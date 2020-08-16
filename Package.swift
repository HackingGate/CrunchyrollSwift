// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrunchyrollSwift",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CrunchyrollSwift",
            targets: ["CrunchyrollSwift"]),
        .library(
            name: "CrunchyrollSwiftWeb",
            targets: ["CrunchyrollSwiftWeb"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/tid-kijyun/Kanna", "5.2.2"..<"6.0.0")
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
        .testTarget(
            name: "CrunchyrollSwiftTests",
            dependencies: ["CrunchyrollSwift"]),
    ]
)
