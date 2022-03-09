//
//  BottomCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var gameNameLbl: UILabel!
    @IBOutlet var releaseDateLbl: UILabel!
    @IBOutlet var gameImageView: ImageConfigure!
    @IBOutlet var ratingLbl: UILabel!
    @IBOutlet var innerImageView: ImageConfigure!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: GameInfoModel){
        gameNameLbl.text = model.name
        releaseDateLbl.text = model.released
        gameImageView.loadImage(from: model.background_image!)
        innerImageView.loadImage(from: model.background_image!)
        ratingLbl.text = "\(model.rating!)"
    }
}
