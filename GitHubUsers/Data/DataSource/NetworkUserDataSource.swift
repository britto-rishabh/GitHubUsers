//
//  UserNetworkDataSource.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

class NetworkUserDataSource: UserDataSource {
    
    func getUserList(from id: Int, cached: @escaping ([UserModel]) -> Void, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        if let url = URL(string: BASE_URL + USER_API_PATH + "?since=\(id)"){
            NetworkManager.get(url: url) { result in
                completion(result)
            }
        }
    }
    
    func getUserProfile(for name: String, cached: @escaping (UserProfileModel) -> Void, completion: @escaping (Result<UserProfileModel, Error>) -> Void) {
        if let url = URL(string: BASE_URL + USER_API_PATH + "/\(name)"){
            NetworkManager.get(url: url) { result in
                completion(result)
            }
        }
        
    }
}
