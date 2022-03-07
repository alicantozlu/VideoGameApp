//
//  UIImageView+Ex.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                //imageData.jpegData(compressionQuality: 0.5)
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage//.compressImage(with: 500000)
                }
            }
        }
    }
}

/*extension UIImage {

    func compressImage(with maxSizeInBytes: Int ) -> UIImage? {
        if maxSizeInBytes < 0 {
            return nil
        }
        var currentImage:UIImage? = self
        var divideQuality:CGFloat = 1.0
        var imageData = self.jpegData(compressionQuality:divideQuality )
        while imageData!.count > maxSizeInBytes {
            divideQuality = divideQuality/2
            imageData = currentImage?.jpegData(compressionQuality: divideQuality)
        }
        guard let data = imageData else {
            return nil
        }
        currentImage = UIImage(data: data)
        return UIImage(data: (currentImage?.jpegData(compressionQuality: divideQuality)) as! Data)
    }
}*/
