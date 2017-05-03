public final class Cache: Identifiable, Extensible {
    public var id: Identifier?
    public var server: ModelOrIdentifier<CacheServer>
    public var environment: ModelOrIdentifier<Environment>
    public var username: String?
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        server: ModelOrIdentifier<CacheServer>,
        environment: ModelOrIdentifier<Environment>,
        username: String? = nil
    ) throws {
        self.id = id
        self.server = server
        self.environment = environment
        self.username = username
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Cache: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            server: .identifier(json.get("server.id")),
            environment: .identifier(json.get("application.id")),
            username: json.get("username")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("server", server.makeJSON())
        try json.set("environment", environment.makeJSON())
        return json
    }
}
