//
//  AppDelegate.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/21/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let name:String = "hiraafood"
    let logo:String = ""
    var window:UIWindow?
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


    func getUser() -> User {
        var user:User = User()
        user.fullName = NSFullUserName()
        let userDefaults:UserDefaults = UserDefaults.standard
        user.name = userDefaults.string(forKey: "name") ?? ""
        user.fullName = userDefaults.string(forKey: "fullname") ?? ""
        return user
    }
}

