public enum Service {
    // all entity types are optional since they may
    // have since been deleted.
    // thus, all information required for billing must be stored here.
    case environment(ModelOrIdentifier<Environment>?)
    case database(ModelOrIdentifier<Database>?)
    case cache(ModelOrIdentifier<Cache>?)
    case databaseServer(ModelOrIdentifier<DatabaseServer>?)
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
            return cache?.getIdentifier()
        case .database(let db):
            return db?.getIdentifier()
        case .environment(let env):
            return env?.getIdentifier()
        case .databaseServer(let dbs):
            return dbs?.getIdentifier()
        }
    }
}

// MARK: JSON
import JSON

fileprivate struct ServiceError: Error {
    let reason: String
}

extension Service: JSONConvertible {
    public init(json: JSON) throws {
        let id = try json.get("id") as Identifier
        let type = try json.get("type") as String

        switch type {
        case "cache":
            self = .cache(.identifier(id))
        case "database":
            self = .database(.identifier(id))
        case "environment":
            self = .environment(.identifier(id))
        case "db-server":
            self = .databaseServer(.identifier(id))
        default:
            throw ModelsError.unspecified(
                ServiceError(reason: "Service type `\(type)` not supported.")
            )
        }
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("type", typeName)
        try json.set("id", id)
        return json
    }
}
