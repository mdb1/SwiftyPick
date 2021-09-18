//
//  ColorPaletteView.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 08/09/2021.
//

import UIKit

/// ColorPaletteViewDelegate used by the view to communicate with the VC.
protocol ColorPaletteViewDelegate: AnyObject {}

/// The view that displays all the colors for a custom palette
final class ColorPaletteView: BaseView {
    /// ScrollView for the view.
    private(set) var scrollView: UIScrollView!
    /// ContentView.
    private(set) var contentView: UIView!
    private var palette: UIColor.Palette!
    /// Delegate to communicate back to the VC.
    weak var delegate: ColorPaletteViewDelegate?

    /// Custom Init.
    /// - Parameter palette: the palette to be used in this view
    init(palette: UIColor.Palette) {
        self.palette = palette
        super.init(frame: .zero)

        setUpUI()
    }

    /// Required init by the compiler.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Set Up
private extension ColorPaletteView {
    func setUpUI() {
        backgroundColor = palette.backgroundMain

        setUpScrollView()
        addColorPaletteView()
    }

    func setUpScrollView() {
        scrollView = UIScrollView()
        contentView = UIView()
        addSubview(
            scrollView,
            constrainedBy: [
                .leadingMargin: .none,
                .trailingMargin: .none,
                .bottomMargin: .none
            ]
        )
        scrollView.pin(.top, to: .topMargin, of: self, relatedBy: .equal)
        scrollView.addSubview(contentView, insets: .none)
        contentView.pin(.width, to: .width, of: scrollView)
    }

    func addColorPaletteView() {
        let colorPaletteView = ColorPalettesView(palette: palette)
        contentView.addSubview(
            colorPaletteView,
            insets: .none
        )
        colorPaletteView.centerHorizontally()
    }
}
