public final class Certificate: Extensible, Identifiable {
    public var id: Identifier?
    public var organization: ModelOrIdentifier<Organization>
    public var name: String
    public var privateKey: String
    public var fullChain: String
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        organization: ModelOrIdentifier<Organization>,
        name: String,
        privateKey: String,
        fullChain: String
    ) {
        self.id = id
        self.organization = organization
        self.name = name
        self.privateKey = privateKey
        self.fullChain = fullChain
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Certificate: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            organization: .identifier(json.get("organization.id")),
            name: json.get("name"),
            privateKey: json.get("privateKey"),
            fullChain: json.get("fullChain")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("organization.id", organization.getIdentifier())
        try json.set("name", name)
        try json.set("privateKey", privateKey)
        try json.set("fullChain", fullChain)
        return json
    }
}
