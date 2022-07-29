/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */
import SwiftUI
import UserNotifications

import AEPCore
import AEPEdgeIdentity
import AEPMessaging
import AEPServices


struct MessagingView: View {
    @State var currentEcid: String = ""
    @State var currentIdentityMap: IdentityMap?

    let LOG_PREFIX = "MessagingViewController"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
            }.padding().onAppear() {
                MobileCore.track(state: "Messaging", data:nil)
            }
            
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Current ECID:")
                Button(action: {
                    print("THis is called")
                    print(currentEcid)
                    Identity.getExperienceCloudId { ecid, error in
                        currentEcid = ecid ?? "Error"
                    } }) {

                    Text("Get ExperienceCloudId")
                }.buttonStyle(CustomButtonStyle())
                Text(currentEcid)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Push Messaging").font(.title).bold()
                    Text("Messaging SDK setup is complete with ECID:")
                    Text(currentEcid)
                    Spacer(minLength: 15)
                    Text("Click a button below to schedule a notification:")
                    Text("(clicking on a notification demonstrates how to handle a notification response)").italic()
                    Button("Sample notification") {
                        scheduleNotification()
                    }.buttonStyle(CustomButtonStyle())
                    Button("Sample notification with custom actions") {
                        scheduleNotificationWithCustomAction()
                    }.buttonStyle(CustomButtonStyle())
                    Spacer(minLength: 15)
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("In-App Messaging (beta)").font(.title).bold()
                    Text("Click a button below to trigger an in-app message:")
                    Button("Sample fullscreen message") {
                        MobileCore.track(action: "sampleAppFullscreen", data: nil)
                    }.buttonStyle(CustomButtonStyle())
                    Button("Sample modal message") {
                        MobileCore.track(action: "sampleAppModal", data: nil)
                    }.buttonStyle(CustomButtonStyle())
                    Button("Sample top banner") {
                        MobileCore.track(action: "sampleAppBannerTop", data: nil)
                    }.buttonStyle(CustomButtonStyle())
                    Button("Sample bottom banner") {
                        MobileCore.track(action: "sampleAppBannerBottom", data: nil)
                    }.buttonStyle(CustomButtonStyle())
                    Spacer()
                }
            }
        }
    }
    }

//    func updateEcid() {
//        Identity.getExperienceCloudId { (ecid, err) in
//            if ecid == nil {return}
//            ecidState = ecid ?? ""
//        }
//    }
    
    // MARK: - Creation of local notifications for demonstrating notification click-throughs
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Simple notification"
        content.body = "This notification does not have any custom actions."
        content.sound = UNNotificationSound.default
        
        /// the structure of `userInfo` is the same as you'd see with an actual push message.
        /// the values are made up for demonstration purposes.
//        content.userInfo = [
//            "_xdm": [
//                "cjm": [
//                    "_experience": [
//                        "customerJourneyManagement": [
//                            "messageExecution": [
//                                "messageExecutionID": "00000000-0000-0000-0000-000000000000",
//                                "messageID": "message-1",
//                                "journeyVersionID": "someJourneyVersionId",
//                                "journeyVersionInstanceId": "someJourneyVersionInstanceId"
//                            ]
//                        ]
//                    ]
//                ]
//            ]
//        ]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let identifier = "Simple local notification identifier"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        print("Call Sample Notifications")
        notificationCenter.add(request)
    }
    
    func scheduleNotificationWithCustomAction() {
        let content = UNMutableNotificationContent()
        content.title = "Custom actions notification"
        content.body = "This notification has custom actions. Click and hold on the notification to show the custom action buttons."
        content.categoryIdentifier = "MEETING_INVITATION"
        
        /// the structure of `userInfo` is the same as you'd see with an actual push message.
        /// the values are made up for demonstration purposes.
        content.userInfo = [
            "_xdm": [
                "cjm": [
                    "_experience": [
                        "customerJourneyManagement": [
                            "messageExecution": [
                                "messageExecutionID": "11111111-1111-1111-1111-111111111111",
                                "messageID": "message-2",
                                "journeyVersionID": "someJourneyVersionId",
                                "journeyVersionInstanceId": "someJourneyVersionInstanceId"
                            ]
                        ]
                    ]
                ]
            ]
        ]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let identifier = "Custom action local notification identifier"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Define the custom actions
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                                                title: "Accept",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                 title: "Decline",
                                                 options: UNNotificationActionOptions(rawValue: 0))
        
        // Define the notification type
//        let meetingInviteCategory = UNNotificationCategory(identifier: "MEETING_INVITATION",
//                                                           actions: [acceptAction, declineAction],
//                                                           intentIdentifiers: [],
//                                                           hiddenPreviewsBodyPlaceholder: "",
//                                                           options: .customDismissAction)
//
//        // Register the notification type.
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.setNotificationCategories([meetingInviteCategory])
//        notificationCenter.add(request, withCompletionHandler: handleNotificationError(_:))
    }
    
    func handleNotificationError(_ error: Error?) {
        if let error = error {
            print("An error occurred when adding a notification: \(error.localizedDescription)")
        }
    }


struct MessaginView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingView()
    }
}