public final class Log: Extensible, Identifiable {
    public var id: Identifier?
    public let message: String
    public let time: Date
    public let deployment: ModelOrIdentifier<Deployment>
    public var extend: [String: Any]

    public init(
        _ id: Identifier? = nil,
        message: String,
        time: Date,
        deployment: ModelOrIdentifier<Deployment>
    ) {
        self.id = id
        self.message = message
        self.time = time
        self.deployment = deployment
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Log: JSONConvertible {
    public convenience init(json: JSON) throws {
        self.init(
            try json.get("id"),
            message: try json.get("message"),
            time: try json.get("time"),
            deployment: try ModelOrIdentifier(json: json.get("deployment"))
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("message", message)
        try json.set("time", time)
        try json.set("deployment", deployment.makeJSON())
        return json
    }
}

