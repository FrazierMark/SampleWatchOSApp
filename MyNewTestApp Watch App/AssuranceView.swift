//
//  AssuranceView.swift
//  MyNewTestApp Watch App
//
//  Created by Mark Frazier on 8/17/22.
//

import UIKit
import SwiftUI
// step-assurance-start
import AEPAssurance
// step-assurance-end
import AEPCore

struct AssuranceView: View {
    
    @State var check = false
    @State var answer = false
    
    @State private var assuranceSessionUrl: String = "sampleappmarkdeeplink://default?adb_validation_sessionid=6ad1113f-881c-4b60-8a13-7827659cfefd"
    
    
    var body: some View {
        
        TextField("Copy Assurance Session URL to here", text: $assuranceSessionUrl)
            .font(.system(size: 10))
            .lineLimit(nil)
        
        
        NavigationLink(destination: PinCodeView()) {
            Text("PinCodeScreen")
            //        }.simultaneousGesture(TapGesture().onEnded {
            //                self.callAssurance()
            //            })
        }
        
        
        //    func callAssurance() {
        //       if let url = URL(string: self.assuranceSessionUrl) {
        //           Assurance.startSession(url: url)
        //        }
        //    }
    }
}
