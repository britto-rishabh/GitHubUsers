//
//  NetworkManager.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import Foundation


class NetworkManager{
    static let shared = NetworkManager()
    func getGitHubUsers(lastUserId:Int = 0,onCompletion:@escaping (Array<User>?)->()) {
        if let url = URL(string: "https://api.github.com/users?since=\(lastUserId)"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let jsonData = data {
                    let users = try? JSONDecoder().decode(Array<User>.self, from: jsonData)
                    onCompletion(users)
                }
            }.resume()
        }
    }
    
    func getGitHubUserProfile(name:String, onCompletion:@escaping (UserProfile?)->()) {
        if let url = URL(string: "https://api.github.com/users/\(name)"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let jsonData = data {
                    let userProfile = try? JSONDecoder().decode(UserProfile.self, from: jsonData)
                    onCompletion(userProfile)
                }
            }.resume()
        }
    }
    
}
