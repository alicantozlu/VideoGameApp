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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: GameInfoModel){
        gameNameLbl.text = clearName(str: model.name!)
        gameImageView.loadImage(from: model.background_image!)
        innerImageView.loadImage(from: model.background_image!)
        ratingLbl.text = "\(model.rating!)"
        gameRatingStarLbl.text = String(repeating: " 👾", count: Int(model.rating!))
        releaseDateLbl.text = changeDateFormat(str: model.released!)
    }
    
    //tarih formatini yil-ay-gun formatindan gun.ay.yil formatina cevir
    func changeDateFormat(str: String) -> (String) {
        let data = Array(str)
        let year = String(data[0..<4])
        let month = String(data[5..<7])
        let day = String(data[8..<10])
        
        return "\(day).\(month).\(year)"
    }
    
    //Oyun isimlerindeki (tarih) ifadelerini kaldir
    func clearName(str:String) -> (String){
        var name:String = ""
        for char in str{
            if (char == "("){
                break
            }
            name += String(char)
        }
        return name
    }
}

