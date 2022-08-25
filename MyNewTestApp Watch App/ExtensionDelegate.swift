//
//  ExtensionDelegate.swift
//  MyNewTestApp Watch App
//
//  Created by Mark Frazier on 8/17/22.
//


import Foundation
import WatchKit
import UserNotifications

import AEPCore
import AEPEdge
import AEPIdentity
import AEPEdgeIdentity
import AEPMessaging
import AEPLifecycle
import AEPUserProfile
import AEPSignal
import AEPServices
import AEPEdgeConsent
import AEPAssurance
// import AEPOptimize



/// Entry point of the watch app.
final class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    func applicationDidFinishLaunching() {
        let extensions = [Edge.self, Lifecycle.self, UserProfile.self, Consent.self, AEPIdentity.Identity.self, AEPEdgeIdentity.Identity.self, Assurance.self, UserProfile.self,  Signal.self, Messaging.self]
        
        MobileCore.setLogLevel(.trace)
        MobileCore.registerExtensions(extensions, {
            MobileCore.configureWith(appId: "3149c49c3910/937cb8213df9/launch-ac813039a100-development")
            MobileCore.updateConfigurationWith(configDict: ["messaging.useSandbox" : true])
            print("Registered Extension!!")
            MobileCore.lifecycleStart(additionalContextData: ["contextDataKey": "contextDataVal"])
        })
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, nil) in
            
            if granted {
                print("Permission Granted")
                
                WKExtension.shared().registerForRemoteNotifications()
                

                center.removeAllPendingNotificationRequests()
                
                center.getNotificationSettings { (settings) in
                    let auth = settings.authorizationStatus
                    if auth == .authorized || auth == .provisional{
                        let content = UNMutableNotificationContent()
                        
                        content.body = "TEST NOTIFICATION"
                        content.title = "NOTIFICATION TEST"
                        
                        print("I'm printed.")
                        
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        center.add(request, withCompletionHandler: nil)
                    } else {
                        print("Permision not granted")
                    }
                }
            }
        }
    }
    
    func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) {
        print("Failed to Register")
        print(error)
    }
    
    func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data) {
        print("did Register for Remote Notifications called!!")
        print(deviceToken.reduce("") { $0 + String(format: "%02x",
                                                   $1) })
        // Send push token to experience platform
        MobileCore.setPushIdentifier(deviceToken)
    }
    
//    This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
//

    func applicationDidEnterBackground() {
        print("applicationDidEnterBackground")
        MobileCore.lifecyclePause()
        
    }
     
    func applicationDidBecomeActive() {
        print("applicationDidBecomeActive")
        MobileCore.lifecycleStart(additionalContextData: ["contextDataKey": "contextDataVal"])
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillEnterForeground() {
        // step-init-start
        MobileCore.lifecycleStart(additionalContextData: nil)
        // step-init-end
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
  }
