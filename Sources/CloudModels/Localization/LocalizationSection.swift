public final class LocalizationSection: Extensible, Identifiable {
    public var id: Identifier?
    public var application: ModelOrIdentifier<Application>
    public var name: String
    public var slug: String
    public var image: String
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        application: ModelOrIdentifier<Application>,
        name: String? = nil,
        slug: String? = nil,
        image: String? = nil
        ) {
        self.id = id
        self.application = application
        self.name = name ?? ""
        self.slug = slug ?? ""
        self.image = image ?? ""
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension LocalizationSection: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            application: ModelOrIdentifier(json: json.get("application")),
            name: json.get("name"),
            slug: json.get("slug"),
            image: json.get("image")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("slug", slug)
        try json.set("image", image)
        try json.set("application", application.makeJSON())
        return json
    }
}
