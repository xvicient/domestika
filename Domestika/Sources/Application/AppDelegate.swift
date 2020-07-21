//
//  AppDelegate.swift
//  Domestika
//
//  Created by Xavier on 21/07/2020.
//  Copyright © 2020 xvicient. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var container = DependencyInjectionFactory.make(DependenciesRegistration())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [HomeBuilder(container: container).buildModule()]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

