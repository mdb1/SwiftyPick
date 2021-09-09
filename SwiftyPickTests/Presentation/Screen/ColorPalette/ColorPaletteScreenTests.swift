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
        XCTAssert(presenter.delegate === vc)
    }

    func testVcAndView() {
        view.delegate = vc
        XCTAssert(view.delegate === vc)
    }

    func testVCTitle() {
        vc.viewDidLoad()
        vc.viewWillAppear(true)
        XCTAssertEqual(vc.title, L10n.ColorPaletteScreen.title)
    }

    func testGetPalette() {
        XCTAssertEqual(presenter.getCurrentPalette().allColors, UIColor.Palette.flashy.allColors)
    }

    // This test is only here to display how to test presenters logic using mock presenters instead of real ones.
    // This is useful when the real presenter needs to make URL calls, or some other async work.
    func testWithMocks() {
        class ColorPalettePresenterMock: ColorPalettePresenting {
            weak var delegate: ColorPalettePresenterDelegate?

            func getCurrentPalette() -> UIColor.Palette {
                .default
            }
        }
        let presenterMock: ColorPalettePresenting! = ColorPalettePresenterMock()
        let vc = ColorPaletteViewController(presenter: presenterMock)

        XCTAssert(presenterMock.delegate === vc)
        XCTAssertEqual(presenterMock.getCurrentPalette().allColors, UIColor.Palette.default.allColors)
    }
}
