public final class Domain: Extensible, Identifiable {
    public var id: Identifier?
    public var environment: ModelOrIdentifier<Environment>
    public var domain: String
    public var path: String
    public var certificate: ModelOrIdentifier<Certificate>?
    public var extend: [String: Any]

    public init(
        _ id: Identifier? = nil,
        _ environment: ModelOrIdentifier<Environment>,
        _ certificate: ModelOrIdentifier<Certificate>?,
        domain: String,
        path: String? = nil
    ) {
        self.id = id
        self.environment = environment
        self.certificate = certificate
        self.domain = domain
        self.path = path ?? "/"
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Domain: JSONConvertible {
    public convenience init(json: JSON) throws {
        self.init(
            try json.get("id"),
            try ModelOrIdentifier(json: json.get("environment")),
            try ModelOrIdentifier(json: json.get("certificate")),
            domain: try json.get("domain"),
            path: try json.get("path")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("environment", environment.makeJSON())
        try json.set("certificate", certificate?.makeJSON())
        try json.set("domain", domain)
        try json.set("path", path)
        return json
    }
}
