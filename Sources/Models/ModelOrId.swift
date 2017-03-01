/// Holds either a wrapped Model or an identifier Node.
/// Use this for models that can optionally contain full 
/// models or just their ids.
///
/// For example, when creating an instance of a model, it 
/// my be necessary to include the identifier of a related model 
///
/// POST /pets
/// { 
///     "name": "Spud", 
///     "type": "dog" 
///     "owner": { "id": 42 }
/// }
///
/// Here the `Pet` model should have an id for `Owner`, but all of the
/// other properties are not available. Instead of making all of the properties
/// optional on the Owner model, use the `ModelOrId` enum to wrap.
public enum ModelOrIdentifier<Model: Identifiable> {
    case identifier(Node)
    case model(Model)
}

extension ModelOrIdentifier {
    /// Returns the id if the id is wrapped 
    /// or if the wrapped model has an identifier.
    public func getIdentifier() -> Node? {
        switch self {
        case .identifier(let id):
            return id
        case .model(let model):
            return model.identifier
        }
    }

    /// Returns the model if that is what is 
    /// wrapped. Returns nil if an id is wrapped.
    public func getModel() -> Model? {
        switch self {
        case .identifier:
            return nil
        case .model(let model):
            return model
        }
    }
}

extension ModelOrIdentifier {
    /// Returns an identifier or throws `ModelsError.noIdentifier`
    public func assertId() throws -> Node {
        guard let i = getIdentifier() else {
            throw ModelsError.noIdentifier
        }
        return i
    }

    /// Returns the model or throws `ModelsError.noModel`
    public func assertModel() throws -> Model {
        guard let m = getModel() else {
            throw ModelsError.noModel
        }
        return m
    }
}
