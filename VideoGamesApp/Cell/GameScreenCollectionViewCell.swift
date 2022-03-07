//
//  GameScreenCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 7.03.2022.
//

import UIKit

class GameScreenCollectionViewCell: UICollectionViewCell {
    // gameScreenCellIdentifier
    @IBOutlet var sliderImageView: UIImageView!
    
    func comfigure(model: ShortScreenShots){
        self.sliderImageView.loadFrom(URLAddress: model.image!)
    }
}
