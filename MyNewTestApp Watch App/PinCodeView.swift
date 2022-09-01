/*
 Copyright 2022 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

import Foundation
import AEPCore
import AEPAssurance
import SwiftUI


struct PinCodeView: View {
    
    @State public var assuranceSessionUrl: String
    
    var body: some View {
        NavigationView {
            MainView(assuranceSessionUrl: assuranceSessionUrl)
        }
    }
}


struct MainView: View {

    @State var assuranceSessionUrl: String
    @State var unLocked = false
    

    var body: some View {
        VStack {
            if unLocked {
                Text("Assurance Connected")
                    .font(.title3)
                    .fontWeight(.medium)
            } else {
                PincodeScreen(assuranceSessionUrl: $assuranceSessionUrl, unLocked: $unLocked)
            }
        }
    }
}


struct PincodeScreen: View {

    @State var pincode = ""
    // Hard Coded Pin from Assurance session
    @AppStorage("assurance_pin") var key = "3860"
    @Binding var assuranceSessionUrl: String
    @Binding var unLocked: Bool
    @State var wrongPincode = false
    let height = WKInterfaceDevice.current().screenBounds.width

    var body: some View {
        VStack {
            Text("Enter Pin to Connect to Assurance")
                .font(.system(size: 9))
                .fontWeight(.medium)

            HStack(spacing: 3) {
                ForEach(0..<4, id: \.self) { index in
                    PincodeView(index: index, pincode: $pincode)
                }
            }

            Text(wrongPincode ? "Incorrect Pin" : "")
                .font(.system(size: 8))
                .foregroundColor(.red)
                .fontWeight(.medium)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 24, maximum: 45), spacing: 3), count: 3)
                , spacing: 4) {

                ForEach(1...9, id: \.self) { value in
                    PincodeButton(value: "\(value)", pincode: $pincode, key: $key, unlocked: $unLocked, wrongPass: $wrongPincode, assuranceSessionUrl: $assuranceSessionUrl)
                }
                PincodeButton(value: "delete.fill", pincode: $pincode, key: $key, unlocked: $unLocked, wrongPass: $wrongPincode, assuranceSessionUrl: $assuranceSessionUrl)
                PincodeButton(value: "0", pincode: $pincode, key: $key, unlocked: $unLocked, wrongPass: $wrongPincode, assuranceSessionUrl: $assuranceSessionUrl)
                PincodeButton(value: "connect", pincode: $pincode, key: $key, unlocked: $unLocked, wrongPass: $wrongPincode, assuranceSessionUrl: $assuranceSessionUrl)
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
                    .frame(width: 5, height: 5)

                if pincode.count > index {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 4, height: 4)
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
        @Binding var assuranceSessionUrl: String

        var body: some View {
            Button(action: setPincode, label: {
                VStack {
                    if (value == "delete.fill") {
                        Image(systemName: "delete.left")
                            .font(.system(size: 12))
                            .foregroundColor(.white)

                    } else if (value == "connect") {
                        Image(systemName: "link.circle")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    } else {
                        Text(value)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                }
            }).frame(width: 30, height: 30)
                .background(Color.red)
                .cornerRadius(10)
        }

        func setPincode() {
            // Check if backspace is pressed
            withAnimation {
                if (value == "delete.fill") {
                    if pincode.count != 0 {
                        pincode.removeLast()
                    }
                } else if (value == "connect") && pincode.count == 4 {
                    self.callAssurance(pin: pincode)
                } else {
                    if pincode.count != 4 {
                        pincode.append(value)

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation {
                                if pincode.count == 4 {
                                    if pincode == key {
                                        self.callAssurance(pin: pincode)
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

        func callAssurance(pin: String) {
            if let url = URL(string: self.assuranceSessionUrl) {
                Assurance.startSession(url: url, pin: pin)
            }
        }
    }
}
