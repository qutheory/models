public enum Service {
    // all entity types are optional since they may
    // have since been deleted.
    // thus, all information required for billing must be stored here.
    case environment(Environment?)
    case database(Database?)
    case cache(Cache?)
    case databaseServer(DatabaseServer?)
}

extension Service {
    public var typeName: String {
        switch self {
        case .cache:
            return "cache"
        case .database:
            return "database"
        case .environment:
            return "environment"
        case .databaseServer:
            return "db-server"
        }
    }

    public var id: Identifier? {
        switch self {
        case .cache(let cache):
            return cache?.id
        case .database(let db):
            return db?.id
        case .environment(let env):
            return env?.id
        case .databaseServer(let dbs):
            return dbs?.id
        }
    }
}

// MARK: JSON
import JSON

extension Service: JSONRepresentable {

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("type", typeName)
        try json.set("id", id)
        return json
    }
}
