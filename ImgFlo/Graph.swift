import Foundation

public enum Graph {
    case canvas(width: Int?, height: Int?, color: Color)
    case crop(width: Int?, height: Int?, cropX: Int, cropY: Int, cropWidth: Int, cropHeight: Int)
    case customGrey(width: Int?, height: Int?)
    case delaunayTriangles(width: Int?, height: Int?, seed: String)
    case desaturate(width: Int?, height: Int?, grainSize: Int, samples: Int)
    case enhanceLowRes(width: Int?, height: Int?, iterations: Int)
    case gaussianBlur(width: Int?, height: Int?, stdDevX: Double, stdDevY: Double, abyssPolicy: AbyssPolicy)
    case gradientMap(width: Int?, height: Int?, opacity: DecimalFraction?, srgb: Bool, colorStops: [(Color, DecimalFraction)])
    case haloDarken(width: Int?, height: Int?, edgeBlurX: Double, edgeBlurY: Double, strength: DecimalFraction)
    case instagram1977(width: Int?, height: Int?)
    case instagramBrannan(width: Int?, height: Int?)
    case instagramHefe(width: Int?, height: Int?)
    case instagramLordKelvin(width: Int?, height: Int?)
    case instagramNashville(width: Int?, height: Int?)
    case instagramXProII(width: Int?, height: Int?)
    case motionBlur(width: Int?, height: Int?, length: Double, angle: Double, brightness: Double, contrast: Double, strength: DecimalFraction)
    case noOp
    case passthrough(width: Int?, height: Int?)
    
    var pathComponent: String {
        switch self {
        case .canvas: return "canvas"
        case .crop: return "crop"
        case .customGrey: return "customgrey"
        case .delaunayTriangles: return "delaunay_triangles"
        case .desaturate: return "desaturate"
        case .enhanceLowRes: return "enhancelowres"
        case .gaussianBlur: return "gaussianblur"
        case .gradientMap: return "gradientmap"
        case .haloDarken: return "halodarken"
        case .instagram1977: return "insta_1977"
        case .instagramBrannan: return "insta_brannan"
        case .instagramHefe: return "insta_hefe"
        case .instagramLordKelvin: return "insta_lordkelvin"
        case .instagramNashville: return "insta_nashville"
        case .instagramXProII: return "insta_xproii"
        case .motionBlur: return "motionblur"
        case .noOp: return "noop"
        case .passthrough: return "passthrough"
        }
    }
    
    var queryItems: [URLQueryItem] {
        let params: [String: AnyObject?]
        
        switch self {
        case let .canvas(width, height, color):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "color": color.toHexString() as Optional<AnyObject>
            ]
        case let .crop(width, height, cropX, cropY, cropWidth, cropHeight):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "x": cropX as Optional<AnyObject>,
                "y": cropY as Optional<AnyObject>,
                "cropwidth": cropWidth as Optional<AnyObject>,
                "cropheight": cropHeight as Optional<AnyObject>
            ]
        case let .customGrey(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        case let .delaunayTriangles(width, height, seed):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "seed": seed as Optional<AnyObject>
            ]
        case let .desaturate(width, height, grainSize, samples):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "grainsize": grainSize as Optional<AnyObject>,
                "samples": samples as Optional<AnyObject>
            ]
        case let .enhanceLowRes(width, height, iterations):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "iterations": iterations as Optional<AnyObject>
            ]
        case let .gaussianBlur(width, height, stdDevX, stdDevY, abyssPolicy):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "std-dev-x": stdDevX as Optional<AnyObject>,
                "std-dev-y": stdDevY as Optional<AnyObject>,
                "abyss-policy": abyssPolicy.rawValue as Optional<AnyObject>
            ]
        case let .gradientMap(width, height, opacity, srgb, colorStops):
            let initialParams: [String: AnyObject?] = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "opacity": opacity?.value as Optional<AnyObject>,
                "srgb": srgb ? "true" as Optional<AnyObject> : "false" as Optional<AnyObject>
            ]

            let colorStopParams : Array<[String : AnyObject?]> = Array(colorStops.enumerated()).map
                { index, element in
                    return [
                        "color\(index + 1)": element.0.toHexString() as Optional<AnyObject>,
                        "stop\(index + 1)": element.1.value as Optional<AnyObject>
                    ]
                }


            params = colorStopParams.reduce(initialParams, +)
        case let .haloDarken(width, height, edgeBlurX, edgeBlurY, strength):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "edgeblur-x": edgeBlurX as Optional<AnyObject>,
                "edgeblur-y": edgeBlurY as Optional<AnyObject>,
                "strength": strength.value as Optional<AnyObject>
            ]
        case let .instagram1977(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        case let .instagramBrannan(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        case let .instagramHefe(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        case let .instagramLordKelvin(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        case let .instagramNashville(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        case let .instagramXProII(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        case let .motionBlur(width, height, length, angle, brightness, contrast, strength):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>,
                "length": length as Optional<AnyObject>,
                "angle": angle as Optional<AnyObject>,
                "brightness": brightness as Optional<AnyObject>,
                "contrast": contrast as Optional<AnyObject>,
                "strength": strength.value as Optional<AnyObject>
            ]
        case .noOp:
            params = [:]
        case let .passthrough(width, height):
            params = [
                "width": width as Optional<AnyObject>,
                "height": height as Optional<AnyObject>
            ]
        }
        
        let reducedParams = params.reduce([URLQueryItem]()) { accum, elem in
            guard let value: AnyObject = elem.1 else { return accum }
            return accum  + [ URLQueryItem(name: elem.0, value: "\(value)") ]
        }
        
        return reducedParams.sorted { $0.name < $1.name }
    }
}

private func + <T, V>(lhs: [T: V], rhs: [T: V]) -> [T: V] {
    var _lhs = lhs
    for (key, val) in rhs {
        _lhs[key] = val
    }
    
    return _lhs
}
