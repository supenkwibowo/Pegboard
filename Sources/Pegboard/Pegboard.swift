//
//  Pegboard.swift
//  
//
//  Created by Sugeng Wibowo on 28/12/21.
//

import UIKit

public let pegboard = Pegboard()

public struct Pegboard {
    fileprivate init() {}
    public func activate(@ConstraintBuilder _ block: () -> [LayoutConstraintConvertible]) -> Void {
        let layoutConstraints = group(block()).toLayoutConstraints()
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    public func group(@ConstraintBuilder _ block: () -> [LayoutConstraintConvertible])
    -> ConstraintOperationGroup {
        group(block())
    }
    
    public func group(_ operations: [LayoutConstraintConvertible]) -> ConstraintOperationGroup {
        ConstraintOperationGroup(operations)
    }
}

@resultBuilder
public struct ConstraintBuilder {
    public static func buildBlock(_ constraints: LayoutConstraintConvertible...)
    -> [LayoutConstraintConvertible] {
        return constraints
    }
}
