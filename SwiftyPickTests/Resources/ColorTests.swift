//
//  ColorTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 26/08/2021.
//

import XCTest
@testable import SwiftyPick

class ColorTests: XCTestCase {

    typealias ColorTuple = (color: UIColor, hex: String)

    func testColorsExist() {
        UIColor.Palette.default.allColors.forEach {
            XCTAssertNotNil($0, "All colors in the default palette should exist")
        }

        UIColor.Palette.flashy.allColors.forEach {
            XCTAssertNotNil($0, "All colors in the flashy palette should exist")
        }
    }

    /// Test that the hex-value for the colors remains the same.
    /// We want this test to fail if the colors change.
    func testHexadecimals() {
        assertDefaultHexadecimals()
        assertFlashyHexadecimals()

        // Future improvement: Test dark mode hexadecimals.
    }

    private func assertDefaultHexadecimals() {
        let palette = UIColor.Palette.default
        let all = [
            ColorTuple(palette.backgroundMain, "#FFFFFF"),
            ColorTuple(palette.backgroundMid, "#D1D1D5"),
            ColorTuple(palette.backgroundAlt, "#000000"),
            ColorTuple(palette.textPrimary, "#000000"),
            ColorTuple(palette.textAlt, "#FFFFFF"),
            ColorTuple(palette.primary, "#E1352E"),
            ColorTuple(palette.secondary, "#507395"),
            ColorTuple(palette.tertiary, "#76C7D8")
        ]

        assertHexAndColorMatch(all)
    }

    private func assertFlashyHexadecimals() {
        let palette = UIColor.Palette.flashy
        let all = [
            ColorTuple(palette.backgroundMain, "#68E1F3"),
            ColorTuple(palette.backgroundMid, "#3477F6"),
            ColorTuple(palette.backgroundAlt, "#1B1B41"),
            ColorTuple(palette.textPrimary, "#3F3F3F"),
            ColorTuple(palette.textAlt, "#C6C5C6"),
            ColorTuple(palette.primary, "#E1362E"),
            ColorTuple(palette.secondary, "#73D69D"),
            ColorTuple(palette.tertiary, "#DB90D6")
        ]

        assertHexAndColorMatch(all)
    }

    private func assertHexAndColorMatch(_ all: [(color: UIColor, hex: String)]) {
        all.forEach({
            guard let colorHex = $0.color.hexString() else {
                assertionFailure("No hex for color: \($0.color.name ?? "")")
                return
            }
            XCTAssertEqual(colorHex, $0.hex)
        })
    }
}
