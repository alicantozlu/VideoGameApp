//
//  GameScreenCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 7.03.2022.
//

import UIKit

class GameScreenCollectionViewCell: UICollectionViewCell {
    // gameScreenCellIdentifier
    @IBOutlet var sliderImageView: ImageConfigure!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowMaker(UIView: sliderImageView)
        func shadowMaker(UIView: UIView){
            self.layer.borderWidth = 0.0
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowRadius = 5.0
            self.layer.shadowOpacity = 1
            self.layer.masksToBounds = false
        }
    }
    func comfigure(model: ShortScreenShots){
        self.sliderImageView.loadImage(from: model.image!)
        //self.sliderImageView.loadFrom(URLAddress: model.image!)
    }
}
