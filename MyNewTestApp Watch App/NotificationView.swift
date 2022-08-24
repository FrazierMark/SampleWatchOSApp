import SwiftUI

struct NotificationView: View {
  // 1
  let message: String
  let title: String

  // 2
  var body: some View {
    ScrollView {
        Text(title)
          .font(.headline)
      Text(message)
        .font(.headline)
    }
  }
}

struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    // 3
    NotificationView(
        message: "TEST MESSAGE",
      title: "SOME TITLE"
    )
  }
}

