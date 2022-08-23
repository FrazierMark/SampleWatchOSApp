//
//  ContentView.swift
//  MyNewTestApp Watch App
//
//  Created by Mark Frazier on 8/17/22.
//


import SwiftUI

struct MenuView: View {
    var body: some View {
//        ZStack(alignment: .bottomTrailing) {
//            Rectangle()
//                .foregroundColor(.clear)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
        
            
            NavigationView {
                List {
                    Section(header: Text("Core")) {
                        NavigationLink(destination: CoreView().navigationBarTitle("Core")) {
                            Text("Core")
                        }
                    }.listRowBackground(Color.red)
                    
                    Section(header: Text("Edge")) {
                        NavigationLink(destination: EdgeView().navigationBarTitle("Edge")) {
                            Text("Edge")
                        }
                        
                        NavigationLink(destination: ConsentView().navigationBarTitle("Consent")) {
                            Text("Consent")
                        }
                        
                        NavigationLink(destination: EdgeIdentityView().navigationBarTitle("Edge Identity")) {
                            Text("Edge Identity")
                        }
                    }.listRowBackground(Color.red)
                    
                    Section(header: Text("Validation")) {
                        NavigationLink(destination: AssuranceView().navigationBarTitle("Assurance")) {
                            Text("Assurance")
                        }
                    }.listRowBackground(Color.red)
                    
                    Section(header: Text("Messaging")) {
                        NavigationLink(destination: MessagingView().navigationBarTitle("Messaging")) {
                            Text("Messaging")
                        }
                    }.listRowBackground(Color.red)
                    
                    Section(header: Text("Optimize")) {
                        NavigationLink(destination: OptimizeView().navigationBarTitle("Optimize")) {
                            Text("Optimize")
                        }
                    }.listRowBackground(Color.red)
                }.navigationBarTitle(Text("Extensions"))
                
            }.overlay(FloatingButtonView())
        }
}

    
    struct MenuView_Previews: PreviewProvider {
        static var previews: some View {
            MenuView()
        }
    }

