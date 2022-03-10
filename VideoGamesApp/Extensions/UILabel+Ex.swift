//
//  UILabel+Ex.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 10.03.2022.
//

import UIKit

extension UILabel{
    //tarih formatini yil-ay-gun formatindan gun.ay.yil formatina cevir
    func changeDateFormat(str: String) {
        let data = Array(str)
        let year = String(data[0..<4])
        let month = String(data[5..<7])
        let day = String(data[8..<10])
        
        self.text = "\(day).\(month).\(year)"
    }
    
    //Oyun isimlerindeki (tarih) ifadelerini kaldir
    func clearName(str:String){
        var name:String = ""
        for char in str{
            if (char == "("){
                break
            }
            name += String(char)
        }
        self.text = name
    }
}
