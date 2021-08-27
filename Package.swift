// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "SwiftyPick",
    products: [
        .library(
            name: "SwiftyPick",
            type: .dynamic,
            targets: ["SwiftyPick"]
        ),
        .library(
            name: "DangerDeps",
            type: .dynamic,
            targets: ["DangerDependencies"]
        ) // dev
    ],
    dependencies: [
        .package(
            url: "https://github.com/danger/swift.git",
            from: "3.0.0"
        ), // dev
        // Danger Plugins
        .package(
            url: "https://github.com/f-meloni/danger-swift-coverage",
            from: "1.2.1"
        ), // dev
        .package(
            url: "https://github.com/f-meloni/danger-swift-xcodesummary",
            from: "1.0.0"
        ) // dev
    ],
    targets: [
        .target(
            name: "SwiftyPick",
            dependencies: ["Danger"]
        ),
        .target(
            name: "DangerDependencies",
            dependencies: ["Danger", "DangerSwiftCoverage", "DangerXCodeSummary"]
        ), // dev
    ],
    swiftLanguageVersions: [
        .version("5")
    ]
)
