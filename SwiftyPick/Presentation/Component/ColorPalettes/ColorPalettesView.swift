//
//  ColorPalettesView.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

/// This view is a representation of the colors in the color palettes.
final class ColorPalettesView: UIView {
    private(set) var stackView: UIStackView!
    private(set) var palette: UIColor.Palette!

    convenience init(palette: UIColor.Palette) {
        self.init(frame: .zero)

        self.palette = palette
        setUp()
    }
}

// MARK: - View Set Up
private extension ColorPalettesView {
    func setUp() {
        setUpStackView()
    }

    func setUpStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView, insets: .none)

        palette.allColors.forEach {
            stackView.addArrangedSubview(
                ColorRepresentationView(color: $0, palette: palette)
            )
        }
    }
}
