import Foundation
import SCrypto

public struct Client {
    let server: String
    let key: String
    let secret: String
    
    public init(server: String, key: String, secret: String) {
        self.server = server
        self.key = key
        self.secret = secret
    }
    
    public func getURL(_ graph: Graph, _ URLString: String, _ format: String? = nil) -> NSURL? {
        guard var components = URLComponents(string: server) else {
            return .none
        }
        
        guard let _URL = NSURL(string: URLString) else {
            return .none
        }
        
        guard _URL.scheme != "data" else {
            return _URL
        }
        
        let input = URLQueryItem(name: "input", value: URLString)
        let verifiedGraph: Graph
        
        if _URL.pathExtension == "gif" {
            verifiedGraph = .noOp
        } else {
            verifiedGraph = graph
        }
        
        components.queryItems = [ input ] + verifiedGraph.queryItems

        guard let query = components.percentEncodedQuery else {
            return .none
        }
        
        let derivedFormat: String?

        if let providedFormat = format {
            derivedFormat = providedFormat
        } else if !(_URL.pathExtension ?? "").isEmpty {
            let pathExtension = _URL.pathExtension
            derivedFormat = pathExtension?.lowercased() == "jpg:large" ? "jpg" : pathExtension
        } else {
            derivedFormat = nil
        }

        let graphNameWithFormat: String

        if let format = derivedFormat {
            graphNameWithFormat = verifiedGraph.pathComponent + "." + format.lowercased()
        } else {
            graphNameWithFormat = verifiedGraph.pathComponent
        }
        
        let token = "\(graphNameWithFormat)?\(query)\(secret)".MD5()
        
        components.path = "/" + ([ "graph", key, token, graphNameWithFormat ]).joined(separator: "/")
        
        return components.url as NSURL?
    }
}
