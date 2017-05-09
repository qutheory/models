import JSON

public struct Cost {
    public var monthly: Double
    public init(monthly: Double) {
        self.monthly = monthly
    }
}

let hoursInMonth = 730.0

extension Cost {
    public var hourly: Double {
        return monthly / hoursInMonth
    }
}

// MARK: JSON

extension Cost: JSONConvertible {
    public init(json: JSON) throws {
        try self.init(monthly: json.get("monthly"))
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("monthly", monthly)
        try json.set("hourly", hourly)
        return json
    }
}

// MARK: Node

extension Cost: NodeConvertible {
    public init(node: Node) throws {
        try self.init(json: JSON(node.wrapped))
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try self.makeJSON().converted()
    }
}
