//
//  SceneDelegate.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/21/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       weak var semaphore:DispatchSemaphore? = DispatchSemaphore(value: 1)
        var errorOcuured:Error?
        Server.singleton.get(url: "/connect") {
            result in
            switch result {
            case .success:
                return
            case .failure(let error) :
                NSLog("error at init \(String(describing:error)) ")
                errorOcuured = error
            }
            semaphore?.signal()
        }
        let timeout:DispatchTime = DispatchTime.now().advanced(by: DispatchTimeInterval.seconds(10))
        NSLog("waiting \(String(describing:timeout)) to start")
        semaphore?.wait(timeout: timeout)
        
        if (errorOcuured == nil) {
            NSLog("========== Starting main application ==========")
            guard let windowScene = (scene as? UIWindowScene) else {
                NSLog("*ERROR: can not get window")
                return
            }
            self.window = UIWindow(windowScene: windowScene)
            let navbar = UINavigationController()
            //let main = WelcomeViewController()
            let main = TestDataFactory.viewController(.delivery)
            NSLog("Showing \(type(of:main)) ")
            navbar.viewControllers = [main]
            self.window?.rootViewController = navbar
            self.window?.makeKeyAndVisible()        } else {
            let alertBox = UIAlertController(title: "Init",
                    message: String(describing: errorOcuured),
                    preferredStyle: .alert)
            self.window?.rootViewController?
                .show(alertBox, sender: self)
        }
     }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

