//
//  AppDelegate.swift
//  TestAppForCoinstats
//
//  Created by Narek Ektubaryan on 22.12.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let initialViewController = FeedListViewController()

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()

        return true
    }
}

