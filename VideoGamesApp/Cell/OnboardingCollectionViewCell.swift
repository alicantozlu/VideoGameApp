//
//  OnboardingCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 7.03.2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var obImage: UIImageView!
    @IBOutlet var obHeader: UILabel!
    @IBOutlet var obDescription: UILabel!
    
    func configure(model: SlideModel){
        self.obImage.image = UIImage(named: model.image)
        self.obHeader.text = model.header
        self.obDescription.text = model.description
    }
}
