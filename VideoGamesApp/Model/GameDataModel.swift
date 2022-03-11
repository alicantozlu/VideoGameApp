//
//  GameDataModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

struct GameDataModel: Decodable {
    let next: String?
    let results: [GameInfoModel]?
}

struct GameInfoModel: Decodable, Equatable{
    static func == (lhs: GameInfoModel, rhs: GameInfoModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    let slug: String?
    let name: String?
    let released: String?
    let background_image: String?
    let rating: Double?
    let metacritic: Int?
    let genres: [Genres]?
    let short_screenshots: [ShortScreenShots]?
}

struct Genres: Decodable{
    let name: String?
}

struct ShortScreenShots: Decodable{
    let image: String?
}
