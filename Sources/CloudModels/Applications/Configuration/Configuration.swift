public final class Configuration: Extensible, Identifiable {
    public var id: Identifier?
    public var environment: ModelOrIdentifier<Environment>
    public var key: String
    public var value: String
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        environment: ModelOrIdentifier<Environment>,
        key: String,
        value: String
    ) {
        self.id = id
        self.environment = environment
        self.key = key
        self.value = value
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Configuration: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            environment: ModelOrIdentifier(json: try json.get("environment")),
            key: try json.get("key"),
            value: try json.get("value")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("environment", environment.makeJSON())
        try json.set("key", key)
        try json.set("value", value)
        return json
    }
}

