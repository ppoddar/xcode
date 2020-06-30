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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("=========== Starting application =======")
        window?.tintColor = .white
        Server.singleton.get(url: "/connect") {
            result in
                switch result {
                case .success:
                    print("established server contact")
                    return
                case .failure(let error) :
                    print("failed to establish server contact")
                    print(error)

                }
            }
        
        if #available(iOS 13, *) {
            print("iOS 13 is available. SceenDelegate will open the window")
        } else {
            
        }
        // Initialize the window
//        window = UIWindow.init(frame: UIScreen.main.bounds)
                
        // Allocate memory for an instance of the 'MainViewController' class
 //       let mainViewController = WelcomeViewController()
        
        // Set the root view controller of the app's window
 //       window!.rootViewController = mainViewController
        
        // Make the window visible
  //      window!.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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

