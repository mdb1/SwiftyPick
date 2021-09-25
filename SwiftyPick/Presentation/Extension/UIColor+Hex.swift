//
//  UIColor+Hex.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

/// Testing github action to deploy docs
func hello() {

}

extension UIColor {
    /// Returns the hex of a color. For example: `#FFFFFF`.
    /// - Returns: The hex string for this `UIColor`.
    func hexString() -> String? {
        guard let components = cgColor.components else {
            fatalError("Couldn't retrieve components from \(self)")
        }

        let red: CGFloat = components[0]
        let green: CGFloat = components[1]
        let blue: CGFloat = components[2]

        let hexString = String.init(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )
        return hexString
    }
}
