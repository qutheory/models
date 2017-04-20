public final class Hosting: Extensible, Identifiable {
    public var id: Identifier?
    public var application: ModelOrIdentifier<Application>
    public var gitUrl: String
    public var extend: [String: Any]
    
    public init(
        _ id: Identifier? = nil,
        _ application: ModelOrIdentifier<Application>,
        gitUrl: String
    ) {
        self.id = id
        self.application = application
        self.gitUrl = gitUrl
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Hosting: JSONConvertible {
    public convenience init(json: JSON) throws {
        self.init(
            try json.get("id"),
            try ModelOrIdentifier(json: try json.get("application")),
            gitUrl: try json.get("gitUrl")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("application", application.makeJSON())
        try json.set("gitUrl", gitUrl)
        return json
    }
}
