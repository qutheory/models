public final class OrganizationPermission: Extensible, Identifiable {
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

extension OrganizationPermission {
    public static var allPermissions: [OrganizationPermission] {
        return [
            // Organization
            .read,
            .update,
            .delete,
            
            // Project
            .createProject,
            .adminProject,
            
            // Meta
            .updatePermission
        ]
    }
}

// MARK: Cases

extension OrganizationPermission {
    // Organization
    
    public static var read: OrganizationPermission {
        return OrganizationPermission(key: "organizationRead", name: "" , description: "")
    }
    
    public static var update: OrganizationPermission {
        return OrganizationPermission(key: "organizationUpdate", name: "" , description: "")
    }
    
    public static var delete: OrganizationPermission {
        return OrganizationPermission(key: "organizationDelete", name: "" , description: "")
    }
    
    // Project
    
    public static var createProject: OrganizationPermission {
        return OrganizationPermission(key: "projectCreate", name: "" , description: "")
    }
    
    public static var adminProject: OrganizationPermission {
        return OrganizationPermission(key: "projectAdmin", name: "" , description: "")
    }
    
    // Meta
    
    public static var updatePermission: OrganizationPermission {
        return OrganizationPermission(key: "permissionUpdate", name: "" , description: "")
    }
}

// MARK: Equatable

extension OrganizationPermission: Equatable {
    public static func ==(lhs: OrganizationPermission, rhs: OrganizationPermission) -> Bool {
        return lhs.key == rhs.key
    }
}

// MARK: JSON
import JSON

extension OrganizationPermission: JSONConvertible {
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
extension Array where Iterator.Element == OrganizationPermission {
    public init(keysJSON: JSON) {
        guard let array = keysJSON.array else {
            self = []
            return
        }
        
        let permissions: [OrganizationPermission] = array.flatMap { item in
            guard let string = item.string else {
                return nil
            }
            
            return OrganizationPermission(key: string, name: "" , description: "")
        }
        
        self = permissions
    }
}

extension Array where Iterator.Element: OrganizationPermission {
    public func makeKeysJSON() -> JSON {
        let array: [JSON] = map { permission in
            return JSON(permission.key)
        }
        return JSON(array)
    }
}
