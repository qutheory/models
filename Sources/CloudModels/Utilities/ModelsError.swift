/// Errors that can happen when working
/// with models.
public enum ModelsError: Error {
    case noIdentifier
    case noModel
    case unspecified(Error)
}
