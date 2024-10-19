//
//  Switcher.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation

class Switcher {
    
    static func updateRootVC()
    {
        let status = k.userDefault.bool(forKey: k.session.status)
        
        if status == true {
            let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            let vC = UINavigationController(rootViewController: mainViewController)
            kAppDelegate.window?.rootViewController = vC
            kAppDelegate.window?.makeKeyAndVisible()
        } else {
            let mainViewController = R.storyboard.main().instantiateViewController(withIdentifier: "OnboardingVC") as! OnboardingVC
            let vC = UINavigationController(rootViewController: mainViewController)
            kAppDelegate.window?.rootViewController = vC
            kAppDelegate.window?.makeKeyAndVisible()
        }
    }
}
