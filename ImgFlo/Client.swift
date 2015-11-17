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
        if let components = NSURLComponents(string: server), URL = NSURL(string: URLString) {
            let scheme = URL.scheme
            let pathExtension = URL.lastPathComponent?.pathExtension
            
            if let scheme = URL.scheme where scheme == "data" {
                return URL
            }
            
            let input = NSURLQueryItem(name: "input", value: URLString)
            
            let verifiedGraph: Graph
            
            if let pathExtension = pathExtension where pathExtension == "gif" {
                verifiedGraph = .NoOp
            } else {
                verifiedGraph = graph
            }
            
            components.queryItems = [ input ] + verifiedGraph.queryItems
        
            if let query = components.percentEncodedQuery {
                let derivedFormat: String?

                if let providedFormat = format {
                    derivedFormat = providedFormat
                } else if let pathExtension = URL.lastPathComponent?.pathExtension where !pathExtension.isEmpty {
                    derivedFormat = pathExtension.lowercaseString == "jpg:large" ? "jpg" : pathExtension
                } else {
                    derivedFormat = nil
                }
                
                let graphNameWithFormat: String
                
                if let format = derivedFormat {
                    graphNameWithFormat = verifiedGraph.pathComponent + "." + format.lowercaseString
                } else {
                    graphNameWithFormat = verifiedGraph.pathComponent
                }
                
                let token = "\(graphNameWithFormat)?\(query)\(secret)".MD5 as String
                components.path = "/" + "/".join([ "graph", key, token, graphNameWithFormat ])
            } else {
                return .None
            }
            
            return components.URL
        } else {
            return .None
        }
    }
}
