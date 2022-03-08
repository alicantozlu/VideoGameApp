//
//  TopCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {

    @IBOutlet var gameImageView: ImageConfigure!
    @IBOutlet var innerImageView: ImageConfigure!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: GameInfoModel){
        self.gameImageView.loadImage(from: model.background_image!)
        self.innerImageView.loadImage(from: model.background_image!)
        //self.gameImageView.loadFrom(URLAddress: model.background_image!)
        //self.innerImageView.loadFrom(URLAddress: model.background_image!)
    }
}
