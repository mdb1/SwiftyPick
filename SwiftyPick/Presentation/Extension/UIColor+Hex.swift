//
//  UIColor+Hex.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

extension UIColor {
    /// Returns the hex of a color. For example: `#FFFFFF`.
    /// - Returns: The hex string for this `UIColor`.
    func hexString() -> String? {
        let components = cgColor.components

        let red: CGFloat = components?[0] ?? 0.0
        let green: CGFloat = components?[1] ?? 0.0
        let blue: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )
        return hexString
    }
}
