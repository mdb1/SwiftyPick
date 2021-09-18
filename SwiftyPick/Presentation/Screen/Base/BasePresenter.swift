//
//  BasePresenter.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 08/09/2021.
//

import Foundation

// Future improvement: Rename this protocol to Failable and only use it in presenter with network calls.
// Keep Presentable for shared stuff.
/// Base Protocol that all presenter protocols should conform to.
protocol Presentable: AnyObject {
    /// Display a specific error in the screen
    /// - Parameter error: the error to be displayed
    func displayError(_ error: Error)
}

/// Base Presenter class to share functionality with it's children.
class BasePresenter {
    /// Initializer method of the BasePresenter
    init() {
        setUp()
    }

    /// setUp method to be called on the init
    func setUp() {
        print("\(self.self) set up")
    }

    /// de-init method that gets called when the instance will be released
    deinit { print("\(self.self) de-init") }
}
