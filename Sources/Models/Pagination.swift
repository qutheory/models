import Fluent
import JSON

// Represents a page of results for the entity
public struct Page<T: Entity> {
    public let number: Int
    public let data: [T]
    public let size: Int
    public let total: Int

    // The query used must already be filtered for
    // pagination and ready for `.all()` call
    public init(
        number: Int,
        data: [T],
        size: Int = defaultPageSize,
        total: Int
        ) {
        self.number = number > 0 ? number : 1
        self.data = data
        self.size = size
        self.total = total
    }
}

extension Page: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("page.number", number)
        try json.set("page.total", total)
        try json.set("page.size", size)
        let count = total / size
        if number < count {
            try json.set("page.next", number + 1)
        }
        if number > 1 {
            try json.set("page.previous", number - 1)
        }
        try json.set("page.count", count)
        try json.set("data", data)
        return json
    }
}

public var defaultPageSize = 10

extension QueryRepresentable {
    public func paginate(page: Int, count: Int = defaultPageSize) throws -> Page<E> {
        let page = page > 0 ? page : 1
        let query = try makeQuery()
        let total = try query.count()

        query.limit = Limit(count: count, offset: (page - 1) * count)
        let data = try query
            .sort("createdAt", .descending)
            .all()

        return Page(
            number: page,
            data: data,
            size: count,
            total: total
        )
    }
}
