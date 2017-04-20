public final class ProjectPermission: Extensible, Identifiable {
    public var id: Identifier?
    public let key: String
    public var extend: [String: Any]
    
    public init(
        _ id: Identifier? = nil,
        key: String
        ) {
        self.id = id
        self.key = key
        self.extend = [:]
    }
}

// MARK: Case Groups

extension ProjectPermission {
    public static var allPermissions: [ProjectPermission] {
        return [
            // Project
            .read,
            .update,
            .delete,
            
            // Deployment
            .createDeployment,
            .readDeployment,
            .updateDeployment,
            
            // Application
            .createApplication,
            .readApplication,
            .updateApplication,
            .deleteApplication,
            
            // Meta
            .updatePermission
        ]
    }
}

// MARK: Cases

extension ProjectPermission {
    // Project
    
    public static var read: ProjectPermission {
        return ProjectPermission(key: "projectRead")
    }
    
    public static var update: ProjectPermission {
        return ProjectPermission(key: "projectUpdate")
    }
    
    public static var delete: ProjectPermission {
        return ProjectPermission(key: "projectDelete")
    }
    
    // Deployment
    
    public static var createDeployment: ProjectPermission {
        return ProjectPermission(key: "deploymentCreate")
    }
    
    public static var readDeployment: ProjectPermission {
        return ProjectPermission(key: "deploymentRead")
    }
    
    public static var updateDeployment: ProjectPermission {
        return ProjectPermission(key: "deploymentUpdate")
    }
    
    // Application
    
    public static var createApplication: ProjectPermission {
        return ProjectPermission(key: "applicationCreate")
    }
    
    public static var readApplication: ProjectPermission {
        return ProjectPermission(key: "applicationRead")
    }
    
    public static var updateApplication: ProjectPermission {
        return ProjectPermission(key: "applicationUpdate")
    }
    
    public static var deleteApplication: ProjectPermission {
        return ProjectPermission(key: "applicationDelete")
    }
    
    // Meta
    
    public static var updatePermission: ProjectPermission {
        return ProjectPermission(key: "permissionUpdate")
    }
}

// MARK: Equatable

extension ProjectPermission: Equatable {
    public static func ==(lhs: ProjectPermission, rhs: ProjectPermission) -> Bool {
        return lhs.key == rhs.key
    }
}

// MARK: JSON
import JSON

extension ProjectPermission: JSONConvertible {
    public convenience init(json: JSON) throws {
        self.init(
            try json.get("id"),
            key: try json.get("key")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("key", key)
        return json
    }
}
