//
//  GameListModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

enum ErrorList: Error {
    case noDataAvailable
    case canNotProcessData
}

struct GameListRequest{

    let resourceURL: URL
    let descriptionResourceURL: URL

    init(link: String){
        let apiString = link
        guard let apiURL = URL(string: apiString) else { fatalError("Error") }
        self.resourceURL = apiURL
        self.descriptionResourceURL = apiURL
    }

    init(slug: String){
        let apiString = "https://api.rawg.io/api/games/\(slug)?key=9718fac0b2cd44f5958788cabc198237"
        guard let apiURL = URL(string: apiString) else { fatalError("Error") }
        self.resourceURL = apiURL
        self.descriptionResourceURL = apiURL
    }
    
    func getGames(completion: @escaping(Result<GameDataModel, ErrorList>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let jsonData = data else {
                
            //TODO: Enumdan donun hataya gore spesifik hata mesaji yazdir
                print("Fetch Error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(GameDataModel.self, from: jsonData)
                completion(.success(games))
                print("Fetch Success")
            }catch{
                print("Json Decode Error")
            }
        }
        dataTask.resume()
    }
    
    func getGameDetail(completion: @escaping(Result<GameDescriptionModel, ErrorList>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let jsonData = data else {
                
            //TODO: Enumdan donun hataya gore spesifik hata mesaji yazdir
                print("Fetch Error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(GameDescriptionModel.self, from: jsonData)
                completion(.success(games))
                print("Fetch Success")
            }catch{
                print("Json Decode Error")
            }
        }
        dataTask.resume()
    }
}
