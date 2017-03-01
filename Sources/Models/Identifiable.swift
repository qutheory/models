/// Models conforming to this can be identified
/// by some optional Node identifier.
public protocol Identifiable {
    var identifier: Node? { get }
}

extension Identifiable {
    /// Returns the identifier of this model
    /// or throws a `ModelsError.noIdentifier`
    public func assertIdentifier() throws -> Node {
        guard let i = self.identifier else {
            throw ModelsError.noIdentifier
        }
        return i
    }
}
