//
//  GetUserProfile.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 01/09/22.
//

import Foundation

class GetUserProfile: UserCase {
    
    typealias T = UserProfile
    typealias Parameter = GetUserProfileParameter
    
    let repository = NetworkUserRepository()
    
    func call(parameter: GetUserProfileParameter, completion: @escaping (UserProfile?) -> Void){
        
        repository.fetchUserProfile(
            for: parameter.name,
               cached:{_ in },
               completion: {
                   result in
                   switch result {
                   case .success(let profile):
                       completion(profile)
                   case .failure(_):
                       completion(nil)
                   }
               }
        )
    }
}

struct GetUserProfileParameter {
    let name:String
}
