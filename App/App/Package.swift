// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS("15.0")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "App",
            targets: ["UIKitView", "Data", "Domain"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "RxSwift", url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.5.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Domain",
            dependencies: []),
        .target(
            name: "Data",
            dependencies: ["Domain"]),
        .target(
            name: "UIKitView",
            dependencies: ["Domain", .byName(name: "RxSwift"), .product(name: "RxCocoa", package: "RxSwift")]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "Domain"]),
    ]
)
