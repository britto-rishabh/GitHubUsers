//
//  GetUserList.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 01/09/22.
//

import Foundation

class GetUserList: UserCase {
    
    typealias T = [User]
    typealias Parameter = GetUserListParameter
    
    let repository = NetworkUserRepository()
    
    func call(parameter: GetUserListParameter, completion: @escaping ([User]?) -> Void){
        
        repository.fetchUserList(
            from: parameter.id,
               cached:{_ in },
               completion: {
                   result in
                   switch result {
                   case .success(let users):
                       completion(users)
                   case .failure(_):
                       completion(nil)
                   }
               }
        )
    }
}

struct GetUserListParameter {
    let id:Int
}
