//
//  PegboardOperator.swift
//  
//
//  Created by Sugeng Wibowo on 28/12/21.
//

import UIKit

precedencegroup ConstraintOperator {
    associativity: left
    higherThan: AdditionPrecedence, ComparisonPrecedence
}

infix operator ~ : ConstraintOperator
infix operator |=| : ConstraintOperator

public func ~ <AnchorType: AnyObject> (
    lhs: NSLayoutAnchor<AnchorType>,
    rhs: NSLayoutAnchor<AnchorType>
) -> BaseConstraintOperation<AnchorType> {
    return BaseConstraintOperation(lhAnchor: lhs, rhAnchor: rhs)
}

public func |=| (lhs: UIView, rhs: UIView) -> ConstraintOperationGroup {
    return pegboard.group {
        lhs.topAnchor ~ rhs.topAnchor
        lhs.bottomAnchor ~ rhs.bottomAnchor
        lhs.leadingAnchor ~ rhs.leadingAnchor
        lhs.trailingAnchor ~ rhs.trailingAnchor
    }
}

public func + <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: CGFloat
) -> EqualConstantConstraintOperation<AnchorType> {
    EqualConstantConstraintOperation(base: operation, constant: constant)
}

public func - <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: CGFloat
) -> EqualConstantConstraintOperation<AnchorType> {
    operation + (-constant)
}

public func + <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: Int
) -> EqualConstantConstraintOperation<AnchorType> {
    operation + CGFloat(constant)
}

public func - <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: Int
) -> EqualConstantConstraintOperation<AnchorType> {
    operation - CGFloat(constant)
}

public func <= <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: CGFloat
) -> LessOrEqualConstraintOperation<AnchorType> {
    LessOrEqualConstraintOperation(base: operation, constant: constant)
}

public func <= <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: Int
) -> LessOrEqualConstraintOperation<AnchorType> {
    operation <= CGFloat(constant)
}

public func >= <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: CGFloat
) -> GreaterOrEqualConstraintOperation<AnchorType> {
    GreaterOrEqualConstraintOperation(base: operation, constant: constant)
}

public func >= <AnchorType: AnyObject> (
    operation: BaseConstraintOperation<AnchorType>,
    constant: Int
) -> GreaterOrEqualConstraintOperation<AnchorType> {
    operation >= CGFloat(constant)
}

