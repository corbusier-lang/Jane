import XCTest
@testable import Jane
@testable import CoreCorbusier

class JaneTests: XCTestCase {
    
    func testExample() throws {
        var context = CRBContext()
        context.instances = [
            crbname("point"): CRBPointInstance.init(point: CRBPoint.init(x: 5, y: 10))
        ]
        
        try jane(in: context) { c in
            c.jlet("pointx").equals(i("point").at("x"))
            c.jlet("pointy").equals(i("point").at("y"))
            c.jlet("somepoint").equals(i("pointx"))
        }
        
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
