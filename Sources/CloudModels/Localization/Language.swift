public final class Language: Extensible, Identifiable {
    public var id: Identifier?
    public var name: String
    public var locale: String
    public var direction: String
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        name: String,
        locale: String,
        direction: String
        ) {
        self.id = id
        self.name = name
        self.locale = locale
        self.direction = direction
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Language: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            name: json.get("name"),
            locale: json.get("locale"),
            direction: json.get("direction")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("locale", locale)
        try json.set("direction", direction)
        return json
    }
}
