//
//  topCellModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

struct TopCellModel: Decodable {
    let results: [Results]
}

struct Results: Decodable{
    let background_image: String
}
