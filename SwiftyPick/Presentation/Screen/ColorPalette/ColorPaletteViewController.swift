//
//  ColorPaletteViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/08/2021.
//

import UIKit

// Future improvement: Add the option to change the current palette

final class ColorPaletteViewController: BaseViewController {
    private lazy var colorView = ColorPaletteView(palette: palette)
    private lazy var palette = presenter.getCurrentPalette()

    private let presenter: ColorPalettePresenting

    init(presenter: ColorPalettePresenting = ColorPalettePresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        self.presenter.delegate = self
        colorView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = colorView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setUpNavigation()
    }

    private func setUpNavigation() {
        title = L10n.ColorPaletteScreen.title
    }
}

extension ColorPaletteViewController: ColorPalettePresenterDelegate {}

extension ColorPaletteViewController: ColorPaletteViewDelegate {}
