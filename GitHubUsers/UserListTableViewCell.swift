//
//  UserListTableViewCell.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "UserListTableViewCell"
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUser(user:User) {
        let urlString = user.avatarURL
        if !urlString.isEmpty, let url = URL(string: urlString){
            imageViewAvatar.setImage(from: url)
        }
        
        labelName.text = user.login
        labelDetails.text = user.htmlURL
    }

}
