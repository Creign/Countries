//
//  AppDelegate.swift
//  Countries
//
//  Created by Excell Nicolas on 1/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CountriesViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

