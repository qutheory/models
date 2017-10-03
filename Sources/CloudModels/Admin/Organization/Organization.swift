public final class Organization: Extensible, Identifiable {
    public var id: Identifier?
    public var name: String
    public var credits: Double
    public var wallet: ModelOrIdentifier<Wallet>?
    public var extend: [String: Any]
    public var cost: Cost?

    /// The minimum amount of credits this organization
    /// should have before billing
    public var refillThreshold: Double?
    public var refillCredits: Double?

    public var hasWallet: Bool {
        return wallet != nil
    }

    public init(
        id: Identifier? = nil,
        name: String,
        credits: Double = 0,
        wallet: ModelOrIdentifier<Wallet>?,
        refillThreshold: Double?,
        refillCredits: Double?
    ) {
        self.id = id
        self.name = name
        self.credits = credits
        self.wallet = wallet
        self.refillThreshold = refillThreshold
        self.refillCredits = refillCredits
        self.extend = [:]
    }
}

// MARK: JSON
import JSON

extension Organization: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            name: json.get("name"),
            credits: json.get("credits"),
            wallet: json.get("wallet"),
            refillThreshold: json.get("refillThreshold"),
            refillCredits: json.get("refillCredits")
        )
        cost = try json.get("cost")
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("credits", credits)
        try json.set("cost", cost)
        try json.set("wallet", wallet)
        try json.set("refillThreshold", refillThreshold)
        try json.set("refillCredits", refillCredits)
        return json
    }
}
