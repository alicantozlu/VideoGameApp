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
    @IBOutlet var gameRatingStarLbl: UILabel!
    @IBOutlet var blurTop: UIVisualEffectView!
    @IBOutlet var blurBottom: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        blurTop.clipsToBounds = true
        blurTop.layer.cornerRadius = 10
        blurTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        blurBottom.clipsToBounds = true
        blurBottom.layer.cornerRadius = 10
        blurBottom.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func configure(model: GameInfoModel){
        gameNameLbl.clearName(str: model.name!)
        gameImageView.loadImage(from: model.background_image!)
        innerImageView.loadImage(from: model.background_image!)
        ratingLbl.text = "\(model.rating!)"
        gameRatingStarLbl.text = String(repeating: " 🎮", count: Int(model.rating!))
        releaseDateLbl.changeDateFormat(str: model.released!)
    }
}

