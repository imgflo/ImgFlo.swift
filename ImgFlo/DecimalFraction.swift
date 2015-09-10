public struct DecimalFraction {
    public let value: Double
    
    public init(_ value: Double) {
        let zero: Double = 0
        let one: Double = 1
        
        if value < zero {
            self.value = zero
        } else if value > one {
            self.value = one
        } else {
            self.value = value
        }
    }
}
