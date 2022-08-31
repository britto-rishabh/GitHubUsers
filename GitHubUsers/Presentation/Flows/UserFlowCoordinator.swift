//
//  UserListFlowCoordinator.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import UIKit

class UserFlowCoordinator:FlowCoordinator{
    var children = [FlowCoordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UserListViewController.create(with: UserListViewModel())
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showUserProfile(user: User) {
        let vc = UserProfileViewController.create(with: UserProfileViewModel(user))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
