extension Server {
    public enum Status {
        case busy
        case free
    }
}

extension Server.Status: NodeConvertible {
    public init(node: Node) throws {
        switch node.string ?? "" {
        case "busy":
            self = .busy
        case "free":
            self = .free
        default:
            throw NodeError.unableToConvert(
                input: node,
                expectation: "Server.Status",
                path: ["server.status"]
            )
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        switch self {
        case .busy:
            return "busy"
        case .free:
            return "free"
        }
    }
}
