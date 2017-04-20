public final class Project: Extensible, Identifiable {
    public var id: Identifier?
    public var name: String
    public var color: String
    public var organization: ModelOrIdentifier<Organization>
    public var extend: [String: Any]

    public init(
        _ id: Identifier? = nil,
        name: String,
        color: String,
        organization: ModelOrIdentifier<Organization>
    ) {
        self.id = id
        self.name = name
        self.color = color
        self.organization = organization
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Project: JSONConvertible {
    public convenience init(json: JSON) throws {
        self.init(
            try json.get("id"),
            name: try json.get("name"),
            color: try json.get("color"),
            organization: try ModelOrIdentifier(json: 
                json.get("organization")
            )
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("color", color)
        try json.set("organization", organization.makeJSON())
        return json
    }
}
