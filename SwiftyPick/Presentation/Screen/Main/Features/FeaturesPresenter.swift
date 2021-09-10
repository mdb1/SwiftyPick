//
//  FeaturesPresenter.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import Foundation

// swiftlint:disable class_delegate_protocol
// ColorPalettePresenterDelegate conforms to AnyObject through Presentable.
/// FeaturesPresenterDelegate used by the presenter to communicate with the VC.
protocol FeaturesPresenterDelegate: Presentable {}

/// FeaturesPresenting protocol used in the VC to communicate with the Presenter.
protocol FeaturesPresenting: TableDataSourceProvider {
    /// The delegate from the presenter to the vc
    var delegate: FeaturesPresenterDelegate? { get set }

    /// Sections to be displayed in the table
    var sections: [FeaturesSection] { get }
}

/// The Presenter for the Features Screen.
final class FeaturesPresenter: BasePresenter, FeaturesPresenting {
    weak var delegate: FeaturesPresenterDelegate?

    var sections: [FeaturesSection] = []

    override init() {
        super.init()

        sections = buildSections()
    }

    private func buildSections() -> [FeaturesSection] {
        [.userInterface([.colorPalette])]
    }
}

extension FeaturesPresenter {
    var numberOfSections: Int {
        sections.count
    }

    func numberOfRows(in section: Int) -> Int {
        switch sections[section] {
        case .userInterface(let rows):
            return rows.count
        }
    }
}
