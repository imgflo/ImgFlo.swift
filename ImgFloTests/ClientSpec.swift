#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

import ImgFlo
import Nimble
import Quick

class ClientSpec: QuickSpec {
    override func spec() {
        let imgflo = ImgFlo.Client(
            server: "https://imgflo.herokuapp.com",
            key: "key",
            secret: "secret"
        )
        
        describe("getting a URL") {
        
            context("without specifying an image format") {
                it("should correctly infer the format") {
                    let color1 = Color.redColor()
                    let stop1 = DecimalFraction(0.17)
                    
                    let color2 = Color.orangeColor()
                    let stop2 = DecimalFraction(0.33)
                    
                    let color3 = Color.yellowColor()
                    let stop3 = DecimalFraction(0.5)
                    
                    let color4 = Color.greenColor()
                    let stop4 = DecimalFraction(0.66)
                    
                    let color5 = Color.blueColor()
                    let stop5 = DecimalFraction(0.83)
                    
                    let graph: Graph = .GradientMap(width: nil, height: nil, opacity: nil, srgb: true, colorStops: [
                        (color1, stop1), (color2, stop2), (color3, stop3), (color4, stop4), (color5, stop5)
                    ])
                    
                    let input = "https://pbs.twimg.com/media/BlM0d2-CcAAT9ic.jpg:large"
                    let URL = imgflo.getURL(graph, input)
                    
                    let expected = "https://imgflo.herokuapp.com/graph/key/7df11ca4fa37885489023ab263529f57/gradientmap.jpg?input=https://pbs.twimg.com/media/BlM0d2-CcAAT9ic.jpg:large&color1=%23ff0000&stop4=0.66&color4=%2300ff00&color5=%230000ff&srgb=true&stop2=0.33&stop1=0.17&color3=%23ffff00&stop3=0.5&stop5=0.83&color2=%23ff7f00"
                    
                    expect(URL?.absoluteString).to(equal(expected))
                }
            }
            
            context("from a URL with query parameters") {
                it("should correctly encode the URL") {
                    let graph: Graph = .Passthrough(width: nil, height: nil)
                    let input = "https://v.cdn.vine.co/r/videos/B5B06468B91176403722801139712_342c9a1c624.1.5.15775156368984795444.mp4.jpg?versionId=edU_LrAtIFsGvZj.Fgi0Si1bem68tBlk"
                    let URL = imgflo.getURL(graph, input, "jpg")
                    
                    let expected = "https://imgflo.herokuapp.com/graph/key/5e22d0acfe825908dec852c78c80fb7a/passthrough.jpg?input=https://v.cdn.vine.co/r/videos/B5B06468B91176403722801139712_342c9a1c624.1.5.15775156368984795444.mp4.jpg?versionId%3DedU_LrAtIFsGvZj.Fgi0Si1bem68tBlk"
                    
                    expect(URL?.absoluteString).to(equal(expected))
                }
            }
            
            context("from a URL with an uppercase extension without specifying an image format") {
                it("should represent the inferred format as a lowercase string") {
                    let graph: Graph = .Passthrough(width: nil, height: nil)
                    let input = "http://1.bp.blogspot.com/-1h8jX1lfGJc/UnlTZ3Fsq6I/AAAAAAAAAOo/dw7IXnJBO5A/s1600/IMG_1722.JPG"
                    let URL = imgflo.getURL(graph, input)
                    
                    let expected = "https://imgflo.herokuapp.com/graph/key/f5026fddecf914fefb4caafe52ca9e6c/passthrough.jpg?input=http://1.bp.blogspot.com/-1h8jX1lfGJc/UnlTZ3Fsq6I/AAAAAAAAAOo/dw7IXnJBO5A/s1600/IMG_1722.JPG"
                    
                    expect(URL?.absoluteString).to(equal(expected))
                }
            }
            
            context("from a URL without an extension") {
                it("should omit the format") {
                    let color1 = Color(red: 10 / 255, green: 42 / 255, blue: 47 / 255, alpha: 1)
                    let stop1 = DecimalFraction(0)
                    
                    let color2 = Color(red: 253 / 255, green: 231 / 255, blue: 160 / 255, alpha: 1)
                    let stop2 = DecimalFraction(1)
                    
                    let graph: Graph = .GradientMap(width: nil, height: nil, opacity: nil, srgb: true, colorStops: [
                        (color1, stop1), (color2, stop2)
                    ])
                    
                    let input = "https://lh6.ggpht.com/qhLc1KUYP3YpNUtf9MujZVld1ctgsU0_oEEqp6Jkte8hW1UNJqKSm9-ExP-uzyL3r2c=h556"
                    let URL = imgflo.getURL(graph, input)
                    
                    let expected = "https://imgflo.herokuapp.com/graph/key/2e7d1b8df004032d6e29783f0f43e790/gradientmap?input=https://lh6.ggpht.com/qhLc1KUYP3YpNUtf9MujZVld1ctgsU0_oEEqp6Jkte8hW1UNJqKSm9-ExP-uzyL3r2c%3Dh556&color1=%230a2a2f&srgb=true&stop2=1&stop1=0&color2=%23fde7a0"
                    
                    expect(URL?.absoluteString).to(equal(expected))
                }
            }
            
            context("specifying an image format") {
                it("should include the specified format") {
                    let color1 = Color.redColor()
                    let stop1 = DecimalFraction(0.17)
                    
                    let color2 = Color.orangeColor()
                    let stop2 = DecimalFraction(0.33)
                    
                    let color3 = Color.yellowColor()
                    let stop3 = DecimalFraction(0.5)
                    
                    let color4 = Color.greenColor()
                    let stop4 = DecimalFraction(0.66)
                    
                    let color5 = Color.blueColor()
                    let stop5 = DecimalFraction(0.83)
                    
                    let graph: Graph = .GradientMap(width: nil, height: nil, opacity: nil, srgb: true, colorStops: [
                        (color1, stop1), (color2, stop2), (color3, stop3), (color4, stop4), (color5, stop5)
                    ])
                    
                    let input = "https://pbs.twimg.com/media/BlM0d2-CcAAT9ic.jpg:large"
                    let URL = imgflo.getURL(graph, input, "png")
                    
                    let expected = "https://imgflo.herokuapp.com/graph/key/6867ef481a315713663753147aa1b01d/gradientmap.png?input=https://pbs.twimg.com/media/BlM0d2-CcAAT9ic.jpg:large&color1=%23ff0000&stop4=0.66&color4=%2300ff00&color5=%230000ff&srgb=true&stop2=0.33&stop1=0.17&color3=%23ffff00&stop3=0.5&stop5=0.83&color2=%23ff7f00"
                    
                    expect(URL?.absoluteString).to(equal(expected))
                }
            }
            
            context("with a .gif extension") {
                it("should return the original URL") {
                    let graph: Graph = .Passthrough(width: 720, height: nil)
                    let input = "http://www.reactiongifs.com/wp-content/uploads/2013/11/I-have-no-idea-what-I-am-doing.gif"
                    let URL = imgflo.getURL(graph, input)
                    
                    expect(URL?.absoluteString).to(equal(input))
                }
            }
            
            context("with a data: scheme") {
                it("should return the original URL") {
                    let graph: Graph = .Passthrough(width: 720, height: nil)
                    let input = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAABAAEDAREAAhEBAxEB/8QAFAABAAAAAAAAAAAAAAAAAAAACv/EABQQAQAAAAAAAAAAAAAAAAAAAAD/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8AWAD/2Q=="
                    let URL = imgflo.getURL(graph, input)
                    
                    expect(URL?.absoluteString).to(equal(input))
                }
            }
        }
    }
}
