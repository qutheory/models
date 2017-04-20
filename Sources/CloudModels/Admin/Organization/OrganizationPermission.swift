public final class OrganizationPermission: Extensible, Identifiable {
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

extension OrganizationPermission {
    public static var allPermissions: [OrganizationPermission] {
        return [
            // Organization
            .read,
            .update,
            .delete,
            
            // Project
            .createProject,
            
            // Meta
            .updatePermission
        ]
    }
}

// MARK: Cases

extension OrganizationPermission {
    // Organization
    
    public static var read: OrganizationPermission {
        return OrganizationPermission(key: "organizationRead")
    }
    
    public static var update: OrganizationPermission {
        return OrganizationPermission(key: "organizationUpdate")
    }
    
    public static var delete: OrganizationPermission {
        return OrganizationPermission(key: "organizationDelete")
    }
    
    // Project
    
    public static var createProject: OrganizationPermission {
        return OrganizationPermission(key: "projectCreate")
    }
    
    // Meta
    
    public static var updatePermission: OrganizationPermission {
        return OrganizationPermission(key: "permissionUpdate")
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
