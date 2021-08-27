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
            ColorTuple(palette.backgroundMid, "#D1D1D6"),
            ColorTuple(palette.backgroundAlt, "#000000"),
            ColorTuple(palette.textPrimary, "#000000"),
            ColorTuple(palette.textAlt, "#FFFFFF"),
            ColorTuple(palette.primary, "#F6131E"),
            ColorTuple(palette.secondary, "#467599"),
            ColorTuple(palette.tertiary, "#57CADB")
        ]

        assertHexAndColorMatch(all)
    }

    private func assertFlashyHexadecimals() {
        let palette = UIColor.Palette.flashy
        let all = [
            ColorTuple(palette.backgroundMain, "#06E4F6"),
            ColorTuple(palette.backgroundMid, "#007AFF"),
            ColorTuple(palette.backgroundAlt, "#1C1B44"),
            ColorTuple(palette.textPrimary, "#000000"),
            ColorTuple(palette.textAlt, "#C7C7C7"),
            ColorTuple(palette.primary, "#F6131E"),
            ColorTuple(palette.secondary, "#46D999"),
            ColorTuple(palette.tertiary, "#E98DDB")
        ]

        assertHexAndColorMatch(all)
    }

    private func assertHexAndColorMatch(_ all: [(color: UIColor, hex: String)]) {
        all.forEach({
            guard let colorHex = $0.color.hexString() else {
                return assertionFailure("No hex for color: \($0.color.name ?? "")")
            }
            XCTAssertEqual(colorHex, $0.hex)
        })
    }
}
