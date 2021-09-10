//
//  ColorPaletteView.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 08/09/2021.
//

import UIKit

/// ColorPaletteViewDelegate used by the view to communicate with the VC.
protocol ColorPaletteViewDelegate: AnyObject {}

final class ColorPaletteView: BaseView {
    private(set) var scrollView: UIScrollView!
    private(set) var contentView: UIView!
    private var palette: UIColor.Palette!
    weak var delegate: ColorPaletteViewDelegate?

    init(palette: UIColor.Palette) {
        self.palette = palette
        super.init(frame: .zero)

        setUpUI()
    }

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
