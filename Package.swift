// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package

import PackageDescription
let package = Package(
	name: "WebOverlay",
	platforms: [.iOS(.v10)]
    products: [
        .library(name: "WebOverlay", targets: ["WebOverlay"])
    ],
    targets: [.target(name: "WebOverlay", dependencies: [], path: "WebOverlay")
    ]
)