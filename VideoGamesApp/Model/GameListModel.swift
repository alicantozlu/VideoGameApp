//
//  GameListModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 6.03.2022.
//

import Foundation

enum GameListError: Error {
    case noDataAvailable
    case canNotProcessData
}
struct GameListRequest{

    let resourceURL: URL

    init(){
        let gameListString = "https://api.rawg.io/api/games?key=9718fac0b2cd44f5958788cabc198237"

        //MARK: 1. Create URL
        guard let gameListURL = URL(string: gameListString) else {
            fatalError("Error")
        }
        self.resourceURL = gameListURL
        //performRequest(url: resourceURL)
    }

    func getGames(completion: @escaping(Result<GameModel, GameListError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let jsonData = data else {
                print("çekilemedi")
                return
            }

            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(GameModel.self, from: jsonData)
                completion(.success(games))
                print("başarılı")
            }catch{
                print("json decode errror")
            }
        }
        dataTask.resume()
    }
}
