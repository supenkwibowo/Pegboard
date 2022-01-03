//
//  PegboardConstraint.swift
//  
//
//  Created by Sugeng Wibowo on 28/12/21.
//

import UIKit

public protocol LayoutConstraintConvertible {
    func toLayoutConstraints() -> [NSLayoutConstraint]
}

public struct BaseConstraintOperation<AnchorType: AnyObject>
: LayoutConstraintConvertible {
    public let lhAnchor: NSLayoutAnchor<AnchorType>
    public let rhAnchor: NSLayoutAnchor<AnchorType>
    
    public func toLayoutConstraints() -> [NSLayoutConstraint] {
        return [toLayoutConstraint()]
    }
    
    private func toLayoutConstraint() -> NSLayoutConstraint {
        lhAnchor.constraint(equalTo: rhAnchor)
    }
}

public struct EqualConstantConstraintOperation<AnchorType: AnyObject>
: LayoutConstraintConvertible {
    public let base: BaseConstraintOperation<AnchorType>
    public let constant: CGFloat
    
    public func toLayoutConstraints() -> [NSLayoutConstraint] {
        return [toLayoutConstraint()]
    }
    
    private func toLayoutConstraint() -> NSLayoutConstraint {
        base.lhAnchor.constraint(equalTo: base.rhAnchor, constant: constant)
    }
}

public struct LessOrEqualConstraintOperation<AnchorType: AnyObject>
: LayoutConstraintConvertible {
    public let base: BaseConstraintOperation<AnchorType>
    public let constant: CGFloat
    
    public func toLayoutConstraints() -> [NSLayoutConstraint] {
        return [toLayoutConstraint()]
    }
    
    private func toLayoutConstraint() -> NSLayoutConstraint {
        base.lhAnchor.constraint(lessThanOrEqualTo: base.rhAnchor, constant: constant)
    }
}

public struct GreaterOrEqualConstraintOperation<AnchorType: AnyObject>
: LayoutConstraintConvertible {
    public let base: BaseConstraintOperation<AnchorType>
    public let constant: CGFloat
    
    public func toLayoutConstraints() -> [NSLayoutConstraint] {
        return [toLayoutConstraint()]
    }
    
    private func toLayoutConstraint() -> NSLayoutConstraint {
        base.lhAnchor.constraint(greaterThanOrEqualTo: base.rhAnchor, constant: constant)
    }
}

public struct ConstraintOperationGroup: LayoutConstraintConvertible {
    public let operations: [LayoutConstraintConvertible]
    public init(_ operations: [LayoutConstraintConvertible]) {
        self.operations = operations
    }
    
    public func toLayoutConstraints() -> [NSLayoutConstraint] {
        operations.flatMap { $0.toLayoutConstraints() }
    }
}

extension NSLayoutConstraint: LayoutConstraintConvertible {
    public func toLayoutConstraints() -> [NSLayoutConstraint] {
        [self]
    }
}
