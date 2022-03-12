//
//  BottomCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var gameNameLbl: UILabel!
    @IBOutlet var gameImageView: ImageConfigure!
    @IBOutlet var ratingLbl: UILabel!
    @IBOutlet var gameRatingStarLbl: UILabel!
    @IBOutlet var outView: UIView!
    @IBOutlet var dayLbl: UILabel!
    @IBOutlet var monthLbl: UILabel!
    @IBOutlet var yearLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gameImageView.addShadow(to: [.bottom, .left, .right], radius: 60, opacity: 0.7, color: UIColor.black.cgColor)

        shadowMaker(UIView: gameImageView)
        func shadowMaker(UIView: UIView){            
            self.layer.borderWidth = 0.0
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowRadius = 5.0
            self.layer.shadowOpacity = 1
            self.layer.masksToBounds = false
        }
    }
    
    func configure(model: GameInfoModel){
        gameNameLbl.text!.clearName(str: model.name!)
        gameImageView.loadImage(from: model.background_image!)
        ratingLbl.text = "\(model.rating!)"
        gameRatingStarLbl.text = String(repeating: "🤍", count: Int(model.rating!))
        changeDateFormatToVertical(str: model.released!, u1: dayLbl, u2: monthLbl, u3: yearLbl)
    }
    
    
    func changeDateFormatToVertical(str: String, u1:UILabel, u2:UILabel, u3:UILabel){
        
        let data = Array(str)
        let year = String(data[2..<4])
        let month = String(data[5..<7])
        let day = String(data[8..<10])
        
        u1.text = "\(day)"
        u2.text = "\(month)"
        u3.text = "\(year)"
        
    }
}
