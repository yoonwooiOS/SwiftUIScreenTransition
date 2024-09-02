//
//  RadiusBlueBackGround.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/2/24.
//

import SwiftUI

private struct RadiusBlueBackGround: ViewModifier {
    let bgColor: Color
    func body(content: Content) -> some View {
        content
            .asForeground(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(width: 350, height: 40)
            .background(bgColor)
            .clipShape(.capsule)
    }
}

extension View {
    func asRadiusBlueBackGround(bcColor: Color) -> some View {
        return modifier(RadiusBlueBackGround(bgColor: bcColor))
    }
}
