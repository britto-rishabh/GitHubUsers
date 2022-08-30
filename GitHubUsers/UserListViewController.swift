//
//  UserListViewController.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    var users: Array<User> = []
    var filteredUsers: Array<User> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        getUsers()
        // Do any additional setup after loading the view.
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func getUsers() {
        NetworkManager.shared.getGitHubUsers(page: 0) { [weak self] _users in
            print(_users ?? "No users")
            DispatchQueue.main.async {
                self?.users = _users ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UserListViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredUsers.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var _users = users
        if searchController.isActive {
            _users = filteredUsers
        }
        
        let cell:UserListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.reuseIdentifier) as! UserListTableViewCell
        
        let user = _users[indexPath.row]
        cell.setUser(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var _users = users
        if searchController.isActive {
            _users = filteredUsers
        }
        let user = _users[indexPath.row]
        showUserProfile(user)
    }
    
    func showUserProfile(_ user:User) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: UserProfileViewController.identifier) as! UserProfileViewController
        viewController.user = user
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UserListViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        let keyword = searchController.searchBar.text
        searchUser(keyword)
    }
    
    func searchUser(_ keyword:String?) {
        if let keyword = keyword, !keyword.isEmpty {
            filteredUsers = users.filter {
                $0.login.range(of: keyword,options: .caseInsensitive) != nil
            }
        }else{
            filteredUsers = users
        }
        self.tableView.reloadData()
    }
}
