//
//  UserListNormalCell.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import UIKit

class UserListNormalCell: UITableViewCell, UserListTableViewCell {

    static var reuseIdentifier = "UserListNormalCell"
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageViewAvatar.layer.cornerRadius = 35
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
