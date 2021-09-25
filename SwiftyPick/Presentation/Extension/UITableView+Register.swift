//
//  UITableView+Register.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 18/09/2021.
//

import UIKit

/// Protocol that provides a method to register cells in [Table|Collection]Views.
protocol CellRegistering: AnyObject {
    /// Registers a cell that conforms to Identifiable.
    /// - Parameter type: The type of the cell to be registered.
    func register<CellType: CellIdentifiable>(_ type: CellType.Type)
}

extension UITableView: CellRegistering {
    /// Helper method for registering reusable cells of type CellType in a table view.
    /// - Parameter type: Type of the UITableViewCell to be dequeued. ie: YourCustomCell.self.
    ///
    /// Usage:
    /// ```swift
    /// tableView.register(YourCustomCell.self)
    /// ```
    func register<CellType: CellIdentifiable>(_ type: CellType.Type) {
        register(type, forCellReuseIdentifier: CellType.reuseIdentifier)
    }
}
