// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "ToDoCMD",  // Your package name
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .executable(
      name: "ToDoCMD",  // Executable product
      targets: ["ToDoCMD"]  // Target for your executable
    ),
  ],
  dependencies: [],
  targets: [
    .executableTarget(  // Use executableTarget instead of target
      name: "ToDoCMD",  // Name of the executable target
      path: "Sources/ToDoCMD"  // Path to your source code
                     ),
    .testTarget(
      name: "ToDoCMDTests",  // Your test target name
      dependencies: ["ToDoCMD"],
      path: "Tests/ToDoCMDTests"  // Path to your test files
    ),
  ]
)
