//
//  UserRepository.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

protocol UserRepository{
    func fetchUserList(from id:Int, cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>)->Void)
    func fetchUserProfile(for name:String, cached: @escaping (UserProfile) -> Void, completion: @escaping (Result<UserProfile, Error>)->Void)
}
