//
//  ImageCache.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    func image(for url: URL, completionHandler: @escaping (_ result: Result<UIImage?, Error>) -> Void) {
        if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
            completionHandler(Result.success(imageInCache))
        }else{
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completionHandler(Result.failure(error))
                }else{
                    let image = UIImage(data: data!)
                    self.cache.setObject(image!, forKey: url.absoluteString as NSString)
                    completionHandler(Result.success(image))
                }
            }.resume()
        }
        
    }
}
