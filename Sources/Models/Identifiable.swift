/// Models conforming to this can be identified
/// by some optional Node identifier.
public protocol Identifiable {
    var id: Identifier? { get set }
}

extension Identifiable {
    /// Returns the identifier of this model
    /// or throws a `ModelsError.noIdentifier`
    public func assertIdentifier() throws -> Identifier {
        guard let i = self.id else {
            throw ModelsError.noIdentifier
        }
        return i
    }
}

extension Identifier: CustomStringConvertible {
    public var description: String {
        return string ?? ""
    }
}
