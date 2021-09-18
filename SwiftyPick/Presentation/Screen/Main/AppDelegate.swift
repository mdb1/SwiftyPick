//
//  AppDelegate.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/08/2021.
//

import UIKit

/// AppDelegate class for the app
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// The backdrop for your app’s user interface and the object that dispatches events to your views.
    var window: UIWindow?

    /// Tells the delegate that the launch process is almost done and the app is almost ready to run.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainViewController()
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
