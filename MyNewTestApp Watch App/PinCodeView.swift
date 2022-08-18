//
//  PinCodeView.swift
//  MyNewTestApp Watch App
//
//  Created by Mark Frazier on 8/17/22.
//

import Foundation
import AEPCore
//import AEPAssurance
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
        
        VStack {
            // LockScreen
            if unLocked{
                Text("Assurance Connected")
                    .font(.title3)
                    .fontWeight(.medium)
            } else {
                LockScreen(unLocked: $unLocked)
            }
        }
        .preferredColorScheme(unLocked ? .light : .dark)
    }
}



struct LockScreen: View {
    
    @State var pincode = ""
    @AppStorage("lock_Pincode") var key = "1234"
    @Binding var unLocked: Bool
    @State var wrongPincode = false
    let height = WKInterfaceDevice.current().screenBounds.width
    
    
    var body: some View {
        
        
        VStack{
                Text("Enter Pin to Connect to Assurance")
                    .font(.system(size: 10))
                    .fontWeight(.medium)
                    .padding(.top, 1)
                
                HStack(spacing: 2){
                    // Pincode Circle view
                    
                    ForEach(0..<4, id: \.self){index in
                        PincodeView(index: index, pincode: $pincode)
                    }
                    
                }
                
                Text(wrongPincode ? "Incorrect Pin" : "")
                    .font(.system(size: 8))
                    .foregroundColor(.red)
                    .fontWeight(.medium)
            

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 24, maximum: 29)), count: 3)
                ,spacing: 3){
                
                    ForEach(1...9, id: \.self){value in
                        PincodeButton(value: "\(value)", pincode: $pincode, key: $key, unlocked: $unLocked, wrongPass: $wrongPincode)
                    }
                    PincodeButton(value: "delete.fill", pincode: $pincode, key: $key, unlocked: $unLocked, wrongPass: $wrongPincode)
                    PincodeButton(value: "0", pincode: $pincode, key: $key, unlocked: $unLocked, wrongPass: $wrongPincode)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    
    
    struct PincodeView: View {
        var index: Int
        @Binding var pincode: String
        
        var body: some View {
            
            VStack {
                Circle()
                    .stroke(Color.white, lineWidth: 1)
                    .frame(width: 4, height: 4)
                
                //checking whether it is typed
                
                if pincode.count > index{
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 2, height: 2)
                }
            }
        }
    }
    
    struct PincodeButton: View {
        var value: String
        
        @Binding var pincode: String
        @Binding var key: String
        @Binding var unlocked: Bool
        @Binding var wrongPass: Bool
        
        var body: some View{
            
            Button(action: setPincode, label: {
                
                VStack{
                    
                    if value.count > 1{
                        Image(systemName: "delete.left")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                        
                    } else {
                        Text(value)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }
            }).frame(width: 25, height: 25)
            .background(Color.red)
            .cornerRadius(10)

        }
        
        func setPincode(){
            // Check if backspace is pressed
            
            withAnimation{
                if value.count > 1 {
                    if pincode.count != 0 {
                        pincode.removeLast()
                    }
                } else {
                    if pincode.count != 4 {
                        pincode.append(value)
                        
                        // Delay Animation....
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation{
                                if pincode.count == 4 {
                                    if pincode == key {
                                        unlocked = true
                                    } else {
                                        wrongPass = true
                                        pincode.removeAll()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
        
    }
}
