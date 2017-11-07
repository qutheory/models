extension Deployment {
    public enum Method {
        case code(CodeMethod)
        case scale
        case resize
        case domain
    }
}

// MARK: JSON
import JSON

extension Deployment.Method: JSONConvertible {
    public init(json: JSON) throws {
        let name: String = try json.get("name")
        switch name {
        case "code":
            let method = try Deployment.CodeMethod(json: json.get("method"))
            self = .code(method)
        case "scale":
            self = .scale
        case "domain":
            self = .domain
        case "resize":
	        self = .resize
        default:
            throw NodeError.unableToConvert(
                input: Node(name),
                expectation: "Deployment Method",
                path: ["type", "name"]
            )
        }
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        switch self {
        case .code(let method):
            try json.set("name", "code")
            try json.set("method", method.makeJSON())
        case .scale:
            try json.set("name", "scale")
        case .resize:
            try json.set("name", "resize")
        case .domain:
            try json.set("name", "domain")
        }
        return json
    }
}
