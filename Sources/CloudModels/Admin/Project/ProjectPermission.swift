public final class ProjectPermission: Extensible, Identifiable {
    public var id: Identifier?
    public var key: String
    public var name: String
    public var description: String
    public var extend: [String: Any]
    
    public init(
        id: Identifier? = nil,
        key: String,
        name: String,
        description: String
    ) {
        self.id = id
        self.key = key
        self.name = name
        self.description = description
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
        return ProjectPermission(key: "projectRead", name: "" , description: "")
    }
    
    public static var update: ProjectPermission {
        return ProjectPermission(key: "projectUpdate", name: "" , description: "")
    }
    
    public static var delete: ProjectPermission {
        return ProjectPermission(key: "projectDelete", name: "" , description: "")
    }
    
    // Deployment
    
    public static var createDeployment: ProjectPermission {
        return ProjectPermission(key: "deploymentCreate", name: "" , description: "")
    }
    
    public static var readDeployment: ProjectPermission {
        return ProjectPermission(key: "deploymentRead", name: "" , description: "")
    }
    
    public static var updateDeployment: ProjectPermission {
        return ProjectPermission(key: "deploymentUpdate", name: "" , description: "")
    }
    
    // Application
    
    public static var createApplication: ProjectPermission {
        return ProjectPermission(key: "applicationCreate", name: "" , description: "")
    }
    
    public static var readApplication: ProjectPermission {
        return ProjectPermission(key: "applicationRead", name: "" , description: "")
    }
    
    public static var updateApplication: ProjectPermission {
        return ProjectPermission(key: "applicationUpdate", name: "" , description: "")
    }
    
    public static var deleteApplication: ProjectPermission {
        return ProjectPermission(key: "applicationDelete", name: "" , description: "")
    }
    
    // Meta
    
    public static var updatePermission: ProjectPermission {
        return ProjectPermission(key: "permissionUpdate", name: "" , description: "")
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
        try self.init(
            id: json.get("id"),
            key: json.get("key"),
            name: json.get("name"),
            description: json.get("description")
        )
    }
    
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("key", key)
        try json.set("name", name)
        try json.set("description", description)
        return json
    }
}

// MARK: JSON Keys
extension Array where Iterator.Element == ProjectPermission {
    public init(keysJSON: JSON) {
        guard let array = keysJSON.array else {
            self = []
            return
        }
        
        let permissions: [ProjectPermission] = array.flatMap { item in
            guard let string = item.string else {
                return nil
            }
            
            return ProjectPermission(key: string, name: "" , description: "")
        }
        
        self = permissions
    }
}

extension Array where Iterator.Element: ProjectPermission {
    public func makeKeysJSON() -> JSON {
        let array: [JSON] = map { permission in
            return JSON(permission.key)
        }
        return JSON(array)
    }
}
