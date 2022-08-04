
//
//  ExtensionDelegate.swift
//  AEPSampleWatchOSApp WatchKit Extension
//
//  Created by Mark Frazier on 7/21/22.
//

import Foundation
import WatchKit
import UserNotifications

// import AEPAssurance
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



/// Entry point of the watch app.
final class ExtensionDelegate: NSObject, WKExtensionDelegate, UNUserNotificationCenterDelegate {
    
        
  func applicationDidFinishLaunching() {
      

      
      let extensions = [Edge.self, Lifecycle.self, UserProfile.self, Consent.self, Signal.self,AEPIdentity.Identity.self, AEPEdgeIdentity.Identity.self, UserProfile.self, Messaging.self]

      MobileCore.setLogLevel(.trace)
      MobileCore.registerExtensions(extensions, {
          MobileCore.configureWith(appId: "3149c49c3910/937cb8213df9/launch-ac813039a100-development")
          MobileCore.updateConfigurationWith(configDict: ["messaging.useSandbox" : true])
          print("Registered Extension!!")
          MobileCore.lifecycleStart(additionalContextData: ["contextDataKey": "contextDataVal"])
          
      })

      
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
        MobileCore.setPushIdentifier(deviceToken)
    }
    
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
