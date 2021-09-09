//
//  MainViewController.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 09/09/2021.
//

import UIKit

final class MainViewController: UITabBarController {
    private let presenter: MainPresenting

    init(presenter: MainPresenting = MainPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setUp()
    }

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