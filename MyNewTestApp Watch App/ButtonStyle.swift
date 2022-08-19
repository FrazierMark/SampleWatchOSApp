//
//  ButtonStyle.swift
//  MyNewTestApp Watch App
//
//  Created by Mark Frazier on 8/17/22.
//

import UIKit
import SwiftUI
import Foundation

public struct CustomButtonStyle: ButtonStyle {
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .font(.caption)
            .cornerRadius(5)
    }
}

