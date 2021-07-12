public final class LocalizationKey: Extensible, Identifiable {
    public var id: Identifier?
    public var localization: ModelOrIdentifier<Localization>
    public var key: String
    public var type: String
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        localization: ModelOrIdentifier<Localization>,
        key: String,
        type: String
    ) {
        self.id = id
        self.localization = localization
        self.key = key
        self.type = type
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension LocalizationKey: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            localization: json.get("localization"),
            key: json.get("key"),
            type: json.get("type")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("key", key)
        try json.set("type", type)
        try json.set("localization", localization)
        return json
    }
}
