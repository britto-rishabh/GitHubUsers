//
//  UserProfileViewController.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

class UserProfileViewController: UIViewController, StoryboardInstantiable {
    
    weak var coordinator: UserFlowCoordinator?
    
    static let identifier:String = "UserProfileViewController"
    var viewModel:UserProfileViewModel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelFollowers: UILabel!
    @IBOutlet weak var labelFollowing: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCompany: UILabel!
    @IBOutlet weak var labelBio: UILabel!
    @IBOutlet weak var textAreaNote: UITextView!
    
    
    static func create(with viewModel: UserProfileViewModel) -> UserProfileViewController {
        let vc = UserProfileViewController.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        viewModel.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.name.observe(on: self, observerBlock: { name in
            self.title = name
            self.labelName.text = name
        })
        
        viewModel.imageUrl.observe(on: self, observerBlock: { imageUrl in
            if !imageUrl.isEmpty, let url = URL(string: imageUrl){
                self.imageView.setImage(from: url)
            }
        })
        
        viewModel.followers.observe(on: self, observerBlock: { followers in
            self.labelFollowers.text = "\(followers)"
        })
        
        viewModel.following.observe(on: self, observerBlock: { following in
            self.labelFollowing.text = "\(following)"
        })
        
        viewModel.company.observe(on: self, observerBlock: { company in
            self.labelCompany.text = company
        })
        
        viewModel.blog.observe(on: self, observerBlock: { blog in
            self.labelBio.text = blog
        })
        
        viewModel.note.observe(on: self, observerBlock: { note in
            self.textAreaNote.text = note
        })
    }
    
    @IBAction func buttonActionSave(_ sender: Any) {
        if let note = textAreaNote.text, note.isEmpty == false {
            viewModel.saveNote(note: note)
        }
    }
}
