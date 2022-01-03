import XCTest
@testable import Pegboard

class PegboardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    func testActivateShouldActivateAllConstraints() {
        let viewA = UIView()
        let viewB = UIView()
        let parentView = UIView()
        parentView.addSubview(viewA)
        parentView.addSubview(viewB)
        
        pegboard.activate {
            viewA.leadingAnchor ~ viewB.leadingAnchor
            viewA.widthAnchor ~ viewB.widthAnchor
        }
        
        assert(
            parentView,
            hasConstraints: [
                viewA.leadingAnchor ~ viewB.leadingAnchor,
                viewA.widthAnchor ~ viewB.widthAnchor
            ]
        )
    }
    
    func testGroupShouldNotActivateConstraints() {
        let view = UIView()
        let parentView = UIView()
        parentView.addSubview(view)
        
        _ = pegboard.group {
            view.topAnchor ~ parentView.topAnchor
            view.widthAnchor ~ parentView.widthAnchor
        }
        
        XCTAssertTrue(parentView.constraints.isEmpty)
    }
    
    func testGroupedConstraints() {
        let view = UIView()
        
        let group = pegboard.group {
            view.widthAnchor ~ view.heightAnchor
            view.topAnchor ~ view.bottomAnchor + 100
        }
        
        assert(
            group.toLayoutConstraints(),
            equalTo: [
                view.widthAnchor ~ view.heightAnchor,
                view.topAnchor ~ view.bottomAnchor + 100
            ]
        )
    }
}

private func assert(
    _ view: UIView,
    hasConstraints expected: [LayoutConstraintConvertible],
    line: UInt = #line
) {
    assert(view.constraints, equalTo: expected, line: line)
    view.constraints.enumerated().forEach { index, constraint in
        XCTAssertTrue(
            constraint.isActive,
            "constraint at index \(index) should be active",
            line: line
        )
    }
}
