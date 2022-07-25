
//
//  ExtensionDelegate.swift
//  AEPSampleWatchOSApp WatchKit Extension
//
//  Created by Mark Frazier on 7/21/22.
//

import Foundation
import WatchKit
import UserNotifications
import AEPMessaging
// import AEPAssurance
import AEPCore
//import AEPEdge
//import AEPEdgeIdentity
import AEPMessaging
import AEPSignal
import AEPServices




/// Entry point of the watch app.
final class ExtensionDelegate: NSObject, WKExtensionDelegate, UNUserNotificationCenterDelegate {
        
  func applicationDidFinishLaunching() {
    
    print(WKExtension.shared().isRegisteredForRemoteNotifications)
      
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
      if granted {
          print("Permission Granted")
          
          
          WKExtension.shared().registerForRemoteNotifications()
          print(WKExtension.shared().isRegisteredForRemoteNotifications)
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
        // MobileCore.setPushIdentifier(deviceToken)
    }
    
    
    func applicationDidEnterBackground() {
        print("applicationDidEnterBackground")
        
    }
    func applicationDidBecomeActive() {
        print("applicationDidBecomeActive")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

  }






//
//func application(_ application: WKApplication, didFinishLaunchingWithOptions launchOptions: [WKExtension : Any]?) -> Bool {
//
//    MobileCore.setLogLevel(.debug)
//
//    let appState = application.applicationState;
//
//    let extensions = [
//        //Edge.self,
//        //Consent.self,
//        // Assurance.self,
//        // AEPEdgeIdentity.Identity.self,
//        // AEPIdentity.Identity.self,
//        //UserProfile.self,
//        //Lifecycle.self,
//        Signal.self,
//        Messaging.self
//    ]
//
//    // MobileCore.setLogLevel(.trace)
//    MobileCore.registerExtensions(extensions, {
//        MobileCore.configureWith(appId: "3149c49c3910/301aa57f50b5/launch-387236dc11bc-development")
//        MobileCore.updateConfigurationWith(configDict: ["messaging.useSandbox" : true])
//        print("Registered Extension!!")
//        if appState != .background {
//            MobileCore.lifecycleStart(additionalContextData: ["contextDataKey": "contextDataVal"])
//        }
//    })
//    return true
