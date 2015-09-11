import Foundation

public enum Graph {
    case Canvas(width: Int?, height: Int?, color: Color)
    case Crop(width: Int?, height: Int?, cropX: Int, cropY: Int, cropWidth: Int, cropHeight: Int)
    case CustomGrey(width: Int?, height: Int?)
    case DelaunayTriangles(width: Int?, height: Int?, seed: String)
    case Desaturate(width: Int?, height: Int?, grainSize: Int, samples: Int)
    case EnhanceLowRes(width: Int?, height: Int?, iterations: Int)
    case GaussianBlur(width: Int?, height: Int?, stdDevX: Double, stdDevY: Double, abyssPolicy: AbyssPolicy)
    case GradientMap(width: Int?, height: Int?, opacity: DecimalFraction?, srgb: Bool, colorStops: [(Color, DecimalFraction)])
    case HaloDarken(width: Int?, height: Int?, edgeBlurX: Double, edgeBlurY: Double, strength: DecimalFraction)
    case Instagram1977(width: Int?, height: Int?)
    case InstagramBrannan(width: Int?, height: Int?)
    case InstagramHefe(width: Int?, height: Int?)
    case InstagramLordKelvin(width: Int?, height: Int?)
    case InstagramNashville(width: Int?, height: Int?)
    case InstagramXProII(width: Int?, height: Int?)
    case MotionBlur(width: Int?, height: Int?, length: Double, angle: Double, brightness: Double, contrast: Double, strength: DecimalFraction)
    case Passthrough(width: Int?, height: Int?)
    
    var rawValue: String {
        switch self {
        case .Canvas: return "canvas"
        case .Crop: return "crop"
        case .CustomGrey: return "customgrey"
        case .DelaunayTriangles: return "delaunay_triangles"
        case .Desaturate: return "desaturate"
        case .EnhanceLowRes: return "enhancelowres"
        case .GaussianBlur: return "gaussianblur"
        case .GradientMap: return "gradientmap"
        case .HaloDarken: return "halodarken"
        case .Instagram1977: return "insta_1977"
        case .InstagramBrannan: return "insta_brannan"
        case .InstagramHefe: return "insta_hefe"
        case .InstagramLordKelvin: return "insta_lordkelvin"
        case .InstagramNashville: return "insta_nashville"
        case .InstagramXProII: return "insta_xproii"
        case .MotionBlur: return "motionblur"
        case .Passthrough: return "passthrough"
        }
    }
    
    var queryItems: [NSURLQueryItem] {
        let params: [String: AnyObject?]
        
        switch self {
        case let Canvas(width, height, color):
            params = [
                "width": width,
                "height": height,
                "color": color.toHexString()
            ]
        case let Crop(width, height, cropX, cropY, cropWidth, cropHeight):
            params = [
                "width": width,
                "height": height,
                "x": cropX,
                "y": cropY,
                "cropwidth": cropWidth,
                "cropheight": cropHeight
            ]
        case let CustomGrey(width, height):
            params = [
                "width": width,
                "height": height
            ]
        case let DelaunayTriangles(width, height, seed):
            params = [
                "width": width,
                "height": height,
                "seed": seed
            ]
        case let Desaturate(width, height, grainSize, samples):
            params = [
                "width": width,
                "height": height,
                "grainsize": grainSize,
                "samples": samples
            ]
        case let EnhanceLowRes(width, height, iterations):
            params = [
                "width": width,
                "height": height,
                "iterations": iterations
            ]
        case let GaussianBlur(width, height, stdDevX, stdDevY, abyssPolicy):
            params = [
                "width": width,
                "height": height,
                "std-dev-x": stdDevX,
                "std-dev-y": stdDevY,
                "abyss-policy": abyssPolicy.rawValue
            ]
        case let GradientMap(width, height, opacity, srgb, colorStops):
            let initialParams: [String: AnyObject?] = [
                "width": width,
                "height": height,
                "opacity": opacity?.value,
                "srgb": srgb ? "true" : "false"
            ]
            
            let colorStopParams: Array<[String: AnyObject?]> = Array(colorStops.enumerate()).map { index, element in
                return [
                    "color\(index + 1)": element.0.toHexString(),
                    "stop\(index + 1)": element.1.value
                ]
            }

            params = colorStopParams.reduce(initialParams, combine: +)
        case let HaloDarken(width, height, edgeBlurX, edgeBlurY, strength):
            params = [
                "width": width,
                "height": height,
                "edgeblur-x": edgeBlurX,
                "edgeblur-y": edgeBlurY,
                "strength": strength.value
            ]
        case let Instagram1977(width, height):
            params = [
                "width": width,
                "height": height
            ]
        case let InstagramBrannan(width, height):
            params = [
                "width": width,
                "height": height
            ]
        case let InstagramHefe(width, height):
            params = [
                "width": width,
                "height": height
            ]
        case let InstagramLordKelvin(width, height):
            params = [
                "width": width,
                "height": height
            ]
        case let InstagramNashville(width, height):
            params = [
                "width": width,
                "height": height
            ]
        case let InstagramXProII(width, height):
            params = [
                "width": width,
                "height": height
            ]
        case let MotionBlur(width, height, length, angle, brightness, contrast, strength):
            params = [
                "width": width,
                "height": height,
                "length": length,
                "angle": angle,
                "brightness": brightness,
                "contrast": contrast,
                "strength": strength.value
            ]
        case let .Passthrough(width, height):
            params = [
                "width": width,
                "height": height
            ]
        }
        
        let reducedParams = params.reduce([NSURLQueryItem]()) { accum, elem in
            if let value: AnyObject = elem.1 {
                return accum  + [ NSURLQueryItem(name: elem.0, value: "\(value)") ]
            } else {
                return accum
            }
        }
        
        return reducedParams.sort { $0.name < $1.name }
    }
}

private func + <T, V>(var lhs: [T: V], rhs: [T: V]) -> [T: V] {
    for (key, val) in rhs {
        lhs[key] = val
    }
    
    return lhs
}
