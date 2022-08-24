//
//  MyNewTestAppApp.swift
//  MyNewTestApp Watch App
//
//  Created by Mark Frazier on 8/17/22.
//

import SwiftUI

@main
struct MyNewTestApp_Watch_AppApp: App {
    //@WKExtensionDelegateAdaptor var extensionDelegate: ExtensionDelegate
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self)
      private var extensionDelegate

      private let local = LocalNotifications()
    
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                MenuView()
            }
        }
    }
}
