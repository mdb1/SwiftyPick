//
//  BaseViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 08/09/2021.
//

import UIKit

/// Base VC to share common functionality with it's children.
class BaseViewController: UIViewController {}
/// Base TableVC to share common functionality with it's children.
class BaseTableViewController: UITableViewController {}

extension BaseViewController: Presentable {}
extension BaseTableViewController: Presentable {}

extension UIViewController {
    func displayError(_ error: Error) {
        // Future improvement: Design and display the error view, also add unit tests
        print("Display error view")
    }
}
