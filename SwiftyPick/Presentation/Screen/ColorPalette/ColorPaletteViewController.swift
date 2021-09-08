//
//  ColorPaletteViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/08/2021.
//

import UIKit

class ColorPaletteViewController: BaseViewController {
    private lazy var colorView = ColorPaletteView(palette: palette)
    private lazy var palette = presenter.getPaletteView()

    private let presenter: ColorPalettePresenting

    init(presenter: ColorPalettePresenting) {
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
}

extension ColorPaletteViewController: ColorPalettePresenterDelegate {}

extension ColorPaletteViewController: ColorPaletteViewDelegate {}
