# Table|Collection View|Cell extensions

The purpose of this document is to explain a couple of helper methods we can use when dealing with UITableView and UITableViewCell objects. 

The same methods could be easily ported to be used with UICollectionView and UICollectionViewCell objects.

## Make Cells Identifiable by default
By checking at [UITableViewCell+ReuseIdentifier.swift](../SwiftyPick/Presentation/Extension/UITableViewCell+ReuseIdentifier.swift) we can see how to add a static `reuseIdentifier` property to UITableViewCells. (This could be easily ported for UICollectionViewCells by conforming it to the `CellIdentifiable` protocol)

```swift
/// Protocol that provides reuseIdentifier property.
protocol CellIdentifiable: AnyObject {
    /// The reuseIdentifier to use when displaying cells on [Table|Collection]Views.
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: CellIdentifiable {
    /// Static property for custom reuse identifier of UITableViewCell.
    /// It just uses the name of the class.
    /// ie: for YourCustomCell.swift: "YourCustomCell"
    internal static var reuseIdentifier: String {
        String(describing: self)
    }
}
```

## Helper method for registering cells
By checking at [UITableView+Register](../SwiftyPick/Presentation/Extension/UITableView+Register.swift) we can see how to add a  `register` method to UITableView that (leveraging generics and the `CellIdentifiable` protocol from above) makes registering cells easier and less error prone. The method will only ask the caller for the type of the cell, and it will take care of registering correctly using the `reuseIdentifier` property.

```swift
/// Protocol that provides a method to register cells in [Table|Collection]Views.
protocol CellRegistering: AnyObject {
    /// Registers a cell that conforms to Identifiable.
    /// - Parameter type: The type of the cell to be registered.
    func register<CellType: CellIdentifiable>(_ type: CellType.Type)
}

extension UITableView: CellRegistering {
    /// Helper method for registering reusable cells of type CellType in a table view.
    /// - Parameter type: Type of the UITableViewCell to be dequeued. ie: YourCustomCell.self.
    ///
    /// Usage:
    /// ```swift
    /// tableView.register(YourCustomCell.self)
    /// ```
    func register<CellType: CellIdentifiable>(_ type: CellType.Type) {
        register(type, forCellReuseIdentifier: CellType.reuseIdentifier)
    }
}
```

## Helper method for dequeing cells
By checking at [UITableView+Dequeue](../SwiftyPick/Presentation/Extension/UITableView+Dequeue.swift) we can see how to add a  `dequeueReusableCell` method to UITableView that (leveraging generics and the `CellIdentifiable` protocol from above) makes dequeueing cells easier and less error prone. The method will take care of failing if the cell wasn't registered and it will make the caller use fewer lines of code.

The same behavior could be achieved if you are using `Xibs` for your cells with small tweaks to the implementation of our `dequeueReusableCell` method.

```swift
/// Protocol that provides a method to dequeue cells in [Table|Collection]Views.
protocol CellDequeuing: AnyObject {
    /// Dequeues a cell of type CellType.
    /// - Parameter type: The type of the cell to be dequeued.
    /// - Parameter indexPath: The indexPath in which to dequeue the cell.
    func dequeueReusableCell<CellType: UITableViewCell>(
        _ type: CellIdentifiable.Type,
        for indexPath: IndexPath
    ) -> CellType
}

extension UITableView: CellDequeuing {
    /// Helper method for dequeuing reusable cells of type CellType that handles errors with a crash.
    /// - Parameter type: Type of the UITableViewCell to be dequeued. ie: YourCustomCell.self.
    /// - Parameter indexPath: IndexPath for the cell.
    ///
    /// Usage:
    /// ```swift
    /// tableView.dequeueReusableCell(YourCustomCell.self, for: indexPath)
    /// ```
    func dequeueReusableCell<CellType: UITableViewCell>(
        _ type: CellIdentifiable.Type,
        for indexPath: IndexPath
    ) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? CellType else {
            fatalError("Couldn't dequeue cell of type: \(CellType.self). Have you registered the cell?")
        }

        return cell
    }
}
```

## Unit testing
By adding just 2 basic tests, we can make sure that our code will continue to behave correctly:
```swift
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
```


## Cherry-Pick the helper methods 🍒
- Check the methods you like in these classes and and add them to your project:

    * [Automatically identifiable cells](../SwiftyPick/Presentation/Extension/UITableViewCell+ReuseIdentifier.swift)
    * [Registering cells](../SwiftyPick/Presentation/Extension/UITableView+Register.swift)
    * [Dequeueing cells](../SwiftyPick/Presentation/Extension/UITableView+Dequeue.swift)

- You could also bring the unit tests:
    * [UITableViewTests](../SwiftyPickTests/Presentation/Extension/UITableViewTests.swift)