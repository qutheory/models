public final class Hosting: Extensible, Identifiable {
    public var id: Identifier?
    public var application: ModelOrIdentifier<Application>
    public var gitURL: String
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        application: ModelOrIdentifier<Application>,
        gitURL: String
    ) {
        self.id = id
        self.application = application
        self.gitURL = gitURL
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Hosting: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            application: ModelOrIdentifier(json: try json.get("application")),
            gitURL: json.get("gitURL")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("application", application.makeJSON())
        try json.set("gitURL", gitURL)
        return json
    }
}
