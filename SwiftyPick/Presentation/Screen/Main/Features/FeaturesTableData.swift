//
//  FeaturesTableData.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import Foundation

/// Represents the possible sections in the FeaturesViewController's table
enum FeaturesSection {
    case userInterface(_ userInterfaceRows: [UserInterfaceRows])

    var title: String {
        switch self {
        case .userInterface:
            return L10n.FeaturesScreen.Sections.UserInterface.title
        }
    }
}

/// Represents the possible rows in the UserInterface section
enum UserInterfaceRows {
    case colorPalette

    var cellTitle: String {
        switch self {
        case .colorPalette:
            return L10n.ColorPaletteScreen.title
        }
    }
}
