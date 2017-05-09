public final class CacheServer: Extensible, Identifiable {
    public enum Kind {
        case redis
        case memcached
    }
    
    public var id: Identifier?
    public var name: String
    public var hostname: String
    public var kind: Kind
    public var kindVersion: String
    public var instanceClass: String
    public var storageCapacity: Int
    public var region: String
    public var organization: ModelOrIdentifier<Organization>?
    public var extend: [String : Any]
    
    public init(
        id: Identifier?,
        name: String,
        hostname: String,
        kind: Kind,
        kindVersion: String,
        instanceClass: String,
        storageCapacity: Int,
        region: String
    ) {
        self.id = id
        self.name = name
        self.hostname = hostname
        self.kind = kind
        self.kindVersion = kindVersion
        self.instanceClass = instanceClass
        self.storageCapacity = storageCapacity
        self.region = region
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension CacheServer: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            name: json.get("name"),
            hostname: json.get("hostname"),
            kind: json.get("kind"),
            kindVersion: json.get("kindVersion"),
            instanceClass: json.get("instanceClass"),
            storageCapacity: json.get("storageCapacity"),
            region: json.get("region")
        )
        if let orgId = try json.get("organization.id") as Identifier? {
            organization = .identifier(orgId)
        }
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("hostname", hostname)
        try json.set("instanceClass", instanceClass)
        try json.set("kind", kind)
        try json.set("kindVersion", kindVersion)
        try json.set("storageCapacity", storageCapacity)
        try json.set("region", region)
        try json.set("organization.id", organization?.getIdentifier())
        return json
    }
}

// MARK: Kind

// MARK: Node

extension CacheServer.Kind: NodeConvertible {
    public init(node: Node) throws {
        switch node.string ?? "" {
        case "redis":
            self = .redis
        case "memcached":
            self = .memcached
        default:
            throw NodeError.unableToConvert(
                input: node,
                expectation: "Cache Server Kind",
                path: []
            )
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        switch self {
        case .redis:
            return "redis"
        case .memcached:
            return "memcached"
        }
    }
}
