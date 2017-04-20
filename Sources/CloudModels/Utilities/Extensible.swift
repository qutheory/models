/// Allows models to be extended by the 
/// modules that import them.
public protocol Extensible: class {
    var extend: [String: Any] { get set }
}
