//
//  TableDataSourceProvider.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import Foundation

/// Represents the data source of a table view
protocol TableDataSourceProvider: AnyObject {
    /// Number of sections to be displayed
    var numberOfSections: Int { get }

    /// Number of rows to be displayed for a given section
    /// - Parameter section: section number in the table
    /// - Returns number of rows for given section
    func numberOfRows(in section: Int) -> Int
}
