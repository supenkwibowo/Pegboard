import XCTest
@testable import Pegboard

func assert(
    _ constraints: [LayoutConstraintConvertible],
    equalTo expected: [LayoutConstraintConvertible],
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let sourceConstraints = constraints.flatMap { $0.toLayoutConstraints() }
    let expectedConstraints = expected.flatMap { $0.toLayoutConstraints() }
    
    XCTAssertEqual(sourceConstraints.count, expectedConstraints.count, "constraints count", file: file, line: line)
    for index in 0..<sourceConstraints.count {
        let sourceConstraint = sourceConstraints[index]
        let expectedConstraint = expectedConstraints[index]
        assert(sourceConstraint, equalTo: expectedConstraint, "at index \(index)", file: file, line: line)
    }
}

private func assert(
    _ constraint: NSLayoutConstraint,
    equalTo expected: NSLayoutConstraint,
    _ message: String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    assert(constraint, expected, for: \.firstItem, castedValueType: UIView.self, message, file: file, line: line)
    assert(constraint, expected, for: \.secondItem, castedValueType: UIView.self, message, file: file, line: line)
    assert(constraint, expected, for: \.firstAnchor, message, file: file, line: line)
    assert(constraint, expected, for: \.secondAnchor, message, file: file, line: line)
    assert(constraint, expected, for: \.firstAttribute, message, file: file, line: line)
    assert(constraint, expected, for: \.secondAttribute, message, file: file, line: line)
    assert(constraint, expected, for: \.relation, message, file: file, line: line)
    assert(constraint, expected, for: \.constant, message, file: file, line: line)
    assert(constraint, expected, for: \.multiplier, message, file: file, line: line)
    assert(constraint, expected, for: \.priority, message, file: file, line: line)
}

private func assert<Value: Equatable>(
    _ lhs: NSLayoutConstraint, _ rhs: NSLayoutConstraint,
    for keyPath: KeyPath<NSLayoutConstraint, Value>,
    _ message: String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    assert(
        lhs, rhs,
        for: keyPath, castedValueType: Value.self,
        message, file: file, line: line
    )
}

private func assert<Value, CastedType: Equatable>(
    _ lhs: NSLayoutConstraint, _ rhs: NSLayoutConstraint,
    for keyPath: KeyPath<NSLayoutConstraint, Value>,
    castedValueType: CastedType.Type,
    _ message: String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let keyPathName = NSExpression(forKeyPath: keyPath).keyPath
    let lhsValue = try? XCTUnwrap(
        lhs[keyPath: keyPath] as? CastedType,
        "constraint value for keypath: \(keyPathName) is not Equatable",
        file: file, line: line
    )
    let rhsValue = try? XCTUnwrap(
        rhs[keyPath: keyPath] as? CastedType,
        "constraint value for keypath: \(keyPathName) is not Equatable",
        file: file, line: line
    )
    XCTAssertEqual(
        lhsValue, rhsValue, keyPathName.prependIfNotEmpty(message),
        file: file, line: line
    )
}

private extension String {
    func prependIfNotEmpty(_ prefix: String) -> String {
        if prefix.isEmpty {
            return self
        } else {
            return "\(prefix) : \(self)"
        }
    }
}
