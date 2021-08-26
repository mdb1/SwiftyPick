//
//  ImageTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 26/08/2021.
//

import XCTest
@testable import SwiftyPick

class ImageTests: XCTestCase {

    func testImagesExist() {
        Asset.Image.allImages.forEach {
            XCTAssertNotNil($0, "All images in the group should exist")
        }
    }

    func testImagesAssetsDoNotContainColors() {
        XCTAssertTrue(
            Asset.Image.allColors.isEmpty, "Image group should not contain colors"
        )
    }

}
