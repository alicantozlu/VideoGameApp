//
//  bottomCellModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

struct BottomCellModel: Decodable {
    let results: [GameInfo]
}

struct GameInfo: Decodable{
    let name: String
    let released: String
    let background_image: String
    let rating: Double
}
