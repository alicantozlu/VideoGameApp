//
//  GameDataModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

struct GameDataModel: Decodable {
    let results: [GameInfoModel]?
}

struct GameInfoModel: Decodable{
    let name: String?
    let released: String?
    let background_image: String?
    let rating: Double?
}
