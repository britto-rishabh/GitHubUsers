//
//  UserListWithNoteCell.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import UIKit

class UserListWithNoteCell: UITableViewCell, UserListTableViewCell {
    
    static var reuseIdentifier = "UserListWithNoteCell"
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var imageViewNote: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageViewAvatar.layer.cornerRadius = 35
        self.imageViewNote.image = self.imageViewNote.image?.withRenderingMode(.alwaysTemplate)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        if traitCollection.userInterfaceStyle == .dark {
            imageViewNote.tintColor = UIColor.white
        } else {
            imageViewNote.tintColor = UIColor.black
        }
    }
    
    func setUser(user:User) {
        let urlString = user.avatarURL
        if !urlString.isEmpty, let url = URL(string: urlString){
            imageViewAvatar.setImage(from: url) {[weak self] in
                self?.imageViewAvatar.inverseImage()
            }
        }
        
        labelName.text = user.login
        labelDetails.text = user.url
    }

}
