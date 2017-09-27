public final class Wallet: Extensible, Identifiable {
    public var id: Identifier?
    public var walletType: WalletType
    public var walletId: Identifier
    public var extend: [String: Any]

    public init(
        id: Identifier? = nil,
        walletType: WalletType,
        walletId: Identifier
    ) {
        self.id = id
        self.walletType = walletType
        self.walletId = walletId
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
            walletId: json.get("walletId")
        )
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("walletType", walletType.rawValue)
        try json.set("walletId", walletId)
        return json
    }
}
