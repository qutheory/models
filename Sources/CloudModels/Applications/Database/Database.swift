public final class Database: Identifiable, Extensible {
    public var id: Identifier?
    public var databaseServer: ModelOrIdentifier<DatabaseServer>
    public var environment: ModelOrIdentifier<Environment>
    public var extend: [String : Any]
    
    public init(
        id: Identifier? = nil,
        databaseServer: ModelOrIdentifier<DatabaseServer>,
        environment: ModelOrIdentifier<Environment>
    ) throws {
        self.id = id
        self.databaseServer = databaseServer
        self.environment = environment
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Database: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            databaseServer: .identifier(json.get("databaseServer.id")),
            environment: .identifier(json.get("application.id"))
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("databaseServer", databaseServer.makeJSON())
        try json.set("environment", environment.makeJSON())
        return json
    }
}
