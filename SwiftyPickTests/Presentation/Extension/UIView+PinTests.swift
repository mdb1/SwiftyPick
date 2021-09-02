//
//  UIView+PinTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 31/08/2021.
//

@testable import SwiftyPick
import XCTest

final class PinViewTests: XCTestCase {
    private enum Constant {
        static let containerWidth = 200
        static let containerHeight = 200
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

    func testPinSize() {
        // Given
        XCTAssertNotNil(containerView)

        let image = UIImageView()
        let size = CGSize(width: 50, height: 50)
        containerView.addSubview(image)
        XCTAssertEqual(image.superview, containerView)

        // When
        image.pinSize(size)
        layoutViews([image, containerView])

        // Then
        // Size gets applied correctly
        XCTAssertEqual(image.frame.size, size)
    }

    func testPinWidthAndHeight() {
        // Given
        XCTAssertNotNil(containerView)

        let image = UIImageView()
        let size = CGSize(width: 100, height: 200)
        containerView.addSubview(image)
        XCTAssertEqual(image.superview, containerView)

        // When
        image.pin(width: size.width)
        image.pin(height: size.height)
        layoutViews([image, containerView])

        // Then
        // Size gets applied correctly
        XCTAssertEqual(image.frame.size.width, size.width)
        XCTAssertEqual(image.frame.size.height, size.height)
    }

    func testPinToCenterOfSuperView() {
        // Given
        XCTAssertNotNil(containerView)

        let image = UIImageView()
        let size = CGSize(width: 50, height: 50)
        containerView.addSubview(image)
        XCTAssertEqual(image.superview, containerView)

        // When
        image.pinSize(size)
        image.pinToCenter()
        layoutViews([image, containerView])

        // Then
        XCTAssertEqual(image.center, containerView.center)
    }

    func testPinToCenterOfOtherView() {
        // Given
        XCTAssertNotNil(containerView)

        let otherView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        containerView.addSubview(
            otherView,
            constrainedBy: [
                .top: .large,
                .bottom: .small,
                .leading: .small,
                .trailing: .medium
            ]
        )
        XCTAssertEqual(otherView.superview, containerView)

        let image = UIImageView()
        let size = CGSize(width: 50, height: 50)
        containerView.addSubview(image)
        XCTAssertEqual(image.superview, containerView)

        // When
        image.pinSize(size)
        image.pinToCenter(of: otherView)
        layoutViews([image, containerView, otherView])

        // Then
        XCTAssertEqual(image.center, otherView.center)
        XCTAssertNotEqual(image.center, containerView.center)
    }

    // We need to call this in order to simulate the viewDidLoad
    private func layoutViews(_ views: [UIView]) {
        views.forEach({
            $0.setNeedsLayout()
            $0.layoutIfNeeded()
        })
    }
}
