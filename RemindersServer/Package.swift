// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "RemindersServer",
    products: [
        .library(name: "CodeSharing", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
	.package(path: "../RemindersCore")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "RemindersCore"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

