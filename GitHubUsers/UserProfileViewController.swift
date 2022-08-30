//
//  UserProfileViewController.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    static let identifier:String = "UserProfileViewController"
    var user:User!
    var profile:UserProfile?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelBio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialDataFromUser()
        getUserProfile()
    }
    
    func setInitialDataFromUser()  {
        self.title = user.login
        let urlString = user.avatarURL
        if !urlString.isEmpty, let url = URL(string: urlString){
            imageView.setImage(from: url)
        }
    }
    
    func getUserProfile() {
        NetworkManager.shared.getGitHubUserProfile(name: user.login) {[weak self] _profile in
            DispatchQueue.main.async {
                self?.profile = _profile
                self?.setUserProfile()
            }
        }
    }
    
    func setUserProfile() {
        labelFollowers.text = "\((profile?.followers ?? 0))"
        labelFollowing.text = "\((profile?.following ?? 0))"
        
        labelName.text = profile?.name ?? ""
        labelCompany.text = profile?.company ?? ""
        labelBio.text = profile?.bio ?? ""
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
