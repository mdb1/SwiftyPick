//
//  Spacing.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

/// Spacings should be multiples of `8`.
public enum Spacing: CGFloat {
    /// none means no space
    case none = 0
    /// small means 8 pts of space
    case small = 8
    /// medium means 16 pts of space
    case medium = 16
    /// large means 24 pts of space
    case large = 24
    /// xLarge means 32 pts of space
    case xLarge = 32
}
