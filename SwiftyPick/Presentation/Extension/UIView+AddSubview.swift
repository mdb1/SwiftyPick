//
//  UIView+AddSubview.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 31/08/2021.
//

import UIKit

extension UIView {
    /// Adds the subview as a child and apply the constraints described.
    /// - Parameters:
    ///   - subview: view to add as a child.
    ///   - constraints: dictionary with attributes keys and Spacing constants
    /// - Returns: The array of constraints applied.
    /// - Usage example:
    /// add(childView, constrainedBy: [.top: .none, .leading: .small, .trailing: .small, .bottom: .none])
    @discardableResult
    public func addSubview(
        _ subview: UIView,
        constrainedBy constraints: [NSLayoutConstraint.Attribute: Spacing]
    ) -> [NSLayoutConstraint] {
        var appliedConstraints: [NSLayoutConstraint] = []
        
        subview.disableAutoConstraints()
        addSubview(subview)

        constraints.forEach { attribute, constant in
            // Get real value of the inset; ie: if value provided is 16, we actually set -16.
            let constantRealValue = (
                attribute == .bottom || attribute == .bottomMargin ||
                attribute == .trailing || attribute == .trailingMargin
            ) ? -constant.rawValue : constant.rawValue

            let constraint = NSLayoutConstraint(
                item: subview,
                attribute: attribute,
                relatedBy: .equal,
                toItem: self,
                attribute: attribute,
                multiplier: 1,
                constant: constantRealValue
            )

            constraint.priority = .required
            constraint.isActive = true
            appliedConstraints.append(constraint)
        }

        return appliedConstraints
    }

    /// Convenience method that adds the subview as a child and apply the same inset to the 4 edges.
    /// - Parameters:
    ///   - subview: view to add as a child.
    ///   - insets: Spacing case to apply to the 4 edges (top, leading, trailing, bottom)
    /// - Returns: The array of constraints applied.
    /// - Usage example:
    /// add(childView, insets: .medium)
    @discardableResult
    public func addSubview(
        _ subview: UIView,
        insets: Spacing
    ) -> [NSLayoutConstraint] {
        addSubview(
            subview,
            constrainedBy: [
                .top: insets,
                .trailing: insets,
                .leading: insets,
                .bottom: insets
            ]
        )
    }

    /// Convenience method to disable the auto constraints.
    func disableAutoConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
