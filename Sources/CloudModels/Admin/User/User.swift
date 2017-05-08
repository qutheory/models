public final class User: Extensible, Identifiable {
    // MARK: Properties
    public var id: Identifier?
    public var name: Name
    public var image: String?
    public var email: String
    public var password: String?
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        name: Name,
        image: String?,
        email: String,
        password: String? = nil
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.email = email
        self.password = password
        self.extend = [:]
    }
}

// MARK: JSON
import JSON 

extension User: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            name: Name(json: json.get("name")),
            image: json.get("image"),
            email: json.get("email")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name.makeJSON())
        try json.set("image", image)
        try json.set("email", email)
        return json
    }
}

