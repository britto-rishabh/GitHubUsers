//
//  UserListViewController.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

class UserListViewController: UIViewController, StoryboardInstantiable {
    
    weak var coordinator: UserFlowCoordinator?
    private var viewModel: UserListViewModel!
    private var searchController: UISearchController!
    @IBOutlet weak var tableView: UITableView!
    
    
    static func create(with viewModel: UserListViewModel) -> UserListViewController {
        let vc = UserListViewController.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear(animated)
    }
    

    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func bindViewModel() {
        viewModel.filteredUsers.observe(on: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
}

extension UserListViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredUsers.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let _users = viewModel.filteredUsers.value
        
        let user = _users[indexPath.row]
        var reuseIdentifier = UserListNormalCell.reuseIdentifier
        if user.hasNote {
            reuseIdentifier = UserListWithNoteCell.reuseIdentifier
        }
        let cell:UserListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! UserListTableViewCell
        cell.setUser(user: user, inverted: (indexPath.row % 4 == 3))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _users = viewModel.filteredUsers.value
        let user = _users[indexPath.row]
        coordinator?.showUserProfile(user: user)
    }
    
}

extension UserListViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y + scrollView.frame.size.height
        if position > (scrollView.contentSize.height - 100) {
            viewModel.loadUsers()
        }
    }
}

extension UserListViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        }
        let keyword = searchController.searchBar.text
        viewModel.searchUser(keyword)
    }
}
