public enum ReplicaSize {
    case free
    case hobby
    case small
    case medium
    case large
    case xlarge
}

extension ReplicaSize: NodeConvertible {
    public init(node: Node) throws {
        switch node.string ?? "" {
        case "free":
            self = .free
        case "hobby":
            self = .hobby
        case "small":
            self = .small
        case "medium":
            self = .medium
        case "large":
            self = .large
        case "xlarge":
            self = .xlarge
        default:
            throw NodeError.unableToConvert(
                input: node,
                expectation: "ReplicaSize",
                path: []
            )
        }
    }
    
    public var string: String {
        switch self {
        case .free:
            return "free"
        case .hobby:
            return "hobby"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        case .xlarge:
            return "xlarge"
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return Node(string)
    }
}

extension ReplicaSize {
    public static var all: [ReplicaSize] {
        return [.free, .hobby, .small, .medium, .large, .xlarge]
    }
}

extension ReplicaSize: CustomStringConvertible {
    public var description: String {
        switch self {
        case .free:
            return "Free"
        case .hobby:
            return "Hobby"
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .xlarge:
            return "X-Large"
        }
    }
}

// MARK: Cost

extension ReplicaSize {
    public var cost: Cost {
        let monthly: Double
        
        switch self {
        case .free:
            monthly = 0
        case .hobby:
            monthly = 6.0
        case .small:
            monthly = 29.0
        case .medium:
            monthly = 61.0
        case .large:
            monthly = 222.0
        case .xlarge:
            monthly = 375.0
        }
        
        return Cost(monthly: monthly)
    }
}

