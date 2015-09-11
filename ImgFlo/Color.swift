#if os(iOS)
    import UIKit
    public typealias Color = UIColor
#elseif os(OSX)
    import AppKit
    public typealias Color = NSColor
#endif

extension Color {
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "#%02x%02x%02x", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
}
