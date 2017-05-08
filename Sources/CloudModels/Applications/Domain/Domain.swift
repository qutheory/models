public final class Domain: Extensible, Identifiable {
    public var id: Identifier?
    public var environment: ModelOrIdentifier<Environment>
    public var domain: String
    public var path: String
    public var certificate: ModelOrIdentifier<Certificate>?
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        environment: ModelOrIdentifier<Environment>,
        certificate: ModelOrIdentifier<Certificate>?,
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
        try self.init(
            id: json.get("id"),
            environment: ModelOrIdentifier(json: json.get("environment")),
            certificate: ModelOrIdentifier(json: json.get("certificate")),
            domain: json.get("domain"),
            path: json.get("path")
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
