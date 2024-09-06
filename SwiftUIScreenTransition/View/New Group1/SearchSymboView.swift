//
//  SearchSymboView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/3/24.
//

import SwiftUI

struct SFSymbols: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let Image: String
    var isLiked: Bool
}


struct SearchSymboView: View {
    @State private var searchText = ""
     var filterSymbols: [SFSymbols] {
        return searchText.isEmpty ? symbolData : symbolData.filter{ $0.name.contains(searchText)}
    }
    @State var symbolData = [
        SFSymbols(name: "star", Image: "star", isLiked: false),
        SFSymbols(name: "xmark", Image: "xmark", isLiked: false),
        SFSymbols(name: "magnifyingglass", Image: "magnifyingglass", isLiked: false),                   
        SFSymbols(name: "heart", Image: "heart", isLiked: false),
        SFSymbols(name: "menucard", Image: "menucard", isLiked: false),
        SFSymbols(name: "house", Image: "house", isLiked: false),
        SFSymbols(name: "record", Image: "record.circle", isLiked: false),
        SFSymbols(name: "squareandpencil", Image: "square.and.pencil", isLiked: false),
        SFSymbols(name: "paperplane", Image: "paperplane.fill", isLiked: false),
        SFSymbols(name: "message", Image: "message", isLiked: false),
     
    ]

    var body: some View {
        NavigationView {
            VStack {
                List(filterSymbols, id: \.self) { sysmbol in
                    CustomCell(data: sysmbol)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "검색하실 코인을 입력해주세요.")
            
            .navigationTitle("Search")
        }
    }
}

struct CustomCell: View {
    @State var data: SFSymbols
    var body: some View {
        HStack {
            Image(systemName: data.Image)
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(width: 36, height: 36)
                .foregroundColor(.green)
                
            VStack(alignment: .leading) {
                Text("Imagename: \(data.Image)")
                    .font(.subheadline).bold()
                Text("Name:\(data.name)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(8)
            Spacer()
            Button(action: {
                data.isLiked.toggle()
            }, label: {
                Image(systemName: data.isLiked ? "star.fill" : "star")
                    .foregroundColor(.blue)
            })
        }
    }
    
}

#Preview {
    SearchSymboView()
}
