//
//  OnBoardingView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/2/24.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("launch")
                    .padding()
                       Image("launchImage")
                    .padding()
                Spacer()
                NavigationLink {
                   ProfileSettingView()
                } label: {
                    Text("시작하기")
                        .font(.title3)
                        .bold()
                }
                .asRadiusBlueBackGround(bcColor: .blue)
            }
        }
        
    }
}

#Preview {
    OnBoardingView()
}
