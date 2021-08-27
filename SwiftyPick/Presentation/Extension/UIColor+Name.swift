//
//  UIColor+Name.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

extension UIColor {
    /// Returns the human readable name of the color
    var name: String? {
        let string = String(describing: self).dropLast()
        guard let nameRange = string.range(of: "name = ") else { return nil }
        let cropped = string[nameRange.upperBound ..< string.endIndex]
        if cropped.isEmpty { return nil }
        return String(cropped)
    }
}
