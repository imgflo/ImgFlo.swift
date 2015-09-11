import ImgFlo
import Nimble
import Quick

class DecimalFractionSpec: QuickSpec {
    override func spec() {
        context("with a number less than zero") {
            it("should produce zero") {
                expect(DecimalFraction(-0.1).value).to(equal(0))
            }
        }
        
        context("with zero") {
            it("should produce zero") {
                expect(DecimalFraction(0).value).to(equal(0))
            }
        }
        
        context("with a number between zero and one") {
            it("should produce zero") {
                expect(DecimalFraction(0.5).value).to(equal(0.5))
            }
        }
        
        context("with one") {
            it("should produce one") {
                expect(DecimalFraction(1).value).to(equal(1))
            }
        }
        
        context("with a number greater than one") {
            it("should produce one") {
                expect(DecimalFraction(1.1).value).to(equal(1))
            }
        }
    }
}
