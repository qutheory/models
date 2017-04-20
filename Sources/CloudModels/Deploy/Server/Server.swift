final class Server: Extensible, Identifiable {
    public var id: Identifier?
    public var name: String
    public var hostname: String
    public var status: Status
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        name: String,
        hostname: String,
        status: Status
    ) {
        self.id = id
        self.name = name
        self.hostname = hostname
        self.status = status
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Server: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            name: json.get("name"),
            hostname: json.get("hostname"),
            status: json.get("status") ?? .free
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("hostname", hostname)
        try json.set("status", status)
        return json
    }
}
