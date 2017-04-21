public final class Organization: Extensible, Identifiable {
    public var id: Identifier?
    public var name: String
    public var credits: Double
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        name: String,
        credits: Double = 0
    ) {
        self.id = id
        self.name = name
        self.credits = credits
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Organization: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            name: json.get("name"),
            credits: json.get("credits")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("credits", credits)
        return json
    }
}
