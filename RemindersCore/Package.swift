// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RemindersCore",
    products: [
        .library(name: "RemindersCore", targets: ["RemindersCore"]),
    ],
    targets: [
        .target(name: "RemindersCore", dependencies: []),
        .testTarget(name: "RemindersCoreTests", dependencies: ["RemindersCore"]),
    ]
)
