//
//  AppDelegate.swift
//  Dream
//
//  Created by Arvind on 29/11/20.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var openedFromUrl = false

    static var shared: AppDelegate {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate
        }
        fatalError("invalid access of AppDelegate")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialSetup(application: application, launchOptions: launchOptions)
        return true
    }
    
 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
         return true

    }
}

extension AppDelegate {
    
    private func initialSetup(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        setUpKeyboardSetup()
        AppRouter.checkAppInitializationFlow()
    }
    
    // Setup IQKeyboard Manager (Third party for handling keyboard in app)
    private func setUpKeyboardSetup() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

