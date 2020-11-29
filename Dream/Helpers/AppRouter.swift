//
//  FlowManager.swift
//  Advisor
//
//  Created by Admin on 15/04/20.
//  Copyright © 2020 AssetLock. All rights reserved.
//

import Foundation
import UIKit

class AppRouter {
    
    private init() {}
    
    // MARK: - Check the application flow for user
    //===========================================
    // Check the initialization flow and redirect user to respective screen like either from HOME or Profile Setup Screen or Welcome screen
    class func checkAppInitializationFlow() {
 
    }
    
    // MARK: - General Method to set Root VC
    //=========================================
    static func setAsWindowRoot(_ navigationController: UINavigationController) {
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.becomeKey()
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
}
