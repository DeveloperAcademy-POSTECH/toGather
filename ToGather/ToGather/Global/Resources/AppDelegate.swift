//
//  AppDelegate.swift
//  ToGather
//
//  Created by DaeSeong on 2022/08/11.
//

import SwiftUI
import UIKit
import FirebaseMessaging
class AppDelegate: NSObject, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {
    
    var userToken: String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        Messaging.messaging().delegate = self
          UNUserNotificationCenter.current().delegate = self
        
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, _ in
              guard success else {
                  return
              }
              
              print("Success in APNS registry")
          }
          application.registerForRemoteNotifications()
        
        
      
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            self.userToken = token
            print("Token: \(token)")
        }
    }
}


