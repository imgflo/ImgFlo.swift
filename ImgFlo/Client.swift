import Crypto
import Foundation

public struct Client {
    let server: String
    let key: String
    let secret: String
    
    public init(server: String, key: String, secret: String) {
        self.server = server
        self.key = key
        self.secret = secret
    }
    
    public func getURL(graph: Graph, _ URLString: String, _ format: String? = nil) -> NSURL? {
        guard let components = NSURLComponents(string: server) else {
            return .None
        }
        
        let input = NSURLQueryItem(name: "input", value: URLString)
        components.queryItems = [ input ] + graph.queryItems
        
        guard let query = components.percentEncodedQuery else {
            return .None
        }
        
        let derivedFormat: String?

        if let providedFormat = format {
            derivedFormat = providedFormat
        } else if let pathExtension = NSURL(string: URLString)?.pathExtension where !pathExtension.isEmpty {
            derivedFormat = pathExtension.lowercaseString == "jpg:large" ? "jpg" : pathExtension
        } else {
            derivedFormat = nil
        }

        let graphNameWithFormat: String

        if let format = derivedFormat {
            graphNameWithFormat = graph.rawValue + "." + format.lowercaseString
        } else {
            graphNameWithFormat = graph.rawValue
        }
        
        guard let token = "\(graphNameWithFormat)?\(query)\(secret)".MD5 else {
            return .None
        }
        
        components.path = "/" + ([ "graph", key, token, graphNameWithFormat ]).joinWithSeparator("/")
        
        return components.URL
    }
}
