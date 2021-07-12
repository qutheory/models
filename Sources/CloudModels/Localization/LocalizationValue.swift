public final class LocalizationValue: Extensible, Identifiable {
    public var id: Identifier?
    public var key: ModelOrIdentifier<LocalizationKey>
    public var language: ModelOrIdentifier<Language>
    public var string: String
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        key: ModelOrIdentifier<LocalizationKey>,
        language: ModelOrIdentifier<Language>,
        string: String
    ) {
        self.id = id
        self.key = key
        self.language = language
        self.string = string
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension LocalizationValue: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            key: json.get("key"),
            language: json.get("language"),
            string: json.get("string")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("key", key)
        try json.set("language", language)
        try json.set("string", string)
        return json
    }
}

