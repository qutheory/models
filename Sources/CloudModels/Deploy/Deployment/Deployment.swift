public final class Deployment: Extensible, Identifiable {
    // MARK: Properties
    public var id: Identifier?
    public let repoName: String
    public var status: Status
    public let environmentName: String
    public var version: Int
    public let type: Method
    public let databaseId: Identifier
    public let git: (url: String, branch: String)
    public let replicas: Int
    public var replicaSize: String
    public let domains: [String]
    public var extend: [String: Any]

    public init(
        _ id: Identifier? = nil,
        repoName: String,
        status: Status,
        environmentName: String,
        version: Int,
        type: Method,
        databaseId: Identifier,
        git: (url: String, branch: String),
        replicas: Int,
        replicaSize: String,
        domains: [String]
    ) {
        self.id = id
        self.repoName = repoName
        self.status = status
        self.environmentName = environmentName
        self.version = version
        self.type = type
        self.databaseId = databaseId
        self.git = git
        self.replicas = replicas
        self.replicaSize = replicaSize
        self.domains = domains
        self.extend = [:]
    }
}

// MARK: JSON
import JSON 

extension Deployment: JSONConvertible {
    public convenience init(json: JSON) throws {
        let status: Status
        if json["status"] != nil {
            status = try json.get("status")
        } else {
            status = .queued
        }

        try self.init(
            json.get("id"),
            repoName: json.get("environment.application.repoName"),
            status: status,
            environmentName: json.get("environment.name"),
            version: json["version"]?.int ?? 0,
            type: Method(json: json.get("type")),
            databaseId: json.get("database.id"),
            git: (json.get("git.url"), json.get("git.branch")),
            replicas: json.get("replicas"),
            replicaSize: json.get("replicaSize"),
            domains: json.get("domains")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("status", status)
        try json.set("version", version)
        try json.set("type", type.makeJSON())
        try json.set("environment.name", environmentName)
        try json.set("environment.application.repoName", repoName)
        try json.set("database.id", databaseId)
        try json.set("git.url", git.url)
        try json.set("git.branch", git.branch)
        try json.set("replicas", replicas)
        try json.set("replicaSize", replicaSize)
        try json.set("domains", domains)
        return json
    }
}
