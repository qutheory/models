public final class Wallet: Extensible, Identifiable {
    public var id: Identifier?
    public var walletType: WalletType
    public var walletId: Identifier
    public var user: ModelOrIdentifier<User>
    public var name: String
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        walletType: WalletType,
        walletId: Identifier,
        user: ModelOrIdentifier<User>,
        name: String
    ) {
        self.id = id
        self.walletType = walletType
        self.walletId = walletId
        self.user = user
        self.name = name
        self.extend = [:]
    }
}

public enum WalletType: String {
    case stripe
}

// MARK: JSON
import JSON

extension Wallet: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            id: json.get("id"),
            walletType: json.get("walletType"),
            walletId: json.get("walletId"),
            user: json.get("user"),
            name: json.get("name")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("walletType", walletType.rawValue)
        try json.set("walletId", walletId)
        try json.set("user", user)
        try json.set("name", name)
        return json
    }
}
