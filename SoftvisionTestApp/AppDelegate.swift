//
//  AppDelegate.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
/// UIApplication window instance
    var window: UIWindow?
    /// Application launch delegate methode
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainController = ViewController()
        // Initalization Root
        window?.rootViewController = UINavigationController(rootViewController: mainController)
        window?.makeKeyAndVisible()
        return true
    }
    
}
