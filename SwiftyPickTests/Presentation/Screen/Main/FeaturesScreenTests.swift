//
//  FeaturesScreenTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 09/09/2021.
//

@testable import SwiftyPick
import XCTest

class FeaturesScreenTests: XCTestCase {
    private var presenter: FeaturesPresenting!
    private var navController: UINavigationController!
    private var vc: FeaturesViewController!

    override func setUp() {
        super.setUp()
        presenter = FeaturesPresenter()
        vc = FeaturesViewController(presenter: presenter)
        navController = UINavigationController(rootViewController: vc)
    }

    override func tearDown() {
        defer { super.tearDown() }
        presenter = nil
        vc = nil
        navController = nil
    }

    func testVcAndPresenter() {
        XCTAssert(presenter.delegate === vc)
    }

    func testVCTitle() {
        vc.viewDidLoad()
        vc.viewWillAppear(true)
        XCTAssertEqual(vc.title, L10n.FeaturesScreen.title)
    }

    func testSections() {
        XCTAssertEqual(presenter.numberOfSections, 1)
    }

    func testRows() {
        XCTAssertEqual(presenter.numberOfRows(in: 0), 1)
    }

    func testTableData() {
        XCTAssertEqual(vc.numberOfSections(in: vc.tableView), presenter.numberOfSections)
    }
}
