//
//  ColorRepresentationView.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

/// This view is a representation of one color in the palette.
final class ColorRepresentationView: UIView {
    private(set) var nameLabel: UILabel!
    private(set) var color: UIColor!
    private(set) var palette: UIColor.Palette!

    convenience init(color: UIColor, palette: UIColor.Palette) {
        self.init(frame: .zero)

        self.color = color
        self.palette = palette
        setUp()
    }
}

// MARK: - View Set Up
private extension ColorRepresentationView {
    func setUp() {
        backgroundColor = color
        setUpLabel()
    }

    func setUpLabel() {
        // Future improvement: Move this to UIView helper methods in extensions
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.text = color.name

        nameLabel.textColor = getTextColor()

        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Spacing.medium),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.Spacing.medium),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func getTextColor() -> UIColor {
        guard let name = color.name else { return .black }

        // If we need to display one of the `text` colors, the text should be the opposite as the background
        if name.contains(ColorNames.textPrimary.rawValue) {
            return palette.textAlt
        }

        if name.contains(ColorNames.textAlt.rawValue) {
            return palette.textPrimary
        }

        // Otherwise, check for the "Alt" keyword in the name
        let shouldUseAltTextColor = name.contains("Alt")
        return shouldUseAltTextColor
            ? palette.textAlt
            : palette.textPrimary
    }
}
