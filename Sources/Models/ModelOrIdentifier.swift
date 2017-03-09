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
    case identifier(Identifier)
    case model(Model)
}

extension ModelOrIdentifier {
    /// Returns the id if the id is wrapped 
    /// or if the wrapped model has an identifier.
    public func getIdentifier() -> Identifier? {
        switch self {
        case .identifier(let id):
            return id
        case .model(let model):
            return model.id
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
    public func assertIdentifier() throws -> Identifier {
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

// MARK: JSON
import JSON

extension ModelOrIdentifier where Model: JSONConvertible {
    public func makeJSON(idKey: String = "id") throws -> JSON {
        let json: JSON
        switch self {
        case .identifier(let id):
            json = try JSON(node: [idKey: id])
        case .model(let model):
            json = try model.makeJSON()
        }
        return json
    }
}

extension ModelOrIdentifier where Model: JSONInitializable {
    public init(json: JSON, idKey: String = "id") throws {
        do {
            let model = try Model(json: json)
            self = .model(model)
        } catch {
            let id = try json.get(idKey) as Identifier
            self = .identifier(id)
        }
    }
}

