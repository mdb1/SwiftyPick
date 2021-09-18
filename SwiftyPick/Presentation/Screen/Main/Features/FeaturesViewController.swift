//
//  FeaturesViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import UIKit

/// VC that holds the list of features of the app
class FeaturesViewController: BaseTableViewController {
    private let presenter: FeaturesPresenting

    /// Custom init.
    /// - Parameter presenter: the presenter for the vc
    init(presenter: FeaturesPresenting = FeaturesPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        self.presenter.delegate = self
    }

    /// Required init by the compiler.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }

    /// Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setUpNavigation()
    }

    private func setUpNavigation() {
        title = L10n.FeaturesScreen.title
    }
}

// MARK: - TableView
/// Conformance to tableView delegate and dataSource
extension FeaturesViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // Future improvement: Move this to a helper method in an UITableView extension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }

    /// Asks the data source to return the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }

    /// Tells the data source to return the number of rows in a given section of a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }

    /// Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Future improvement: Move this to a helper method in an UITableView extension
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }

        switch presenter.sections[indexPath.section] {
        case .userInterface(let rows):
            cell.textLabel?.text = rows[indexPath.row].cellTitle
        }

        return cell
    }

    /// Tells the delegate a row is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch presenter.sections[indexPath.section] {
        case .userInterface(let rows):
            switch rows[indexPath.row] {
            case .colorPalette:
                navigationController?.pushViewController(ColorPaletteViewController(), animated: true)
            }
        }
    }

    /// Asks the delegate for the height to use for a row in a specified location.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    /// Asks the delegate for a view to display in the header of the specified section of the table view.
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Future improvement: Move this to a component (and make it prettier 😅)
        let containerView = UIView()
        containerView.backgroundColor = view.backgroundColor
        let label = UILabel()
        label.text = presenter.sections[section].title
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        containerView.addSubview(label, insets: .medium)
        return containerView
    }
}

/// Conformance to the FeaturesPresenterDelegate
extension FeaturesViewController: FeaturesPresenterDelegate {}
