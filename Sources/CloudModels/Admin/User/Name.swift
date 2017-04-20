public struct Name {
    public let first: String
    public let last: String
    public var full: String {
        return "\(first) \(last)"
    }

    public init(first: String, last: String) {
        self.first = first
        self.last = last
    }
}

// MARK: JSON
import JSON

extension Name: JSONInitializable {
    public init(json: JSON) throws {
        first = try json.get("first")
        last = try json.get("last")
    }
}

extension Name: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("first", first)
        try json.set("last", last)
        try json.set("full", full)
        return json
    }
}
