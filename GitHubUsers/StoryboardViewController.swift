//
//  AppStoryboard.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import UIKit

protocol StoryboardInstantiable{
    static func instantiate() -> Self
}

extension StoryboardInstantiable where Self:UIViewController{
    static func instantiate() -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
