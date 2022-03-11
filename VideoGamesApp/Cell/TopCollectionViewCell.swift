//
//  TopCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {

    @IBOutlet var gameImageView: ImageConfigure!
    @IBOutlet var gameNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gameImageView.addShadow(to: [.bottom], radius: 50, opacity: 1, color: UIColor.black.cgColor)
        gameImageView.shadowMaker()
    }
    
    func configure(model: GameInfoModel){
        self.gameImageView.loadImage(from: model.background_image!)
        self.gameNameLbl.text?.clearName(str: model.name!)
    }
}
