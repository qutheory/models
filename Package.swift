import PackageDescription

let package = Package(
    name: "CloudModels",
    dependencies: [
        // Swift models, relationships, and querying for NoSQL and SQL databases.
        .Package(url: "https://github.com/vapor/fluent.git", majorVersion: 2),

        // JSON wrapper around Node.
        .Package(url: "https://github.com/vapor/json.git", majorVersion: 2)
    ]
)
