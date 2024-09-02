//
//  ProfileSettingView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/2/24.
//

import SwiftUI

struct ProfileSettingView: View {
    @State private var isSheetPresented = false
    @State private var nickName: String = ""
   @State var profileImage = ["profile_0", "profile_1", "profile_2", "profile_3", "profile_4", "profile_5", "profile_6", "profile_7", "profile_8", "profile_9", "profile_10", "profile_11", ].randomElement()
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    isSheetPresented = true
                } label: {
                    Image(profileImage ?? "profile_0")
                        .resizable()
                        .asCameraInProfileView()
                    
                }
                .sheet(isPresented: $isSheetPresented , content: {
                    ProfileImageSettingView()
                })
                .padding(.bottom, 24)
                
                TextField("닉네임을 입력해주세요 :)" ,text: $nickName)
                    .padding(.bottom, 8)
                    .overlay(
                        Rectangle()
                            .frame(height: 1),
                        alignment: .bottom
                    )
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                HStack() {
                    Text("MBTI")
                        .bold()
                        .font(.title3)
                        .frame(width: 80)
                    Spacer()
                    MBTIView()
                        .padding(.top, 48)
                }
                .padding(.horizontal, 8)
                Spacer()
                NavigationLink {
                    CompleteView()
                } label: {
                    Text("완료")
                        .font(.title3)
                        .bold()
                }
                .asRadiusBlueBackGround(bcColor: .gray)
               
            }
            .padding()
            .navigationTitle("PROFILE SETTING")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct MBTIView: View {
    @State private var eiState: Bool = false
    @State private var nsState: Bool = false
    @State private var tsState: Bool = false
    @State private var jpState: Bool = false
    var body: some View {
        VStack {
            Button() {
                eiState = true
            } label: {
                Text("E")
                    .foregroundStyle(eiState ? .white : .gray)
            }
            .asGrayCircleView()
            .background(eiState ? .blue : .clear)
            .clipShape(Circle())
            Button() {
                eiState = false
            } label: {
                Text("I")
                    .foregroundStyle(eiState ? .gray : .white)
            }
            .asGrayCircleView()
            .background(eiState ? .clear : .blue )
            .clipShape(Circle())
        }
        VStack {
            Button() {
                nsState = true
            } label: {
                Text("N")
                    .foregroundStyle(nsState ? .white : .gray)
            }
            .asGrayCircleView()
            .background(nsState ? .blue : .clear)
            .clipShape(Circle())
            Button() {
                nsState = false
            } label: {
                Text("S")
                    .foregroundStyle(nsState ? .gray : .white)
            }
            .asGrayCircleView()
            .background(nsState ? .clear : .blue )
            .clipShape(Circle())
        }
        VStack {
            Button() {
                tsState = true
            } label: {
                Text("T")
                    .foregroundStyle(tsState ? .white : .gray)
            }
            .asGrayCircleView()
            .background(tsState ? .blue : .clear)
            .clipShape(Circle())
            Button() {
                tsState = false
            } label: {
                Text("F")
                    .foregroundStyle(tsState ? .gray : .white)
            }
            .asGrayCircleView()
            .background(tsState ? .clear : .blue )
            .clipShape(Circle())
        }
        VStack {
            Button() {
                jpState = true
            } label: {
                Text("J")
                    .foregroundStyle(jpState ? .white : .gray)
            }
            .asGrayCircleView()
            .background(jpState ? .blue : .clear)
            .clipShape(Circle())
            Button() {
                jpState = false
            } label: {
                Text("P")
                    .foregroundStyle(jpState ? .gray : .white)
            }
            .asGrayCircleView()
            .background(jpState ? .clear : .blue )
            .clipShape(Circle())
        }
    }
}
struct CompleteView: View {
    var body: some View {
        Text("완료되었습니다.")
    }
    
}
#Preview {
    ProfileSettingView()
}
