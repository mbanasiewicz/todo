//
//  AppDelegate.swift
//  TTTask
//
//  Created by Maciej Banasiewicz on 11/09/15.
//  Copyright © 2015 Koalapps. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        configureNavigationBarAppearance()
        configureRootViewController()
        return true
    }
    
    func configureNavigationBarAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: TTDefaultFontName, size: 20.0)!
        ]
        appearance.barTintColor = TTBarTintColor
        appearance.tintColor = TTOrange
    }
    
    func configureRootViewController() {
        if let navigationController = self.window?.rootViewController as? UINavigationController {
            if let rootViewController = navigationController.viewControllers.first as? TTRootViewController {
                let stack = TTCoreDataStack()
                rootViewController.coreDataStack = stack
            }
        }
    }
}

