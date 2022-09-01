//
//  NetworkManager.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 01/09/22.
//

import Foundation

class NetworkManager {
    static func get<T:Codable>(url:URL, completion:@escaping(Result<T, Error>)->Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let jsonData = data {
                if let model = try? JSONDecoder().decode(T.self, from: jsonData){
                    completion(.success(model))
                }
            }
        }.resume()
    }
}
