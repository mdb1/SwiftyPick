//
//  UIView+Pin.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 31/08/2021.
//

import UIKit

extension UIView {
    /// Helper method to create a constraint between self and another view.
    /// - Parameters:
    ///   - attribute: `From` NSLayoutConstraint.Attribute
    ///   - toAttribute: `To` NSLayoutConstraint.Attribute
    ///   - view2: `To` view
    ///   - relation: NSLayoutConstraint.Relation between the views
    ///   - multiplier: CGFloat to multiply the constant
    ///   - constant: Distance for the constraint
    ///   - priority: UILayoutPriority for the constraint
    ///   - isActive: Bool that indicates if the constraint will be active after the call
    /// - Returns: The applied constraint
    @discardableResult
    public func pin(
        _ attribute: NSLayoutConstraint.Attribute,
        to toAttribute: NSLayoutConstraint.Attribute = .notAnAttribute,
        of view2: UIView? = nil,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        disableAutoConstraints()

        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: relation,
            toItem: view2,
            attribute: toAttribute,
            multiplier: multiplier,
            constant: constant
        )
        constraint.priority = priority
        constraint.isActive = isActive

        return constraint
    }

    /// Convenience method to apply width and height constraints at the same time
    /// - Parameters:
    ///   - size: CGSize describing the width and the height to apply
    ///   - relation: NSLayoutConstraint.Relation between the views
    ///   - priority: UILayoutPriority for the constraints
    /// - Returns: The applied constraints
    @discardableResult
    func pinSize(
        _ size: CGSize,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let width = pin(width: size.width, relatedBy: relation, priority: priority)
        let height = pin(height: size.height, relatedBy: relation, priority: priority)
        return (width: width, height: height)
    }

    /// Convenience method to apply a width constraint
    /// - Parameters:
    ///   - width: CGFloat describing the width to apply
    ///   - relation: NSLayoutConstraint.Relation between the views
    ///   - priority: UILayoutPriority for the constraints
    /// - Returns: The applied width constraint
    @discardableResult
    func pin(
        width: CGFloat,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        pin(.width, relatedBy: relation, constant: width, priority: priority)
    }

    /// Convenience method to apply a height constraint
    /// - Parameters:
    ///   - width: CGFloat describing the height to apply
    ///   - relation: NSLayoutConstraint.Relation between the views
    ///   - priority: UILayoutPriority for the constraints
    /// - Returns: The applied height constraint
    @discardableResult
    func pin(
        height: CGFloat,
        relatedBy relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        pin(.height, relatedBy: relation, constant: height, priority: priority)
    }

    /// Convenience method to pin self to the center (x and y) of another view
    /// - Parameter view: the view to which self will be centered to. nil implies to use self.superview instead.
    /// - Returns: The applied constraints
    @discardableResult
    func pinToCenter(of view: UIView? = nil) -> (horizontal: NSLayoutConstraint, vertical: NSLayoutConstraint) {
        let centerX = centerHorizontally(of: view)
        let centerY = centerVertically(of: view)
        return (horizontal: centerX, vertical: centerY)
    }

    /// Convenience method to pin self to the horizontal center (x) of another view
    /// - Parameter view: the view to which self will be centered to. nil implies to use self.superview instead.
    /// - Returns: The applied constraint
    @discardableResult
    func centerHorizontally(of view: UIView? = nil) -> NSLayoutConstraint {
        if let view = view {
            return pin(.centerX, to: .centerX, of: view)
        }

        return pin(.centerX, to: .centerX, of: superview)
    }

    /// Convenience method to pin self to the vertical center (y) of another view
    /// - Parameter view: the view to which self will be centered to. nil implies to use self.superview instead.
    /// - Returns: The applied constraint
    @discardableResult
    func centerVertically(of view: UIView? = nil) -> NSLayoutConstraint {
        if let view = view {
            return pin(.centerY, to: .centerY, of: view)
        }

        return pin(.centerY, to: .centerY, of: superview)
    }
}
