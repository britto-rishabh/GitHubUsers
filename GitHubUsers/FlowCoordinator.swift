//
//  AppFlowCoordinator.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import UIKit

protocol FlowCoordinator {
    var children: [FlowCoordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
