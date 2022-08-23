//
//  FloatingButtonView.swift
//  MyNewTestApp Watch App
//
//  Created by Mark Frazier on 8/23/22.
//

import Foundation
import SwiftUI


struct FloatingButtonView: View {
    
    @State var connectedStatus1 = false
    @State var connectedStatus2 = false

    var body: some View {
        VStack {
            Spacer()
            if connectedStatus1 {
                MenuItem(icon: "point.3.connected.trianglepath.dotted")
                Text("Assurance Not Connected")
                    .font(.system(size: 10))
                
            }
            if connectedStatus2 {
                MenuItem(icon: "point.3.filled.connected.trianglepath.dotted")
                Text("Assurance Connected")
                    .font(.system(size: 10))
            }
            
            Button(action: {
                self.showStatus()
            }) {
                // Floating Button
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.green)
                    .shadow(color: .black, radius: 0.1, x: 1, y: 1)
            }
        }
    }
    func showStatus() {
        connectedStatus1.toggle()
        connectedStatus2.toggle()
    }
}
        
        struct FloatingButtonView_Previews: PreviewProvider {
            static var previews: some View {
                FloatingButtonView()
            }
        }

struct MenuItem: View {
    
    var icon: String
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(Color.red)
            Image(systemName: icon)
                .imageScale(.small)
                .foregroundColor(.white)
        }
        .shadow(color: .black, radius: 0.3, x: 1, y: 1)
    }
}
