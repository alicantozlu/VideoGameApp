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
    @IBOutlet var gameImageView: UIImageView!
    @IBOutlet var ratingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: GameInfoModel){
        gameNameLbl.text = model.name
        releaseDateLbl.text = model.released
        gameImageView.loadFrom(URLAddress: model.background_image!)
        ratingLbl.text = "\(model.rating!)"
    }
}
