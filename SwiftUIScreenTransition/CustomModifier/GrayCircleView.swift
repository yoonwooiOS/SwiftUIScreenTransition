//
//  GrayCircleView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/2/24.
//

import SwiftUI

private struct GrayCircleView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.gray)
            .frame(width: 40, height: 40)
            .overlay(
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}

extension View {
    func asGrayCircleView() -> some View {
        return modifier(GrayCircleView())
    }
}
