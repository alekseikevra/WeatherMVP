//
//  AppDelegate.swift
//  MVP
//
//  Created by Aleksei Kevra on 21.11.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let view = ModuleBuilder.buildModule()
        let navigationController = UINavigationController(rootViewController: view)

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

