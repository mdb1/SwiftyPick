//
//  BaseViewTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 08/09/2021.
//

@testable import SwiftyPick
import XCTest

class BaseViewTests: XCTestCase {
    private var view: BaseView!

    override func setUp() {
        super.setUp()
        view = BaseView()
    }

    override func tearDown() {
        defer { super.tearDown() }
        view = nil
    }

    func testLoading() {
        XCTAssertFalse(view.isLoading)

        view.isLoading = true
        XCTAssertTrue(view.isLoading)
        XCTAssertFalse(view.loadingContainerView.isHidden)
        XCTAssertFalse(view.activityIndicator.isHidden)

        view.isLoading = false
        XCTAssertFalse(view.isLoading)
        XCTAssertTrue(view.loadingContainerView.isHidden)
        XCTAssertTrue(view.activityIndicator.isHidden)
    }
}
