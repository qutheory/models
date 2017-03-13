public protocol Filterable {
    static var filterableKeys: [FilterableKey] { get }
}

import Fluent

public struct FilterableKey {
    public let publicKey: String
    public let queryKey: String
    public let comparison: Filter.Comparison
    public let valueMap: NodeMap

    public typealias NodeMap = (Node) -> Node

    public init(
        key: String,
        comparison: Filter.Comparison = .equals,
        valueMap: @escaping NodeMap = { $0 }
    ) {
        self.publicKey = key
        self.queryKey = key
        self.comparison = comparison
        self.valueMap = valueMap
    }

    public init(
        publicKey: String,
        queryKey: String,
        comparison: Filter.Comparison = .equals,
        valueMap: @escaping NodeMap = { $0 }
    ) {
        self.publicKey = publicKey
        self.queryKey = queryKey
        self.comparison = comparison
        self.valueMap = valueMap
    }
}

extension FilterableKey: ExpressibleByUnicodeScalarLiteral {
    public init(unicodeScalarLiteral value: String) {
        self.init(key: value)
    }
}

extension FilterableKey: ExpressibleByExtendedGraphemeClusterLiteral {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(key: value)
    }
}

extension FilterableKey: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(key: value)
    }
}
