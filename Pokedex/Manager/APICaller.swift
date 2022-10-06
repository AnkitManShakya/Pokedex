//
//  APICaller.swift
//  Pokedex
//
//  Created by Ankit Man Shakya on 01/10/2022.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    func apiCall<T: Codable> (url: URL?, completion: @escaping (T) -> Void ) {
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    
}
