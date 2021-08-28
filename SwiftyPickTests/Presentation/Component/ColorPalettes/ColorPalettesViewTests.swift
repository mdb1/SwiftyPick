//
//  ColorPalettesViewTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 28/08/2021.
//

import XCTest
@testable import SwiftyPick

final class ColorPalettesViewTests: XCTestCase {

    private var sut: ColorPalettesView?

    override func tearDown() {
        defer { super.tearDown() }

        sut = nil
    }

    func testInits() {
        // Given
        let defaultPalette: UIColor.Palette = .default
        let flashyPalette: UIColor.Palette = .flashy

        assertInitsCorrectly(defaultPalette)
        assertInitsCorrectly(flashyPalette)
    }

    private func assertInitsCorrectly(_ palette: UIColor.Palette) {
        // When
        sut = ColorPalettesView(palette: palette)

        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.palette.name, palette.name)
        XCTAssertEqual(sut?.stackView.arrangedSubviews.count, palette.allColors.count)
    }
}
