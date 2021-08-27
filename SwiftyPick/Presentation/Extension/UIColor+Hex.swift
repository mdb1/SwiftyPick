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
        guard let model = cgColor.colorSpace?.model else {
            return nil
        }

        switch model {
        case .rgb:
            return rgbHex()
        case .monochrome:
            return monochromeHex()
        default:
            return nil
        }
    }
}

private extension UIColor {
    func rgbHex() -> String {
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

    func monochromeHex() -> String {
        let components = cgColor.components

        let greyScale: CGFloat = components?[0] ?? 0.0

        // We only have black and white as monochrome, so we will hack this for now:
        if greyScale == 1.0 {
            return "#FFFFFF"
        } else {
            return "#000000"
        }
    }
}
