//
//  topCellModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

struct TopCellModel: Decodable {
    let count: Int?
    //let results: [Result]?
}

struct Result: Decodable{
    let background_image: String?
}
