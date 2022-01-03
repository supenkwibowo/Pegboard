import XCTest
@testable import Pegboard

final class PegboardOperatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    func testConstraints() {
        let viewA = UIView()
        let viewB = UIView()
        assert(
            [
                viewA.topAnchor ~ viewB.topAnchor,
                viewA.bottomAnchor ~ viewB.bottomAnchor,
                viewA.leadingAnchor ~ viewB.leadingAnchor,
                viewA.trailingAnchor ~ viewB.trailingAnchor,
                viewA.heightAnchor ~ viewA.widthAnchor
            ],
            equalTo: [
                viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
                viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
                viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
                viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
                viewA.heightAnchor.constraint(equalTo: viewA.widthAnchor)
            ]
        )
    }
    
    func testConstraintsWithConstant() {
        let viewA = UIView()
        let viewB = UIView()
        assert(
            [
                viewA.topAnchor ~ viewB.topAnchor + 5,
                viewA.bottomAnchor ~ viewB.bottomAnchor - 10,
                viewA.leadingAnchor ~ viewB.leadingAnchor + 100,
                viewA.trailingAnchor ~ viewB.trailingAnchor - 19
            ],
            equalTo: [
                viewA.topAnchor.constraint(equalTo: viewB.topAnchor, constant: 5),
                viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor, constant: -10),
                viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor, constant: 100),
                viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor, constant: -19)
            ]
        )
    }
    
    func testConstraintsWithLessOrGreaterThanRelations() {
        let viewA = UIView()
        let viewB = UIView()
        assert(
            [
                viewA.topAnchor ~ viewB.topAnchor >= 0,
                viewA.bottomAnchor ~ viewB.bottomAnchor >= 10,
                viewA.leadingAnchor ~ viewB.leadingAnchor <= 0,
                viewA.trailingAnchor ~ viewB.trailingAnchor <= 11,
                viewA.widthAnchor ~ viewB.widthAnchor >= -1,
                viewA.widthAnchor ~ viewB.widthAnchor <= -1
            ],
            equalTo: [
                viewA.topAnchor.constraint(greaterThanOrEqualTo: viewB.topAnchor),
                viewA.bottomAnchor.constraint(greaterThanOrEqualTo: viewB.bottomAnchor, constant: 10),
                viewA.leadingAnchor.constraint(lessThanOrEqualTo: viewB.leadingAnchor),
                viewA.trailingAnchor.constraint(lessThanOrEqualTo: viewB.trailingAnchor, constant: 11),
                viewA.widthAnchor.constraint(greaterThanOrEqualTo: viewB.widthAnchor, constant: -1),
                viewA.widthAnchor.constraint(lessThanOrEqualTo: viewB.widthAnchor, constant: -1)
            ]
        )
    }
    
    func testOperatorEqualConstraintsShouldBeEqualsToFourSidesAnchor() {
        let viewA = UIView()
        let viewB = UIView()
        assert(
            [
                viewA |=| viewB
            ],
            equalTo: [
                viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
                viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
                viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
                viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor)
            ]
        )
    }
}

