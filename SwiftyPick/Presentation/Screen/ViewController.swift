//
//  ViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/08/2021.
//

import UIKit

class ViewController: UIViewController {
    private(set) var scrollView: UIScrollView!
    private(set) var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// Future improvement: This will be moved to another VC in the future
// MARK: - View Set Up
private extension ViewController {
    func setUpUI() {
        view.backgroundColor = UIColor.Palette.default.backgroundMain

        setUpScrollView()
        addColorPaletteView()
    }

    func setUpScrollView() {
        scrollView = UIScrollView()
        contentView = UIView()
        view.addSubview(
            scrollView,
            constrainedBy: [
                .leadingMargin: .none,
                .trailingMargin: .none,
                .bottomMargin: .none
            ]
        )
        scrollView.pin(.top, to: .topMargin, of: view, relatedBy: .equal)
        scrollView.addSubview(contentView, insets: .none)
        contentView.pin(.width, to: .width, of: scrollView)
    }

    func addColorPaletteView() {
        // Future improvement: Grab the current Palette from User Defaults
        let colorPaletteView = ColorPalettesView(palette: .flashy)
        contentView.addSubview(
            colorPaletteView,
            insets: .none
        )
        colorPaletteView.centerHorizontally()
    }
}
