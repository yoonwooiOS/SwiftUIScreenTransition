//
//  CoinView.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/3/24.
//

import SwiftUI

struct CoinView: View {
    @State private var searchCoinText = ""
    @State private var market: Markets = []
    @State private var filteredMarket: Markets = []
    private var randomMarket: Market? {
        return market.randomElement()
    }
    var filterMarketData: Markets {
        return searchCoinText.isEmpty ? market : market.filter {$0.koreanName.contains(searchCoinText) || $0.englishName.contains(searchCoinText)}
    }
    var body: some View {
        NavigationView() {
            ScrollView {
                if let randomMarket {
                    bannerView(data: randomMarket)
                }
                listView()
            }
            .searchable(text: $searchCoinText, placement: .navigationBarDrawer, prompt: "코인 이름을 입력해주세요.")
            .onSubmit(of: .search) {
                self.filteredMarket = market.filter {
                                   $0.koreanName.contains(searchCoinText) ||
                                   $0.englishName.contains(searchCoinText)
                               }
            
            }
            .navigationTitle("My Money")
        }
        .tint(.black)
        .task {
            do {
                let result = try await UpbitAPI.fetchAllMarket()
                print("Fetched markets: \(result)")
                market = result
            } catch {
                print("Failed to fetch markets: \(error.localizedDescription)")
            }
           
        }
//        .onAppear { //동기
//                UpbitAPI.fetchAllMarket {data in
//                    self.market = data
//
//        }
    }
    func listView() -> some View {
        LazyVStack {
            ForEach($filteredMarket, id: \.id) { item in
                rowView(item)
            }
        }
    }
    func rowView(_ item: Binding<Market>) -> some View {
        NavigationLink {
            coinDetailView(coinData: item)
        } label: {
            HStack() {
                VStack(alignment: .leading) {
                    Text(item.wrappedValue.koreanName)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Text(item.wrappedValue.market)
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
                Spacer()
                Text(item.wrappedValue.englishName)
                    .foregroundStyle(.green)
                Button {
                    item.isLiked.wrappedValue.toggle()
                } label: {
                    Image(systemName: item.wrappedValue.isLiked ? "star.fill" :"star")
                }
                .padding([.trailing, .leading], 20)


            }
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
        }
    }
    func bannerView(data: Market) -> some View {
       
        ZStack() {
            RoundedRectangle(cornerRadius: 25)
                .fill(.blue)
                .overlay(alignment: .leading) {
                        Circle()
                        .fill(.white).opacity(0.5)
                        .scaleEffect(2)
                        .offset(x: -60, y: 10)
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(height: 150)
                .padding()
                
            VStack(alignment: .leading) {
                Spacer()
                Text(data.koreanName)
                    .font(.callout)
                Text(data.market)
                    .font(.title).bold()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(40)
        }
        
    }
}

struct coinDetailView: View {
    @Binding var coinData: Market
    var body: some View {
        VStack{
            bannerView(data: $coinData)
        }
        .navigationTitle("Coin Detail")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            print(coinData)
        }
    }
    func bannerView(data: Binding<Market>) -> some View {
        VStack {
            ZStack() {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.blue)
                    .overlay(alignment: .leading) {
                            Circle()
                            .fill(.white).opacity(0.5)
                            .scaleEffect(2)
                            .offset(x: -60, y: 10)
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .frame(height: 150)
                    .padding()
                   
                HStack {
                    VStack(alignment: .leading) {
                        Text(data.wrappedValue.koreanName)
                            .font(.title)
                        Text(data.wrappedValue.market)
                            .font(.title).bold()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(40)
                    Button(action: {
                        data.wrappedValue.isLiked.toggle()
                    }, label: {
                        Image(systemName: data.wrappedValue.isLiked ? "star.fill" : "star")
                    })
                    .padding(.trailing, 40)
                }
              
            }
            Spacer()
        }
    }
}
#Preview {
    CoinView()
}
