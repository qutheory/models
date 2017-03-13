import HTTP

extension Page: ResponseRepresentable {
    public func makeResponse() throws -> Response {
        return try makeJSON().makeResponse()
    }
}

extension QueryRepresentable {
    func paginate(for req: Request) throws -> Page<T> {
        let query = try makeQuery()
        let page = req.data["page"]?.int ?? 0
        return try query.paginate(page: page, count: 1)
    }
}

extension QueryRepresentable where T: Filterable {
    func filter(with req: Request) throws -> Query<T> {
        let query = try makeQuery()
        for key in T.filterableKeys {
            if let rawValue = req.data[key.publicKey] as? Node {
                let value = key.valueMap(rawValue)
                try query.filter(key.queryKey, key.comparison, value)
            }
        }
        return query
    }
}
