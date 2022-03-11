//
//  ImageConfigure.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 9.03.2022.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
class ImageConfigure: UIImageView {
    
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .white)
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError("Error")
        }

        image = nil
        addSpinner()
        
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeSpinner()
            return
        }
        
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else {
                print("couldnt load image from url: (url)")
                return
            }
            
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        
        task.resume()
    }
    func addSpinner(){
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
        
    }
    func removeSpinner(){
        spinner.removeFromSuperview()
    }
}
