//
//  UITableViewTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 18/09/2021.
//

@testable import SwiftyPick
import XCTest

final class UITableViewTests: XCTestCase {
    private final class CustomTableCellMock: UITableViewCell {}

    func testReuseIdentifier() {
        XCTAssertEqual(UITableViewCell.reuseIdentifier, "UITableViewCell")
        XCTAssertEqual(CustomTableCellMock.reuseIdentifier, "CustomTableCellMock")
    }

    func testRegisterAndDequeue() {
        // Given
        let tableView = UITableView()

        // When
        tableView.register(CustomTableCellMock.self)
        tableView.register(UITableViewCell.self)

        let mockCell = tableView.dequeueReusableCell(CustomTableCellMock.self, for: IndexPath(item: 0, section: 0))
        let uiCell = tableView.dequeueReusableCell(UITableViewCell.self, for: IndexPath(item: 1, section: 0))

        // Then
        XCTAssertNotNil(mockCell)
        XCTAssertTrue(type(of: mockCell) == CustomTableCellMock.self)
        XCTAssertNotNil(uiCell)
        XCTAssertTrue(type(of: uiCell) == UITableViewCell.self)
    }
}
