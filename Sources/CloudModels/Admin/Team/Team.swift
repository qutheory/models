import JSON

public final class Team: Extensible, Identifiable {
    public var id: Identifier?
    public var name: String
    public var extend: [String : Any]
    public var organization: ModelOrIdentifier<Organization>
    
    public init(
        id: Identifier? = nil,
        name: String,
        organization: ModelOrIdentifier<Organization>
    ) {
        self.id = id
        self.name = name
        self.organization = organization
        self.extend = [:]
    }
}

// MARK: JSON

extension Team: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            name: json.get("name"),
            organization: ModelOrIdentifier(json: json.get("organization"))
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("organization", organization.makeJSON())
        return json
    }
}
