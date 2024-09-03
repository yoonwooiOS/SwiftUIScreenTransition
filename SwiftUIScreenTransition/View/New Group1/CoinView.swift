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
            .navigationTitle("My Money")
        }
        .tint(.black)
        .task {
            do {
                let result = try await UpbitAPI.fetchAllMarket()
                market = result
            } catch {
                
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
            ForEach(filterMarketData, id: \.self) { item in
                rowView(item)
            }
        }
    }
    func rowView(_ item: Market) -> some View {
        NavigationLink {
            coinDetailView(coinData: item)
        } label: {
            HStack() {
                VStack(alignment: .leading) {
                    Text(item.koreanName)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Text(item.market)
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
                Spacer()
                Text(item.englishName)
                    .foregroundStyle(.green)
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
    var coinData: Market
    var body: some View {
        VStack{
            bannerView(data: coinData)
        }
        .navigationTitle("Coin Detail")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            print(coinData)
        }
    }
    func bannerView(data: Market) -> some View {
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
                    
                VStack(alignment: .leading) {
                    Text(data.koreanName)
                        .font(.title)
                    Text(data.market)
                        .font(.title).bold()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(40)
            }
            Spacer()
        }

        
    }
}
#Preview {
    CoinView()
}
