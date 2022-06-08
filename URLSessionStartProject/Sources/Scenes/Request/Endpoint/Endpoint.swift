import Foundation

public class Endpoint {
    public var method: RESTClient.RequestType { fatalError() }
    public var path: String { fatalError() }
    public var httpHeaders: [String: String] {
        switch method {
        case .get:
            return ["Cache-Control": "no-cache"]
            
        case .post, .put:
            return ["Content-Type": "application/json",
                    "Accept": "application/json",
                    "Cache-Control": "no-cache"]
        }
    }

    public var parameters: [String: Any]?
    public var timeout: TimeInterval?
    public var queryItems: [URLQueryItem]?
}

public class ObjectResponseEndpoint<T: Decodable>: Endpoint { }

public class EmptyResponseEndpoint: Endpoint { }
