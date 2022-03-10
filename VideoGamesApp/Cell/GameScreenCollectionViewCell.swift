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
    
    func comfigure(model: ShortScreenShots){
        self.sliderImageView.loadImage(from: model.image!)
        //self.sliderImageView.loadFrom(URLAddress: model.image!)
    }
}
