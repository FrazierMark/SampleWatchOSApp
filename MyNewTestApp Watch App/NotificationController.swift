/*
 Copyright 2022 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
    var titleSubject: String!
     var message: String!

    override var body: NotificationView {
        return NotificationView(message: message, title: titleSubject)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

//    override func didReceive(_ notification: UNNotification) {
//        // This method is called when a notification needs to be presented.
//        // Implement it if you use a dynamic notification interface.
//        // Populate your dynamic notification interface as quickly as possible.
//
//    }
    override func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        titleSubject = content.title
        message = content.body
        
    }
}
