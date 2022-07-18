//
//  AppDelegate.swift
//  PushyNotification
//
//  Created by Mac on 12/07/22.
//

import UIKit
import Pushy

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var deviceToken: String = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        let pushy = Pushy(UIApplication.shared)
        pushy.toggleInAppBanner(true)
        pushy.register({ (error, deviceToken) in
            // Handle registration errors
            if error != nil {
                return print ("Registration failed: \(error!.localizedDescription)")
            }
            
            // Print device token to console
            print("Pushy device token: \(deviceToken)")
            
            AppDelegate.deviceToken = "\(deviceToken)"
            UserDefaults.standard.set(deviceToken, forKey: "pushyToken")
        })
        
        pushy.setNotificationHandler({ (data, completionHandler) in
            // Print notification payload
            print("Received notification: \(data)")
            
            UIApplication.shared.applicationIconBadgeNumber = 0
            completionHandler(UIBackgroundFetchResult.newData)
        })
        let appWindow = UIApplication.shared.windows.first
        pushy.setNotificationClickListener({ (data) in
            print("Notification Click event received",data)
        })
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


}

