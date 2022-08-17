/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */
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

    @State private var assuranceSessionUrl: String = "sampleappmarkdeeplink://default?adb_validation_sessionid=6b5ae461-8618-4851-bf09-347cf71b02c7"

    var body: some View {

        TextField("Copy Assurance Session URL to here", text: $assuranceSessionUrl)


        NavigationLink(destination: PinCodeView()) {
            Text("PinCodeScreen")
        }.simultaneousGesture(TapGesture().onEnded {
                self.callAssurance()
            })
    }


    func callAssurance() {
        // step-assurance-start
        if let url = URL(string: self.assuranceSessionUrl) {
            Assurance.startSession(url: url)
            // step-assurance-end
        }
    }
}
