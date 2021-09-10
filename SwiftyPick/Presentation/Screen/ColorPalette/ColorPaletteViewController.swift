//
//  ColorPaletteViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/08/2021.
//

import UIKit

// Future improvement: Add the option to change the current palette

/// The VC for the ColorPalette feature
final class ColorPaletteViewController: BaseViewController {
    private lazy var colorView = ColorPaletteView(palette: palette)
    private lazy var palette = presenter.getCurrentPalette()

    private let presenter: ColorPalettePresenting

    /// Custom init.
    /// - Parameter presenter: the presenter for the vc
    init(presenter: ColorPalettePresenting = ColorPalettePresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        self.presenter.delegate = self
        colorView.delegate = self
    }

    /// Required init by the compiler.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates the view that the controller manages.
    override func loadView() {
        self.view = colorView
    }

    /// Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setUpNavigation()
    }

    private func setUpNavigation() {
        title = L10n.ColorPaletteScreen.title
    }
}

/// Conformance to the ColorPalettePresenterDelegate
extension ColorPaletteViewController: ColorPalettePresenterDelegate {}

/// Conformance to the ColorPalettePresenterDelegate
extension ColorPaletteViewController: ColorPaletteViewDelegate {}
