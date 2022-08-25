import SwiftUI

struct MainNotificationView: View {
    var text:String! = nil
    var title: String! = nil
    
    var body: some View {
            ZStack{
                VStack {
                    if text != nil {Text(text)}
                    Text(text)
                }
                .padding()
                .background(Color(white: 0.4,opacity:0.6))
                .cornerRadius(5.0)
            }
    }
}

struct MainNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNotificationView()
    }
}

