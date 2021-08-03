//
//  AppDelegate.swift
//  task-NumberingGame
//
//  Created by Domagoj Bunoza on 03.08.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) ->Bool{
            
            let viewController = ViewController()
            let navigationViewController = UINavigationController(rootViewController: viewController)
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navigationViewController
            window?.makeKeyAndVisible()
            
            return true
        }


}

