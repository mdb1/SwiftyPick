//
//  ViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/08/2021.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Palette.default.backgroundMain

        addColorPaletteView()
    }

    // Future improvement: This will be moved to another VC in the future
    private func addColorPaletteView() {
        // Future improvement: Grab the current Palette from User Defaults
        let colorPaletteView = ColorPalettesView(palette: .flashy)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorPaletteView)
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.Spacing.medium
            ),
            colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
