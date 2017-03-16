//
//  AppDelegate.swift
//  apnsTest
//
//  Created by Maksim Kigan on 19/02/17.
//  Copyright © 2017 Maxim Keegan. All rights reserved.
//

import UIKit
import UserNotifications
import PushKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PKPushRegistryDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        application.registerForRemoteNotifications()
        
        let content = UNMutableNotificationContent()
        content.body = "VoIP payload:"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            print("Notification Register Success")
        }

        
        let showMoreAction = UNNotificationAction(identifier: "accept", title: "Accept", options: [])
        let addBalanceAction = UNNotificationAction(identifier: "decline", title: "Decline", options: [])
        let myPlanAction = UNNotificationAction(identifier: "cancel", title: "Cancel", options: [])
        
        let balanceCategory = UNNotificationCategory(identifier: "actions",
                                                     actions: [showMoreAction, addBalanceAction, myPlanAction],
                                                     intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([balanceCategory])
        
        self.voipRegistration()
        
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("APNS Token: \(deviceTokenString)")
        
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("UserInfo \(userInfo)")
    }
    
    
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, forType type: PKPushType) {
        // Register VoIP push token (a property of PKPushCredentials) with server
        let deviceTokenString = credentials.token.reduce("", {$0 + String(format: "%02X", $1)})
        print("VoIP token: \(deviceTokenString)")
    }

    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenForType type: PKPushType) {
        
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, forType type: PKPushType) {
        let content = UNMutableNotificationContent()
        content.body = "VoIP payload: \(payload.dictionaryPayload)"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.0, repeats: false)

        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            print("Notification Register Success")
        }
        
        print("VoIP payload: \(payload.dictionaryPayload)");
    }
    
    func voipRegistration () {
        let mainQueue = DispatchQueue.main
        // Create a push registry object
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
        // Set the registry's delegate to self
        voipRegistry.delegate = self
        // Set the push type to VoIP
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }
}

