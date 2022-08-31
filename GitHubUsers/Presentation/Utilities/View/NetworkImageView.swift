//
//  ImageLoader.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, placeholder: UIImage? = nil, onCompletion: (()->Void)? = {}) {
        self.image = placeholder
        
        ImageCache.shared.image(for: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                    onCompletion?()
                }
            case .failure:
                break
            }
        }
    }
}
