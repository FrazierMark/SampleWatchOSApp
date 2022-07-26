//
//  AEPSampleWatchOSAppApp.swift
//  AEPSampleWatchOSApp WatchKit Extension
//
//  Created by Mark Frazier on 7/20/22.
//

import SwiftUI

@main
struct AEPSampleWatchOSAppApp: App {
    
    @WKExtensionDelegateAdaptor var extensionDelegate: ExtensionDelegate
        
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                MenuView()
            }
        }
    }
}

