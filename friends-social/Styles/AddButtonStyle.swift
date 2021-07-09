//
//  AddButtonStyle.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/27/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI

struct AddButtonStyle: ButtonStyle {
//    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.yellow.opacity(0.65))
            .foregroundColor(.black)
            .font(.title)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .animation(.spring())


    }
}
