//
//  UIImage+Invert.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import UIKit

extension UIImageView {
func inverseImage() {
    if let image = image {
        let coreImage = UIKit.CIImage(image: image)
        guard let filter = CIFilter(name: "CIColorInvert") else { return }
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        guard let result = filter.value(forKey: kCIOutputImageKey) as? UIKit.CIImage else { return }
        self.image = UIImage(cgImage: CIContext(options: nil).createCGImage(result, from: result.extent)!)
    }
  }
}
