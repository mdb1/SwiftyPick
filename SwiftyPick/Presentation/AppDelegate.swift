//
//  AppDelegate.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if ProcessInfo.processInfo.environment[Constants.testPath] != nil {
            // If we are on a test environment, no additional actions are needed.
            return true
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ColorPaletteViewController(presenter: ColorPalettePresenter())
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
