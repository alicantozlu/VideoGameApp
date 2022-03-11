//
//  String+Ex.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 11.03.2022.
//

import Foundation
import UIKit

extension String{
    //tarih formatini yil-ay-gun formatindan gun.ay.yil formatina cevir
    mutating func changeDateFormat(str: String){
        let date = str.components(separatedBy: "-")
        self = "\(date[2]).\(date[1]).\(date[0])"
    }
    
    //Oyun isimlerindeki (tarih) ifadelerini kaldir
    mutating func clearName(str:String){
        var name:String = ""
        for char in str{
            if (char == "("){
                break
            }
            name += String(char)
        }
        self =  name
    }
}
