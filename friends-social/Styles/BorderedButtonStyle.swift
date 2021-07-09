//
//  ButtonStyle.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/23/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .foregroundColor(.primary)
            .overlay(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(bgColor, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .animation(.spring())


    }
}
