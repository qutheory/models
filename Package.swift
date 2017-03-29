import PackageDescription

let package = Package(
    name: "Models",
    dependencies: [
        // Swift models, relationships, and querying for NoSQL and SQL databases.
        .Package(url: "https://github.com/vapor/fluent.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),

        // JSON wrapper around Node.
        .Package(url: "https://github.com/vapor/json.git", Version(2,0,0, prereleaseIdentifiers: ["beta"]))
    ]
)
