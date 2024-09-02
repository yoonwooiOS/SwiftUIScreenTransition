//
//  CameraInProfileView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/2/24.
//

import SwiftUI

private struct CameraInProfileView: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.blue, lineWidth: 4)
            )
            .overlay(
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .offset(x: 30, y: 40)
            )
            .overlay (
                Image(systemName: "camera.fill")
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.circle)
                    .offset(x: 30, y: 40)
            )
    }
}

extension View {
    func asCameraInProfileView() -> some View {
        return modifier(CameraInProfileView())
    }
}

