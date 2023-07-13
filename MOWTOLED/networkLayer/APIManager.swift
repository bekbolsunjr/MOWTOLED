//
//  APIManager.swift
//  MOWTOLED
//
//  Created by bekbolsun on 2023-07-12.
//

import Foundation
class APIManager {
    
    static let shared = APIManager()
    
    let urlString = "https://nu.vsepoka.ru/api/search?origin=MOW&destination=LED"
    
    func getTiket(completion: @escaping ([Tiket]) -> Void) {
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            if let tiketData = try? JSONDecoder().decode(TiketData.self, from: data) {
                print(tiketData.results)
                completion(tiketData.results)
            } else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
}
