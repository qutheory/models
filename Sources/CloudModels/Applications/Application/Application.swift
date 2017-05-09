public final class Application: Extensible, Identifiable {
    public var id: Identifier?
    public var project: ModelOrIdentifier<Project>
    public var repoName: String // Slug, this will be used in the URL <repoName>.vapor.cloud
    public var name: String // A more human readable name, can contain special chars etc.
    public var extend: [String: Any]
    public var cost: Cost?
    
    public init(
        id: Identifier? = nil,
        project: ModelOrIdentifier<Project>,
        repoName: String,
        name: String
    ) {
        self.id = id
        self.project = project
        self.repoName = repoName
        self.name = name
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Application: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            project: .identifier(json.get("project.id")),
            repoName: json.get("repoName"),
            name: json.get("name")
        )
        cost = try json.get("cost")
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("project.id", project.getIdentifier())
        try json.set("repoName", repoName)
        try json.set("name", name)
        try json.set("cost", cost?.makeJSON())
        return json
    }
}
