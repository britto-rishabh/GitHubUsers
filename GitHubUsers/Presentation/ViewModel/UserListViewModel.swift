//
//  UserListViewModel.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation
import Network
import NotificationBannerSwift

class UserListViewModel {
    
    var fetching: Observable<Bool> = Observable(false)
    var users:[User] = []
    var filteredUsers: Observable<[User]> = Observable([])
    var lastUserId: Int = 0
    var reachedEndOfPage: Bool = false
    var searchText: Observable<String> = Observable("")
    private var getUserList = GetUserList()
    var banner: StatusBarNotificationBanner?
    
    var connected = true
    
    func viewDidLoad(){
        self.loadUsers()
        self.consigureNetworkMonitor()
    }
    
    func viewWillAppear(_ animated: Bool){
        filteredUsers.value = users
    }
    
    func consigureNetworkMonitor() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.connectedBackToInternet()
                }
            } else  if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    self?.disconnectedFromInternet()
                }
            }
        }
    }
    
    func connectedBackToInternet(){
        if !connected {
            self.showStatusBarNotification(message:"Connected",style:.success)
            self.fetching.value = false
            loadUsers()
            connected = true
        }
        
    }
    
    func disconnectedFromInternet(){
        if connected {
            self.showStatusBarNotification(message:"Not Connected",style:.warning)
            connected = false
        }
    }
    
    func showStatusBarNotification(message:String, style:BannerStyle) {
        self.banner?.dismiss()
        self.banner = StatusBarNotificationBanner(title: message, style: style)
        self.banner?.show()
    }
    
    
    var isEmpty: Bool{
        return users.isEmpty
    }
    
    func loadUsers() {
        if self.reachedEndOfPage == false && self.fetching.value == false{
            self.fetching = Observable(true)
            let parameter = GetUserListParameter(id: lastUserId)
            getUserList.call(parameter: parameter) { [weak self] _users in
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
