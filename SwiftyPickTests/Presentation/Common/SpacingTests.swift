//
//  SpacingTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 27/08/2021.
//

import XCTest
@testable import SwiftyPick

final class SpacingTests: XCTestCase {

    static let spacings = [
        Constants.Spacing.none,
        Constants.Spacing.small,
        Constants.Spacing.medium,
        Constants.Spacing.large,
        Constants.Spacing.xLarge
    ]

    func testAbsoluteValues() {
        XCTAssertEqual(Constants.Spacing.none, 0)
        XCTAssertEqual(Constants.Spacing.small, 8)
        XCTAssertEqual(Constants.Spacing.medium, 16)
        XCTAssertEqual(Constants.Spacing.large, 24)
        XCTAssertEqual(Constants.Spacing.xLarge, 32)
    }

    /// All spacings should be divisible by 8.
    func testDivisibleByEight() {
        SpacingTests.spacings.forEach { XCTAssertEqual(Int($0) % 8, 0) }
    }

}
