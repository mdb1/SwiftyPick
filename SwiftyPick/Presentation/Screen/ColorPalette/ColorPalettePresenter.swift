//
//  ColorPalettePresenter.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 08/09/2021.
//

import UIKit

// swiftlint:disable class_delegate_protocol
// ColorPalettePresenterDelegate conforms to AnyObject through Presentable.
/// ColorPalettePresenterDelegate used by the presenter to communicate with the VC.
protocol ColorPalettePresenterDelegate: Presentable {}

/// ColorPalettePresenting protocol used in the VC to communicate with the Presenter.
protocol ColorPalettePresenting: AnyObject {
    /// The delegate from the presenter to the vc
    var delegate: ColorPalettePresenterDelegate? { get set }

    /// Returns the current palette stored in user defaults
    func getCurrentPalette() -> UIColor.Palette
}

/// The Presenter for the Color Palette Screen.
final class ColorPalettePresenter: BasePresenter, ColorPalettePresenting {
    weak var delegate: ColorPalettePresenterDelegate?

    func getCurrentPalette() -> UIColor.Palette {
        // Future Improvement: Grab the palette from user defaults
        return .flashy
    }
}
