//
//  NetworkUserRepository.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

class NetworkUserRepository: UserRepository {
    
    let dataSource = NetworkUserDataSource()
    
    func fetchUserList(from id: Int, cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>) -> Void) {
        dataSource.getUserList(
            from: id,
            cached:{
                _ in
            },
            completion:{
                result in
                switch result{
                    case .success(let models):
                    completion(.success(models.map{$0.entity()}))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
        
    }
    
    func fetchUserProfile(for name: String, cached: @escaping (UserProfile) -> Void, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        dataSource.getUserProfile(
            for: name,
            cached:{
                _ in
            },
            completion:{
                result in
                switch result{
                    case .success(let model):
                    completion(.success(model.entity()))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        )
    }
}
