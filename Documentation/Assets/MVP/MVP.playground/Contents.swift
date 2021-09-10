import Foundation
import UIKit
import XCTest

// MARK: - View
protocol YourViewDelegate: AnyObject {
    // Specific method for users tapping on the continue button
    // Follows UIKit API semantics
    func yourView(_ yourView: YourView, didTapContinueButton button: UIButton)
}

final class YourView: UIView {
    weak var delegate: YourViewDelegate?

    func continueButtonTapped() {
        delegate?.yourView(self, didTapContinueButton: UIButton())
    }
}

// MARK: - ViewController
final class YourViewController: UIViewController {
    private lazy var yourView = YourView()

    private let presenter: YourPresenting

    init(presenter: YourPresenting = YourPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        self.presenter.delegate = self
        yourView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        // Here we tell the VC to use `yourView` as it's main view
        self.view = yourView
    }
}

extension YourViewController: YourViewDelegate {
    func yourView(_ yourView: YourView, didTapContinueButton button: UIButton) {
        // When the user tapped the continue button, we start the backend call
        presenter.doBackendCall()
    }
}

extension YourViewController: YourPresenterDelegate {
    func backendCallFinished(error: Error?) {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

// MARK: - Presenter
/// YourPresenterDelegate used by the presenter to communicate with the VC.
protocol YourPresenterDelegate: AnyObject {
    func backendCallFinished(error: Error?)
}

/// YourPresenting protocol used in the VC to communicate with the Presenter.
protocol YourPresenting: AnyObject {
    /// The delegate from the presenter to the vc
    var delegate: YourPresenterDelegate? { get set }

    func doBackendCall()
}

/// The Presenter for YourViewController
final class YourPresenter: YourPresenting {
    // weak to avoid reference cycles
    weak var delegate: YourPresenterDelegate?

    func doBackendCall() {
        // Call the backend (This is an async operation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.backendCallFinished(error: nil)
        }
    }
}

enum YourErrors: Error {
    case backendError
    case anotherError
}

// MARK: - Mocks
final class YourPresenterMock: YourPresenting {
    weak var delegate: YourPresenterDelegate?
    var doBackendCallsCount = 0

    // Here we will mock whatever we want
    func doBackendCall() {
        doBackendCallsCount += 1
        self.delegate?.backendCallFinished(error: YourErrors.backendError)
    }
}

final class ViewControllerMock: YourPresenterDelegate {
    var error: Error?

    func backendCallFinished(error: Error?) {
        self.error = error
    }
}

// MARK: - Tests
final class YourScreenTests: XCTestCase {
    private var presenter: YourPresenterMock!
    private var vc: YourViewController!
    private var view: YourView!

    override func setUp() {
        super.setUp()
        presenter = YourPresenterMock()
        vc = YourViewController(presenter: presenter)
        view = YourView()
        view.delegate = vc
        vc.loadView()
    }

    override func tearDown() {
        defer { super.tearDown() }
        presenter = nil
        vc = nil
        view = nil
    }

    func testVcAndPresenter() {
        XCTAssert(presenter.delegate === vc)
    }

    func testVcAndView() {
        view.delegate = vc
        XCTAssert(view.delegate === vc)
    }

    func testDoBackendCall() {
        XCTAssertEqual(presenter.doBackendCallsCount, 0)
        // This will make the vc call the presenter's doBackendCall method
        view.continueButtonTapped()
        XCTAssertEqual(presenter.doBackendCallsCount, 1)
        // Or call the method directly from the vc
        vc.yourView(view, didTapContinueButton: UIButton())
        XCTAssertEqual(presenter.doBackendCallsCount, 2)
    }

    // Or run the tests by mocking both the presenter and the presenter delegate
    func testPresenterMockedWithVCMocked() {
        let presenterMock = YourPresenterMock()
        let vcMock = ViewControllerMock()
        presenterMock.delegate = vcMock
        XCTAssertEqual(presenterMock.doBackendCallsCount, 0)
        XCTAssertNil(vcMock.error)

        presenterMock.doBackendCall()
        XCTAssertEqual(presenterMock.doBackendCallsCount, 1)
        XCTAssertNotNil(vcMock.error)
        if let error = vcMock.error {
            XCTAssert(error == YourErrors.backendError)
        }
    }
}

// MARK: - Configuration for running tests on Playground
func == (lhs: Error, rhs: Error) -> Bool {
    guard type(of: lhs) == type(of: rhs) else { return false }
    let error1 = lhs as NSError
    let error2 = rhs as NSError
    return error1.domain == error2.domain && error1.code == error2.code
}

class TestObserver: NSObject, XCTestObservation {
    func testCase(
        _ testCase: XCTestCase,
        didFailWithDescription description: String,
        inFile filePath: String?,
        atLine lineNumber: Int
    ) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}

// MARK: - Run the tests
XCTestObservationCenter.shared.addTestObserver(TestObserver())
YourScreenTests.defaultTestSuite.run()
