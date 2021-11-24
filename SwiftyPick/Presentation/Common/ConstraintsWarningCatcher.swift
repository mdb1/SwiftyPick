//
//  ConstraintsWarningCatcher.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/11/2021.
//

import Foundation
import UIKit

extension Notification.Name {
    static let willBreakConstraint = Notification.Name(rawValue: "NSISEngineWillBreakConstraint")
}

/// Constraint Warning Catcher class.
/// To be used only on debug mode to track the NSLayoutConstraints warnings.
final class ConstraintWarningCatcher {
    /// Shared instance
    static let shared: ConstraintWarningCatcher = ConstraintWarningCatcher()

    /// Method to start listening for broken constraints
    /// Note: Only call this **once**!
    func startListening() {
        // Only run this code if we are on debug mode
        guard isDebug else { return }

        let selector = NSSelectorFromString("engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:")
        guard let method = class_getInstanceMethod(UIView.self, selector) else { return }
        let implementation = method_getImplementation(method)

        let replaceSelector = #selector(UIView.willBreakConstraint(_:_:_:))
        guard let replaceMethod = class_getInstanceMethod(UIView.self, replaceSelector) else { return }
        let replaceImplementation = method_getImplementation(replaceMethod)

        class_replaceMethod(UIView.self, selector, replaceImplementation, method_getTypeEncoding(replaceImplementation))
        class_replaceMethod(UIView.self, replaceSelector, implementation, method_getTypeEncoding(implementation))

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceiveBrokenConstraintNotification(_:)),
            name: .willBreakConstraint,
            object: nil
        )
    }

    @objc
    private func didReceiveBrokenConstraintNotification(_ notification: NSNotification) {
        guard let constraint = notification.object as? NSLayoutConstraint else {
            return
        }

        // Future improvement: use the logger
        print("Constraint broken: \(constraint)")
    }
}

extension UIView {
    @objc
    func willBreakConstraint(_ engine: Any, _ constraint: NSLayoutConstraint, _ conflict: Any) {
        willBreakConstraint(engine, constraint, conflict) // swizzled, will call original implementation instead
        NotificationCenter.default.post(
            name: .willBreakConstraint,
            object: constraint
        )
    }
}
