public enum CommandExitStatus {
    case success
    case error
}

extension CommandExitStatus: NodeConvertible {
    public init(node: Node) throws {
        switch node.string ?? "" {
        case "success":
            self = .success
        case "error":
            self = .error
        default:
            throw NodeError.unableToConvert(
                input: node,
                expectation: "Command Exit Status",
                path: []
            )
        }
    }

    public func makeNode(in context: Context?) throws -> Node {
        switch self {
        case .error:
            return "error"
        case .success:
            return "success"
        }
    }
}
