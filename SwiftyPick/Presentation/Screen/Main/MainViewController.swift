//
//  MainViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import UIKit

/// The MainVC of the app, as a child of UITabBarController.
final class MainViewController: UITabBarController {
    private let presenter: MainPresenting

    /// Custom init.
    /// - Parameter presenter: the presenter to be used by the VC
    init(presenter: MainPresenting = MainPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setUp()
    }

    /// Required init by the compiler.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        viewControllers = buildViewControllers()
        tabBar.tintColor = presenter.getCurrentPalette().primary
    }

    private func buildViewControllers() -> [UIViewController] {
        [buildFirstTabVC()]
    }

    private func buildFirstTabVC() -> UIViewController {
        let vc = FeaturesViewController()
        vc.tabBarItem = UITabBarItem(
            title: L10n.FeaturesScreen.title,
            image: UIImage(systemName: "list.star"),
            tag: 0
        )
        return UINavigationController(rootViewController: vc)
    }

    // Future improvement: Build SettingsVC to control things like: AppIcon, ColorPalette, FeatureFlags, etc.
}
