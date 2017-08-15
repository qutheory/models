public final class Transaction: Extensible {
    public var id: Identifier?
    public var organizationId: Identifier
    public var amount: Double
    public var preBalance: Double
    public var postBalance: Double

    // filter transactions
    public var service: Service
    public var environmentId: Identifier?
    public var hostingId: Identifier?
    public var applicationId: Identifier?
    public var projectId: Identifier?
    public var createdAt: Date?
    public var extend: [String: Any]

    public init(
        organizationId: Identifier,
        amount: Double,
        preBalance: Double,
        postBalance: Double,
        service: Service,
        environmentId: Identifier?,
        hostingId: Identifier?,
        applicationId: Identifier?,
        projectId: Identifier?
    ) {
        self.organizationId = organizationId
        self.amount = amount
        self.preBalance = preBalance
        self.postBalance = postBalance
        self.service = service
        self.environmentId = environmentId
        self.hostingId = hostingId
        self.applicationId = applicationId
        self.projectId = projectId
        self.extend = [:]
    }
}

// MARK: JSON

import JSON

extension Transaction: JSONConvertible {
    public convenience init(json: JSON) throws {
        try self.init(
            organizationId: json.get("organizationId"),
            amount: json.get("amount"),
            preBalance: json.get("preBalance"),
            postBalance: json.get("postBalance"),
            service: json.get("service"),
            environmentId: json.get("environmentId"),
            hostingId: json.get("hostingId"),
            applicationId: json.get("applicationId"),
            projectId: json.get("projectId")
        )
        id = try json.get("id")
        createdAt = try json.get("createdAt")
    }

    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("organizationId", organizationId)
        try json.set("amount", amount)
        try json.set("preBalance", preBalance)
        try json.set("postBalance", postBalance)
        try json.set("service", service)
        try json.set("environmentId", environmentId)
        try json.set("hostingId", hostingId)
        try json.set("applicationId", applicationId)
        try json.set("projectId", projectId)
        try json.set("createdAt", createdAt)
        return json
    }
}
