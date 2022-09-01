//
//  UserDataSource.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

protocol UserDataSource{
    func getUserList(from id:Int, cached: @escaping ([UserModel]) -> Void, completion: @escaping (Result<[UserModel], Error>)->Void)
    func getUserProfile(for name:String, cached: @escaping (UserProfileModel) -> Void, completion: @escaping (Result<UserProfileModel, Error>)->Void)
}
