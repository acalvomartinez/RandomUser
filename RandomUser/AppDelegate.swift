//
//  AppDelegate.swift
//  RandomUser
//
//  Created by Antonio Calvo on 29/06/2017.
//  Copyright © 2017 Random User Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        installRootViewControllerIntoWindow(window)
        configureWindow()
        configureNavigationBarStyle()
        window?.makeKeyAndVisible()
        return true
    }
    
    //MARK: Private
    
    fileprivate func installRootViewControllerIntoWindow(_ window: UIWindow?) {
        let viewController = ServiceLocator.sharedInstance.provideRootViewController()
        window?.rootViewController = viewController
    }
    
    fileprivate func configureWindow() {
        window?.backgroundColor = UIColor.windowBackgroundColor
    }
    
    fileprivate func configureNavigationBarStyle() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor.navigationBarColor
        navigationBarAppearance.tintColor = UIColor.navigationBarTitleColor
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.navigationBarTitleColor
        ]
    }
}

