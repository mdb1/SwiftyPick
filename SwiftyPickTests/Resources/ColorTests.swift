//
//  ColorTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 26/08/2021.
//

import XCTest
@testable import SwiftyPick

class ColorTests: XCTestCase {

    func testColorsExist() {
        Asset.Color.allColors.forEach {
            XCTAssertNotNil($0, "All colors in the group should exist")
        }
    }

    func testColorsAssetsDoNotContainImages() {
        XCTAssertTrue(
            Asset.Color.allImages.isEmpty, "Color group should not contain images"
        )
    }

}
