//
//  UITableView+Dequeue.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 18/09/2021.
//

import UIKit

/// Protocol that provides a method to dequeue cells in [Table|Collection]Views.
protocol CellDequeuing: AnyObject {
    /// Dequeues a cell of type CellType.
    /// - Parameter type: The type of the cell to be dequeued.
    /// - Parameter indexPath: The indexPath in which to dequeue the cell.
    func dequeueReusableCell<CellType: UITableViewCell>(
        _ type: CellIdentifiable.Type,
        for indexPath: IndexPath
    ) -> CellType
}

extension UITableView: CellDequeuing {
    /// Helper method for dequeuing reusable cells of type CellType that handles errors with a crash.
    /// - Parameter type: Type of the UITableViewCell to be dequeued. ie: YourCustomCell.self.
    /// - Parameter indexPath: IndexPath for the cell.
    ///
    /// Usage:
    /// ```swift
    /// tableView.dequeueReusableCell(YourCustomCell.self, for: indexPath)
    /// ```
    func dequeueReusableCell<CellType: UITableViewCell>(
        _ type: CellIdentifiable.Type,
        for indexPath: IndexPath
    ) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? CellType else {
            fatalError("Couldn't dequeue cell of type: \(CellType.self). Have you registered the cell?")
        }

        return cell
    }
}
