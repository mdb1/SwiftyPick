//
//  UIColor+Palette.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

/// Currently supported Palettes
extension UIColor.Palette {
    /// Default Palette/Theme for the app
    static let `default` = UIColor.Palette(name: "Default")
    /// Alternative Theme, using non-standard colors for backgrounds/texts
    static let flashy = UIColor.Palette(name: "Flashy")
}

/// Semantic representation of the colors in the Palettes
enum ColorNames: String {
    /// Background color names
    case backgroundMain, backgroundMid, backgroundAlt
    /// Text color names
    case textPrimary, textAlt
    /// App color names
    case primary, secondary, tertiary
}

extension UIColor {
    /// All the Palettes have the same semantics for their colors
    struct Palette {
        /// Name of the Palette
        let name: String

        /// Color used for main backgrounds
        var backgroundMain: UIColor { assetCatalogColor(named: .backgroundMain) }
        /// Color used for secondary backgrounds
        var backgroundMid: UIColor { assetCatalogColor(named: .backgroundMid) }
        /// Color used for alternative backgrounds
        var backgroundAlt: UIColor { assetCatalogColor(named: .backgroundAlt) }

        /// Color used for primary texts
        var textPrimary: UIColor { assetCatalogColor(named: .textPrimary) }
        /// Color used for alternative texts
        var textAlt: UIColor { assetCatalogColor(named: .textAlt) }

        /// Color used as primary in the app
        var primary: UIColor { assetCatalogColor(named: .primary) }
        /// Color used as secondary in the app
        var secondary: UIColor { assetCatalogColor(named: .secondary) }
        /// Color used as tertiary in the app
        var tertiary: UIColor { assetCatalogColor(named: .tertiary) }

        // Remember to add new colors to this computed property
        /// Collection of all the colors used in the app
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
