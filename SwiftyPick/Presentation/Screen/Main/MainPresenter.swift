//
//  MainPresenter.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import UIKit

/// MainPresenting protocol used in the VC to communicate with the Presenter.
protocol MainPresenting: AnyObject {
    /// Returns the current palette stored in user defaults
    func getCurrentPalette() -> UIColor.Palette
}

/// MainPresenter: presenter to be used by the MainViewController
final class MainPresenter: BasePresenter, MainPresenting {
    /// Method to get the current palette of the app
    /// - Returns: the palette stored in user defaults as the current one selected
    func getCurrentPalette() -> UIColor.Palette {
        // Future Improvement: Grab the palette from user defaults
        return .flashy
    }
}
