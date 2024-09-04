//
//  MyRandomImageView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/4/24.
//

import SwiftUI

struct SectionName: Identifiable, Hashable {
    let id = UUID()
    var sectionName: String
}

struct MyRandomImageView: View {
    @State var sectionNameList: [SectionName] = [
        SectionName(sectionName: "첫번째 섹션"),
        SectionName(sectionName: "두번째 섹션"),
        SectionName(sectionName: "세번째 섹션"),
        SectionName(sectionName: "네번째 섹션")
    ]
    var randomURL: URL? {
        return URL(string: "https://picsum.photos/id/\(Int.random(in: 1...100))/100/150")
    }
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($sectionNameList, id: \.id) { item in
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            Text(item.sectionName.wrappedValue)
                                .font(.title2)
                            HStack {
                                ForEach(1..<10, id: \.self) { _ in
                                    if let url = randomURL {
                                        imageView(url, sectionName: item)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("My Random Image")
        }
    }
}
func imageView(_ url: URL, sectionName: Binding<SectionName>) -> some View {
    NavigationLink {
        DetailView(sectionName: sectionName, imageURL: url)
    } label: {
        CustomAsyncImage(url: url, height: 150, width: 100)
    }
}

#Preview {
    MyRandomImageView()
}

struct DetailView: View {
    @Binding var sectionName: SectionName
    var imageURL: URL
    var body: some View {
        VStack {
            TextField("Section Title", text: $sectionName.sectionName)
                .textFieldStyle(.roundedBorder)
            CustomAsyncImage(url: imageURL, height: 200, width: 350)
            Spacer()
        }
        .navigationTitle("Section 이름 변경")
        .padding()
    }
}

struct CustomAsyncImage: View {
    var url: URL
    var height: CGFloat
    var width: CGFloat
    var body: some View {
        AsyncImage(url: url) { images in
            switch images {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .scaledToFit()
                    .cornerRadius(8)
            case .failure(_):
                Image(systemName: "star")
            @unknown default:
                Image(systemName: "star")
            }
        }
    }
}
