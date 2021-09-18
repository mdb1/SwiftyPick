//
//  ColorRepresentationView.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 27/08/2021.
//

import UIKit

/// This view is a representation of one color in the palette.
final class ColorRepresentationView: UIView {
    /// Label that displays the name of the color.
    private(set) var nameLabel: UILabel!
    /// Label that displays the hexadecimal representation of the color.
    private(set) var hexaLabel: UILabel!
    /// UIColor for the view.
    private(set) var color: UIColor!
    /// Palette from where the app will grab the color.
    private(set) var palette: UIColor.Palette!

    /// Custom initializer for the view.
    /// - Parameters:
    ///   - color: the color to display
    ///   - palette: from where the app will grab the color
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
        setUpLabels()
    }

    func setUpLabels() {
        setUpNameLabel()
        setUpHexaLabel()
    }

    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = color.name
        nameLabel.textColor = getTextColor()

        addSubview(
            nameLabel,
            constrainedBy: [
                .top: .medium,
                .bottom: .medium,
                .leading: .medium
            ]
        )
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    func setUpHexaLabel() {
        hexaLabel = UILabel()
        hexaLabel.textAlignment = .center
        hexaLabel.text = color.hexString()
        hexaLabel.textColor = getTextColor()

        addSubview(
            hexaLabel,
            constrainedBy: [
                .top: .medium,
                .bottom: .medium,
                .trailing: .medium
            ]
        )
        hexaLabel.pin(
            .leading,
            to: .trailing,
            of: nameLabel,
            relatedBy: .greaterThanOrEqual,
            constant: Spacing.large.rawValue
        )
        hexaLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
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
