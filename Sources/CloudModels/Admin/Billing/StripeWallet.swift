public final class StripeWallet: Identifiable, Extensible {
    public var id: Identifier?
    public var customerId: String
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        customerId: String
    ) {
        self.id = id
        self.customerId = customerId
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension StripeWallet: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            customerId: json.get("customerId")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("customerId", customerId)
        return json
    }
}
