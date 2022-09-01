//
//  UserProfileViewController.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit
import UIView_Shimmer

extension UIImageView: ShimmeringViewProtocol { }
extension UILabel: ShimmeringViewProtocol { }

class UserProfileViewController: UIViewController, StoryboardInstantiable{
    
    weak var coordinator: UserFlowCoordinator?
    
    static let identifier:String = "UserProfileViewController"
    var viewModel:UserProfileViewModel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelBio: UILabel!
    @IBOutlet weak var textAreaNote: UITextView!
    @IBOutlet weak var buttonSave: UIButton!

    
    static func create(with viewModel: UserProfileViewModel) -> UserProfileViewController {
        let vc = UserProfileViewController.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seupUI()
        self.showShimmer()
        self.bindViewModel()
        self.viewModel.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear(animated)
    }
    
    func seupUI() {
    
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        
        textAreaNote.layer.cornerRadius = 10
        textAreaNote.layer.borderWidth = 1
        textAreaNote.layer.borderColor = UIColor.gray.cgColor
        textAreaNote.contentInset = .init(top: 15, left:15, bottom: 15, right: 15)
        buttonSave.layer.cornerRadius = 10
    }
    
    func bindViewModel() {
        self.title = viewModel.user.login
        self.labelName.text = viewModel.user.login
        let imageUrl = viewModel.user.avatarURL
        if !imageUrl.isEmpty, let url = URL(string: imageUrl){
            self.imageView.setImage(from: url)
        }
        self.textAreaNote.text = viewModel.user.note
        
        viewModel.profile.observe(on: self, observerBlock: {[weak self] profile in
            
            if let _profile = profile{
                self?.hideShimmer()
                
                let company = _profile.company ?? ""
                let blog = _profile.blog ?? ""
                let followers = _profile.followers
                let following = _profile.following
                
                self?.labelFollowers.text = "\(followers)"
                self?.labelFollowing.text = "\(following)"
                self?.labelCompany.text = company
                self?.labelBio.text = blog
            }
        })
    }
    
    func showShimmer()  {
        view.setTemplateWithSubviews(true, animate: false)
    }
    
    func hideShimmer()  {
        view.setTemplateWithSubviews(false)
    }
    
    
    @IBAction func buttonActionSave(_ sender: Any) {
        if let note = textAreaNote.text, note.isEmpty == false {
            viewModel.saveNote(note: note)
        }
    }
}
