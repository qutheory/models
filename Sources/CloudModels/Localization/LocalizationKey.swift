public final class LocalizationKey: Extensible, Identifiable {
    public var id: Identifier?
    public var section: ModelOrIdentifier<LocalizationSection>
    public var key: String
    public var type: String
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        section: ModelOrIdentifier<LocalizationSection>,
        key: String? = nil,
        type: String? = nil
        ) {
        self.id = id
        self.section = section
        self.key = key ?? ""
        self.type = type ?? ""
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension LocalizationKey: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            section: ModelOrIdentifier(json: json.get("section")),
            key: json.get("key"),
            type: json.get("type")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("key", key)
        try json.set("type", type)
        try json.set("section", section.makeJSON())
        return json
    }
}
