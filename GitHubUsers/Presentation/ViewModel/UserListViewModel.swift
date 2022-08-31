//
//  UserListViewModel.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

class UserListViewModel {

    var fetching: Observable<Bool> = Observable(false)
    var users:[User] = []
    var filteredUsers: Observable<[User]> = Observable([])
    var lastUserId: Int = 0
    var reachedEndOfPage: Bool = false
    var searchText: Observable<String> = Observable("")
    
    func viewDidLoad(){
        loadUsers()
    }
    
    var isEmpty: Bool{
        return users.isEmpty
    }
    
    func loadUsers() {
        if self.reachedEndOfPage == false && self.fetching.value == false{
            self.fetching = Observable(true)
            NetworkManager.shared.getGitHubUsers(lastUserId: lastUserId) { [weak self] _users in
                if let _users = _users{
                    if _users.count>0 {
                        self?.users.append(contentsOf: _users)
                        self?.filteredUsers.value = self?.users ?? []
                        self?.lastUserId = _users.last!.id
                    }else{
                        self?.reachedEndOfPage = true
                    }
                }
                self?.fetching = Observable(false)
            }
        }
    }
    
    func searchUser(_ keyword:String?) {
        if let keyword = keyword, !keyword.isEmpty {
            filteredUsers.value = users.filter {
                $0.login.range(of: keyword,options: .caseInsensitive) != nil
            }
        }else{
            filteredUsers.value = users
        }
    }
}
