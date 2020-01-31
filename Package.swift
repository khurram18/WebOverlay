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