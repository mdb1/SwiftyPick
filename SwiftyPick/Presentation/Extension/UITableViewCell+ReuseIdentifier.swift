//
//  UITableViewCell+ReuseIdentifier.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 18/09/2021.
//

import UIKit

/// Protocol that provides reuseIdentifier property.
protocol CellIdentifiable: AnyObject {
    /// The reuseIdentifier to use when displaying cells on [Table|Collection]Views.
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: CellIdentifiable {
    /// Static property for custom reuse identifier of UITableViewCell.
    /// It just uses the name of the class.
    /// ie: for YourCustomCell.swift: "YourCustomCell"
    internal static var reuseIdentifier: String {
        String(describing: self)
    }
}
