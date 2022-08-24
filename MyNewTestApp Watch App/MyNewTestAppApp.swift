/*
 Copyright 2022 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

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
