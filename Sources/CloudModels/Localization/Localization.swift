public final class Localization: Extensible, Identifiable {
    public var id: Identifier?
    public var application: ModelOrIdentifier<Application>
    public var isProduction: Bool
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        application: ModelOrIdentifier<Application>,
        isProduction: Bool
    ) {
        self.id = id
        self.application = application
        self.isProduction = isProduction
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Localization: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            application: ModelOrIdentifier(json: json.get("application")),
            isProduction: json.get("isProduction")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("application", application.makeJSON())
        try json.set("isProduction", isProduction)
        return json
    }
}
