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

