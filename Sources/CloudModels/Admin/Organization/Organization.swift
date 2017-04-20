public final class Organization: Extensible, Identifiable {
    public var id: Identifier?
    public var name: String
    public var extend: [String: Any]

    public init(
        _ id: Identifier? = nil,
        name: String
    ) {
        self.id = id
        self.name = name
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Organization: JSONConvertible {
    public convenience init(json: JSON) throws {
        self.init(
            try json.get("id"),
            name: try json.get("name")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        return json
    }
}
