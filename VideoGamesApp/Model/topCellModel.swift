//
//  topCellModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

struct TopCellModel: Decodable {
    let results: [Image]?
}

struct Image{
    let background_image: String?
}
