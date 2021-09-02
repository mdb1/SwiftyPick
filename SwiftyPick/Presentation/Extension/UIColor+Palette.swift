//
//  UIColor+Palette.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

/// Currently supported Palettes
extension UIColor.Palette {
    // Default Palette/Theme for the app
    static let `default` = UIColor.Palette(name: "Default")
    // Alternative Theme, using non-standard colors for backgrounds/texts
    static let flashy = UIColor.Palette(name: "Flashy")
}

/// Semantic representation of the colors in the Palettes
enum ColorNames: String {
    case backgroundMain, backgroundMid, backgroundAlt
    case textPrimary, textAlt
    case primary, secondary, tertiary
}

extension UIColor {
    /// All the Palettes have the same semantics for their colors
    struct Palette {
        let name: String

        var backgroundMain: UIColor { assetCatalogColor(named: .backgroundMain) }
        var backgroundMid: UIColor { assetCatalogColor(named: .backgroundMid) }
        var backgroundAlt: UIColor { assetCatalogColor(named: .backgroundAlt) }

        var textPrimary: UIColor { assetCatalogColor(named: .textPrimary) }
        var textAlt: UIColor { assetCatalogColor(named: .textAlt) }

        var primary: UIColor { assetCatalogColor(named: .primary) }
        var secondary: UIColor { assetCatalogColor(named: .secondary) }
        var tertiary: UIColor { assetCatalogColor(named: .tertiary) }

        // Remember to add new colors to this computed property
        var allColors: [UIColor] {
            [
                backgroundMain, backgroundMid, backgroundAlt,
                textPrimary, textAlt,
                primary, secondary, tertiary
            ]
        }
    }
}

extension UIColor.Palette {
    /// Get the UIColor object from a string
    /// - Parameter semanticColor: color name (Should be one defined in the XCAssets)
    /// - Returns: The color object
    func assetCatalogColor(named semanticColor: ColorNames) -> UIColor {
        guard let color = UIColor(named: "\(self.name)/\(semanticColor)") else {
            fatalError("Couldn't find color for name: \(semanticColor)")
        }
        return color
    }
}
