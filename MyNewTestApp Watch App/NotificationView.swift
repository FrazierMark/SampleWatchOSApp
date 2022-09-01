
import SwiftUI

struct NotificationView: View {

var message: String?
var title: String?

    var body: some View {
        ScrollView {
            Text(title ?? "New Text TEST")
                .font(.title)
                .fontWeight(.medium)

            Text(message ?? "NEW MESSAGE")
                .font(.title)
                .fontWeight(.medium)
        }
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
