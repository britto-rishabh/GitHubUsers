//
//  UserProfileViewModel.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

class UserProfileViewModel {

    
    var user:User!
    var profile:Observable<UserProfile?> = Observable(nil)
    private var getProfile = GetUserProfile()
    var fetching: Observable<Bool> = Observable(false)
    
    init(_ _user: User){
        user = _user        
    }
    
    func viewDidLoad(){
        loadUserProfile()
    }
    
    func loadUserProfile() {
        let parameter = GetUserProfileParameter(name: user.login)
        getProfile.call(parameter: parameter) { [weak self] _profile in
            if let _profile = _profile{
                self?.profile.value = _profile
            }
        }
    }
    
    func saveNote(note:String){
        PersistenceManager.update(id: Int32(user.id), note: note)
    }
    
}
