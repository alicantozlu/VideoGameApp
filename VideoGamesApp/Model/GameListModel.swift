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

    init(){
        let apiString = "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1"
        guard let apiURL = URL(string: apiString) else { fatalError("Error") }
        self.resourceURL = apiURL
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
}
