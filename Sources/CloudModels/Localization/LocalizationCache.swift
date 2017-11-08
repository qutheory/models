public final class LocalizationCache: Extensible, Identifiable {
    public var id: Identifier?
    public var localization: ModelOrIdentifier<Localization>
    public var language: ModelOrIdentifier<Language>
    public var version: Int
    public var data: String
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        localization: ModelOrIdentifier<Localization>,
        language: ModelOrIdentifier<Language>,
        version: Int,
        data: String
    ) {
        self.id = id
        self.localization = localization
        self.language = language
        self.version = version
        self.data = data
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension LocalizationCache: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            localization: json.get("localization"),
            language: json.get("language"),
            version: json.get("version"),
            data: json.get("data")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("version", version)
        try json.set("data", data)
        try json.set("localization", localization)
        try json.set("language", language)
        return json
    }
}

