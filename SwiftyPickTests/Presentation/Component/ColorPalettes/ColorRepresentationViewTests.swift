//
//  ColorRepresentationViewTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 28/08/2021.
//

import XCTest
@testable import SwiftyPick

final class ColorRepresentationViewTests: XCTestCase {

    private var sut: ColorRepresentationView?

    override func tearDown() {
        defer { super.tearDown() }

        sut = nil
    }

    func testInits() {
        // Given
        let defaultPalette: UIColor.Palette = .default
        let flashyPalette: UIColor.Palette = .flashy
        let backgroundMainColor = UIColor.Palette.flashy.backgroundMain
        let backgroundAltColor = UIColor.Palette.default.backgroundAlt
        let textPrimaryColor = UIColor.Palette.default.textPrimary
        let textAltColor = UIColor.Palette.flashy.textAlt

        assertInitsCorrectly(backgroundMainColor, flashyPalette)
        assertInitsCorrectly(backgroundAltColor, defaultPalette)
        assertInitsCorrectly(textPrimaryColor, defaultPalette)
        assertInitsCorrectly(textAltColor, flashyPalette)
    }

    private func assertInitsCorrectly(_ color: UIColor, _ palette: UIColor.Palette) {
        // When
        sut = ColorRepresentationView(color: color, palette: palette)

        // Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.color, color)
        XCTAssertEqual(sut?.backgroundColor, color)
        XCTAssertEqual(sut?.palette.name, palette.name)
        XCTAssertEqual(sut?.nameLabel.text, color.name)
    }
}
