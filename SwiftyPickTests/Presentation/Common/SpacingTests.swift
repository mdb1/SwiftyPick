//
//  SpacingTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 27/08/2021.
//

@testable import SwiftyPick
import XCTest

final class SpacingTests: XCTestCase {
    private let spacings = [
        Spacing.none,
        Spacing.small,
        Spacing.medium,
        Spacing.large,
        Spacing.xLarge
    ]

    func testAbsoluteValues() {
        XCTAssertEqual(Spacing.none.rawValue, 0)
        XCTAssertEqual(Spacing.small.rawValue, 8)
        XCTAssertEqual(Spacing.medium.rawValue, 16)
        XCTAssertEqual(Spacing.large.rawValue, 24)
        XCTAssertEqual(Spacing.xLarge.rawValue, 32)
    }

    /// All spacings should be divisible by 8.
    func testDivisibleByEight() {
        spacings.forEach { XCTAssertEqual(Int($0.rawValue) % 8, 0) }
    }
}
