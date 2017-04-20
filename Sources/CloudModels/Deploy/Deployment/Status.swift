extension Deployment {
    public enum Status {
        case queued
        case working
        case error
        case success
    }
}

// MARK: JSON
import JSON

extension Deployment.Status: NodeConvertible {
    public init(node: Node) throws {
        switch node.string ?? "" {
        case "queued":
            self = .queued
        case "error":
            self = .error
        case "success":
            self = .success
        case "working":
            self = .working
        default:
            throw NodeError.unableToConvert(
                input: node,
                expectation: "Deployment Status",
                path: ["status"]
            )
        }
    }

    public func makeNode(in context: Context?) throws -> Node {
        switch self {
        case .queued:
            return "queued"
        case .error:
            return "error"
        case .success:
            return "success"
        case .working:
            return "working"
        }
    }
}
