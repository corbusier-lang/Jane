import XCTest
@testable import Jane
@testable import CoreCorbusier

class JaneTests: XCTestCase {
    
    func testExample() throws {
        
        let rect = CGArea(rect: .init(x: 0, y: 0, width: 100, height: 100))
        let area = CGArea(size: .init(width: 50, height: 50))
        
        var context = CRBContext()
        context.instances = [
            crbname("point"): CRBPointInstance.init(point: CRBPoint.init(x: 5, y: 10)),
            crbname("rect"): rect,
            crbname("area"): area,
        ]
        
        try jane(in: context) { j in
            j.jlet("pointx").equals(i("point").at("x"))
            j.jlet("pointy").equals(i("point").at("y"))
            j.jlet("somepoint").equals(i("pointx"))
            j.place(o("area").at("left").at("top").distance(10).from(i("rect").at("right").at("top")))
        }
        
        dump(area)
        
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
