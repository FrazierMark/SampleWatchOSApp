// import SwiftUI

//struct NotificationView: View {
//  // 1
//  let message: String
//  let title: String
//
//  // 2
//  var body: some View {
//    ScrollView {
//        Text("MARK PURPOSAES!!!!")
//          .font(.headline)
//      Text("MARK PURPOSAES!!!!")
//        .font(.headline)
//    }
//  }
//}
//
//struct NotificationView_Previews: PreviewProvider {
//  static var previews: some View {
//    // 3
//    NotificationView(
//        message: "FINAL TEST MESSAGE",
//      title: "SOME FINAL TITLE"
//    )
//  }
//}
//

import SwiftUI

struct NotificationView: View {
    
    var message: String = ""
    var title: String = ""
    
    var body: some View {
        MainNotificationView(text: message, title: title)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
