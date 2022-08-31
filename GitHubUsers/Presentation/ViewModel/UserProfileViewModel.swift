//
//  UserProfileViewModel.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

class UserProfileViewModel {

    private var user:User!
    private var profile:UserProfile?
    
    var fetching: Observable<Bool> = Observable(false)
    var name: Observable<String> = Observable("")
    var imageUrl: Observable<String> = Observable("")
    var followers: Observable<Int> = Observable(0)
    var following: Observable<Int> = Observable(0)
    var company: Observable<String> = Observable("")
    var blog: Observable<String> = Observable("")
    var note: Observable<String> = Observable("")
    
    init(_ _user: User){
        user = _user
        name.value = user.login
        imageUrl.value = user.avatarURL
    }
    
    func viewDidLoad(){
        loadUserProfile()
    }
    
    func loadUserProfile() {
        NetworkManager.shared.getGitHubUserProfile(name: user.login) {[weak self] _profile in
            if let _profile = _profile{
                self?.profile = _profile
                self?.name.value = _profile.name
                self?.company.value = _profile.company ?? ""
                self?.blog.value = _profile.blog ?? ""
                self?.followers.value = _profile.followers
                self?.following.value = _profile.following
                self?.note.value = self?.user.note ?? ""
            }
        }
    }
    
    func saveNote(note:String){
        PersistenceManager.update(id: Int32(user.id), note: note)
    }
    
}
