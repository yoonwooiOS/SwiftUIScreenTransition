//
//  UpbitAPI.swift
//  SwiftUIScreenTransition
//
//  Created by 김윤우 on 9/3/24.
//

import Foundation

struct Market: Hashable, Codable {
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

typealias Markets = [Market]
struct UpbitAPI {
    
    private init() { } //async concurrency thorws
    static func fetchAllMarket() async  throws -> Markets {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        let (data, response) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(Markets.self, from: data)
        
        return decodedData
    }
    
    static func fetchAllMarket(completion: @escaping (Markets) -> Void) {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(Markets.self, from: data)
                DispatchQueue.main.async { // 내부적으로 url 세션이 백그라운드로 동작하기 때문에 UI관련 작업은 DispatchQueue로
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
