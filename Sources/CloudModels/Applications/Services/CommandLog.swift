public final class CommandLog: Extensible, Identifiable {
    public var id: Identifier?
    public var environment: ModelOrIdentifier<Environment>
    public var command: String
    public var start: Date
    public var end: Date
    public var exitStatus: CommandExitStatus
    public var log: String
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        environment: ModelOrIdentifier<Environment>,
        command: String,
        start: Date,
        end: Date,
        exitStatus: CommandExitStatus = .success,
        log: String
    ) {
        self.id = id
        self.environment = environment
        self.command = command
        self.start = start
        self.end = end
        self.exitStatus = exitStatus
        self.log = log
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension CommandLog: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            environment: json.get("environment"),
            command: json.get("command"),
            start: json.get("start"),
            end: json.get("end"),
            exitStatus: json.get("exitStatus"),
            log: json.get("log")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("environment", environment)
        try json.set("command", command)
        try json.set("start", start)
        try json.set("end", end)
        try json.set("exitStatus", exitStatus)
        try json.set("log", log)
        return json
    }
}
