import PackageDescription

let package = Package(
    name: "Models",
    dependencies: [
        // A formatted data encapsulation meant to facilitate the transformation from one object to another
        .Package(url: "https://github.com/vapor/node.git", Version(2,0,0, prereleaseIdentifiers: ["alpha"])),

        // JSON wrapper around Node.
        .Package(url: "https://github.com/vapor/json.git", Version(2,0,0, prereleaseIdentifiers: ["alpha"]))
    ]
)
