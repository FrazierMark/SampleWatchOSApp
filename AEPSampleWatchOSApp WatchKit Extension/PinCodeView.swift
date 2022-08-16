//
//  PinCodeView.swift
//  AEPSampleWatchOSApp WatchKit App
//
//  Created by Mark Frazier on 8/16/22.
//

import Foundation
import AEPCore
import SwiftUI

struct PinCodeView: View {
    var body: some View {
        NavigationView{
            Home()
        }
        
    }
}

struct PinCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeView()
    }
}

struct Home: View {
    var body: some View{
        
        ZStack {
            // LockScreen
            
            LockScreen()
                .preferredColorScheme(.dark)
        }
    }
}



struct LockScreen: View {
    var body: some View {
        
        VStack{
            HStack{
                Spacer(minLength: 0)
                Menu(content: {
                    
                    Label(title: {Text("Help")},
                          icon: { Image(systemName: "info.circle.fill")})
                    .onTapGesture(perform: {
                        //Perform Actions
                    })
                    
                    Label(title: {Text("Reset Password")},
                          icon: {Image(systemName: "info.fill") })
                    .onTapGesture(perform: {
                        //Perform Actions
                    })
                    
                }) {
                    Image("menu")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 19, height: 19)
                        .foregroundColor(.white)
                        .padding()
                }
            }.padding(.leading)
            
            Image("logo")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.top, 5)
            
            Spacer(minLength: 0)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
