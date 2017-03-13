import Fluent
import JSON

// Represents a page of results for the entity
public struct Page<T: Entity> {
    public let query: Query<T>
    public let number: Int

    // The query used must already be filtered for
    // pagination and ready for `.all()` call
    public init(_ query: Query<T>, number: Int) {
        self.query = query
        self.number = number
    }
}

extension Page: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        var json = JSON()
        // current page number
        try json.set("page.number", number + 1) // start at 1

        // get total number
        let total = try T.query().count()
        try json.set("page.total", total)

        // get page size and total pages
        if let size = query.limit?.count {
            try json.set("page.size", size)
            try json.set("page.count", total / size)
        }

        // get data
        let data = try query.all()
        try json.set("data", data)

        return json
    }
}

public var defaultPageCount = 10

extension QueryRepresentable where T: JSONConvertible {
    public func paginate(page: Int, count: Int = defaultPageCount) throws -> Page<T> {
        let query = try makeQuery()
            .sort("createdAt", .descending)
        query.limit = Limit(count: count, offset: page * count)

        return Page(query, number: page)
    }
}
