//
//  CartegoryView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/5/24.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var count: Int
}

struct CartegoryView: View {
    @State private var searchText = ""
    @State var category = ["SF", "가족", "스릴러"]
    @State var categoryList: [Category] = []
    var body: some View {
        NavigationStack {
            List {
                ForEach($categoryList, id: \.id) { $item in
                    HStack() {
                        Image(systemName: "person")
                        Text("\(item.name)(\(item.count))")
                    }
                }
            }
            .searchable(text: $searchText)
            
            .onSubmit(of: .search) {
//                categoryList.append(Category(name: searchText, count: .random(in: 1...100)))
                category.append(searchText)
                print(category)
                }
            .navigationTitle("영화검색")
            .toolbar {
                toolbarContent
            }
        }
//        .task {
//            categoryList = [
//                Category(name: item.randomElement()!, count: .random(in: 1...100)),
//                Category(name: item.randomElement()!, count: .random(in: 1...100)),
//                Category(name: item.randomElement()!, count: .random(in: 1...100)),
//                Category(name: item.randomElement()!, count: .random(in: 1...100)),
//                Category(name: item.randomElement()!, count: .random(in: 1...100))
//            ]
//        }
    }
    //툴바 항목을 정의하는 데 사용되는 속성 래퍼
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItemGroup {
            Button(action: addCategory) {
                Text("추가")
            }
        }
        ToolbarItemGroup(placement: .topBarLeading) {
            Button(action: removeAllCategory) {
                Text("삭제")
                    .foregroundStyle(.pink)
            }
        }
    }
    func addCategory() {
        categoryList.append(Category(name: category.randomElement()!, count: .random(in: 1...100)))
    }
    func removeAllCategory() {
        categoryList.removeAll()
    }
}

#Preview {
    CartegoryView()
}

