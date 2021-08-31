//
//  UIView+AddSubviewTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 31/08/2021.
//

@testable import SwiftyPick
import XCTest

final class AddSubviewTests: XCTestCase {
    private enum Constant {
        static let containerWidth = 200
        static let containerHeight = 400
    }

    private var containerView: UIView!

    override func setUp() {
        super.setUp()

        containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: Constant.containerWidth, height: Constant.containerHeight)
        )
    }

    override func tearDown() {
        defer { super.tearDown() }

        containerView = nil
    }

    func testAddSubviewNoInsets() {
        // Given
        XCTAssertNotNil(containerView)

        let childView = UIView()
        XCTAssertNotNil(childView)

        // The superview is nil until we add it to other view
        XCTAssertNil(childView.superview)
        XCTAssertTrue(childView.translatesAutoresizingMaskIntoConstraints)

        // When
        containerView.addSubview(childView, insets: .none)
        XCTAssertEqual(childView.superview, containerView)
        XCTAssertFalse(childView.translatesAutoresizingMaskIntoConstraints)
        layoutViews([childView, containerView])

        // Then
        // Same size, since we used `.none` as insets
        XCTAssertEqual(childView.frame.size, containerView.frame.size)
    }

    func testAddSubviewWithInsets() {
        // Given
        XCTAssertNotNil(containerView)

        let childView = UIView()
        XCTAssertNotNil(childView)

        // The superview is nil until we add it to other view
        XCTAssertNil(childView.superview)
        XCTAssertTrue(childView.translatesAutoresizingMaskIntoConstraints)

        // When
        containerView.addSubview(childView, insets: .large)
        XCTAssertEqual(childView.superview, containerView)
        XCTAssertFalse(childView.translatesAutoresizingMaskIntoConstraints)
        layoutViews([childView, containerView])

        // Then
        // The new size must be:
        // width = superview.width - (Spacing.large * 2) // Leading and Trailing set to .large
        // height = superview.height - (Spacing.large * 2) // Top and Bottom set to .large
        let containerSize = containerView.frame.size
        XCTAssertEqual(
            childView.frame.size,
            CGSize(
                width: containerSize.width - (Spacing.large.rawValue * 2),
                height: containerSize.height - (Spacing.large.rawValue * 2)
            )
        )
    }

    func testAddSubviewConstrained() {
        // Given
        XCTAssertNotNil(containerView)

        let childView = UIView()
        XCTAssertNotNil(childView)

        // The superview is nil until we add it to other view
        XCTAssertNil(childView.superview)
        XCTAssertTrue(childView.translatesAutoresizingMaskIntoConstraints)

        // When
        containerView.addSubview(
            childView,
            constrainedBy: [
                .top: .small,
                .leading: .xLarge,
                .trailing: .medium,
                .bottom: .none
            ]
        )
        XCTAssertEqual(childView.superview, containerView)
        XCTAssertFalse(childView.translatesAutoresizingMaskIntoConstraints)
        layoutViews([childView, containerView])

        // Then
        // The new size must be:
        // width = superview.width - Spacing.xLarge - Spacing.medium
        // height = superview.height - Spacing.small // Bottom set to .none
        let containerSize = containerView.frame.size
        XCTAssertEqual(
            childView.frame.size,
            CGSize(
                width: containerSize.width - Spacing.xLarge.rawValue - Spacing.medium.rawValue,
                height: containerSize.height - Spacing.small.rawValue
            )
        )
    }

    // We need to call this in order to simulate the viewDidLoad
    private func layoutViews(_ views: [UIView]) {
        views.forEach({
            $0.setNeedsLayout()
            $0.layoutIfNeeded()
        })
    }
}
