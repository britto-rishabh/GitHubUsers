//
//  UserListTableViewCell.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

protocol UserListTableViewCell:UITableViewCell {
    static var reuseIdentifier:String {get}
    var imageViewAvatar: UIImageView! { get set }
    var labelName: UILabel! { get set }
    var labelDetails: UILabel! { get set }
    func setUser(user:User, inverted:Bool?)
}

extension UserListTableViewCell {
    func setUser(user:User, inverted:Bool?) {
        let urlString = user.avatarURL
        if !urlString.isEmpty, let url = URL(string: urlString){
            imageViewAvatar.setImage(from: url) {[weak self] in
                if let inverted = inverted, inverted == true {
                    self?.imageViewAvatar.inverseImage()
                }
            }
        }
        labelName.text = user.login
        labelDetails.text = user.htmlURL
    }
}
