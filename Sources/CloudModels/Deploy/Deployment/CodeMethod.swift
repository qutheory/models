extension Deployment {
    public enum CodeMethod {
        case clean
        case incremental
        case update
    }
}


// MARK: JSON
import JSON

extension Deployment.CodeMethod: JSONConvertible {
    public init(json: JSON) throws {
        let method = json.string ?? ""
        switch method {
        case "clean":
            self = .clean
        case "incremental":
            self = .incremental
        case "update":
            self = .update
        default:
            throw NodeError.unableToConvert(
                input: Node(method),
                expectation: "Code Deployment Method",
                path: ["type", "method"]
            )
        }
    }

    public func makeJSON() throws -> JSON {
        let string: String
        switch self {
        case .clean:
            string = "clean"
        case .incremental:
            string = "incremental"
        case .update:
            string = "update"
        }
        return try JSON(node: string)
    }
}
