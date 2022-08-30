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
    
    @State private var assuranceSessionUrl: String = "sampleappmarkdeeplink://default?adb_validation_sessionid=b13d7462-7cdb-41b2-a3dd-5ca8ae05cccf"
    
    var body: some View {
        
        TextField("Copy Assurance Session URL to here", text: $assuranceSessionUrl)
            .font(.system(size: 10))
            .lineLimit(nil)
        
        
        NavigationLink(destination: PinCodeView(assuranceSessionUrl: assuranceSessionUrl)) {
            Text("Pincode")
                
        }.background(Color.red)
            .clipShape(Capsule())
    }
}
