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

final class MainPresenter: BasePresenter, MainPresenting {
    func getCurrentPalette() -> UIColor.Palette {
        // Future Improvement: Grab the palette from user defaults
        return .flashy
    }
}
