//
//  TopCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {

    @IBOutlet var gameImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: GameInfoModel){
        self.gameImageView.loadFrom(URLAddress: model.background_image!)
    }
}
