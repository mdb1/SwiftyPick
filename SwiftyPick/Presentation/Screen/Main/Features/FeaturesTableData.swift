//
//  FeaturesTableData.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import Foundation

/// Represents the possible sections in the FeaturesViewController's table
enum FeaturesSection {
    /// Section containing UI stuff
    case userInterface(_ userInterfaceRows: [UserInterfaceRows])

    /// Title for the section to be displayed on the table
    var title: String {
        switch self {
        case .userInterface:
            return L10n.FeaturesScreen.Sections.UserInterface.title
        }
    }
}

/// Represents the possible rows in the UserInterface section
enum UserInterfaceRows {
    /// Row for access to the ColorPalette
    case colorPalette

    /// Title for the cell
    var cellTitle: String {
        switch self {
        case .colorPalette:
            return L10n.ColorPaletteScreen.title
        }
    }
}
