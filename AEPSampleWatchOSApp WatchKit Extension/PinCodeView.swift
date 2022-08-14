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
    
    @State var unLocked = false
    
    var body: some View{
        
        ZStack {
            // LockScreen
            
            LockScreen()
                .preferredColorScheme(.dark)
        }
    }
}



struct LockScreen: View {
    
    @State var password = ""
    @AppStorage("lock_Password") var key = "1234"
    @Binding var unLocked: Bool
    @State var wrongPassword = false

    
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
            
            Text("Enter Pin to Connect to Assurance")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.top, 4)
            
            HStack(spacing: 22){
                // Passord CVircle view
                
                ForEach(0..<4, id: \.self){index in
                    PasswordView(index: index, password: $password)
                }
                
            }
            .padding(.top, 5)
            
            // KeyPad

            Spacer(minLength: 0)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5){
                //Password Button
                
                ForEach(1...9, id: \.self){value in
                    
                    PasswordButton(value: "\(value)", password: $password, key: $key)
                }
                
                PasswordButton(value: "delete.fill", password: $password, key: $key)
                
                PasswordButton(value: "0", password: $password, key: $key)
            
            }.padding(.bottom)
          
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}


struct PasswordView: View {
    var index: Int
    @Binding var password: String
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(Color.white, lineWidth: 1)
                .frame(width: 4, height: 4)
            
            //checking whether it is typed
            
            if password.count > index{
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 4, height: 4)
            }
        }
    }
}

struct PasswordButton: View {
    var value: String
    
    @Binding var password: String
    @Binding var key: String
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    //Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    
                } else {
                    Text(value)
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }.padding()
            
      
            
        })
        
        
    }
    
    func setPassword(){
        // Check if backspace is pressed
        
        if value.count > 1 {
            
            if password.count != 0 {
                password.append(value)
                
            }
            
        } else {
            
            if password.count != 4 {
                password.append(value)
            }
        }
        
    }
    
}
