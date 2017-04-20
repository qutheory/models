public final class Environment: Extensible, Identifiable {
    public var id: Identifier?
    public var hosting: ModelOrIdentifier<Hosting>
    public var name: String
    public var replicas: Int
    public var replicaSize: ReplicaSize
    public var defaultBranch: String
    public var extend: [String: Any]
    public var running: Bool {
        return replicas > 0
    }

    public init(
        _ id: Identifier? = nil,
        _ hosting: ModelOrIdentifier<Hosting>,
        name: String? = nil,
        replicas: Int? = nil,
        _ replicaSize: ReplicaSize,
        defaultBranch: String? = nil
    ) {
        self.id = id
        self.hosting = hosting
        self.name = name ?? "production"
        self.replicas = replicas ?? 0
        self.replicaSize = replicaSize
        self.defaultBranch = defaultBranch ?? "master"
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Environment: JSONConvertible {
    public convenience init(json: JSON) throws {
        self.init(
            try json.get("id"),
            try ModelOrIdentifier(json: json.get("hosting")),
            name: try json.get("name"),
            replicas: try json.get("replicas"),
            try json.get("replicaSize"),
            defaultBranch: try json.get("defaultBranch")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("replicas", replicas)
        try json.set("replicaSize", replicaSize)
        try json.set("defaultBranch", defaultBranch)
        try json.set("hosting", hosting.makeJSON())
        try json.set("running", running)
        return json
    }
}
