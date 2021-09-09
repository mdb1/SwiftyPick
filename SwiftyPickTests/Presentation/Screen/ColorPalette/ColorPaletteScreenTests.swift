//
//  ColorPaletteScreenTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 08/09/2021.
//

@testable import SwiftyPick
import XCTest

class ColorPaletteScreenTests: XCTestCase {
    private var presenter: ColorPalettePresenting!
    private var vc: ColorPaletteViewController!
    private var view: ColorPaletteView!

    override func setUp() {
        super.setUp()
        presenter = ColorPalettePresenter()
        vc = ColorPaletteViewController(presenter: presenter)
        view = ColorPaletteView(palette: .default)
        vc.loadView()
    }

    override func tearDown() {
        defer { super.tearDown() }
        presenter = nil
        vc = nil
        view = nil
    }

    func testVcAndPresenter() {
        presenter.delegate = vc
        XCTAssert(presenter.delegate === vc)
    }

    func testVcAndView() {
        view.delegate = vc
        XCTAssert(view.delegate === vc)
    }

    func testGetPalette() {
        XCTAssertEqual(presenter.getCurrentPalette().allColors, UIColor.Palette.flashy.allColors)
    }
}
