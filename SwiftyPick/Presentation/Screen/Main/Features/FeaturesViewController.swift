//
//  FeaturesViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import UIKit

class FeaturesViewController: BaseTableViewController {
    private let presenter: FeaturesPresenting

    init(presenter: FeaturesPresenting = FeaturesPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        self.presenter.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setUpNavigation()
    }

    private func setUpNavigation() {
        title = L10n.FeaturesScreen.title
    }
}

// MARK: - TableView

extension FeaturesViewController {
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // Future improvement: Move this to a helper method in an UITableView extension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch presenter.sections[indexPath.section] {
        case .userInterface(let rows):
            switch rows[indexPath.row] {
            case .colorPalette:
                navigationController?.pushViewController(ColorPaletteViewController(), animated: true)
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

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

extension FeaturesViewController: FeaturesPresenterDelegate {}
