//
//  GameInformationModel.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 7.03.2022.
//

import Foundation

enum ErrorList2: Error {
    case noDataAvailable
    case canNotProcessData
}

struct GameInformationRequest{

    let resourceURL: URL

    init(link: String){
        let apiString = link
        guard let apiURL = URL(string: apiString) else { fatalError("Error") }
        self.resourceURL = apiURL
    }

    func getGames(completion: @escaping(Result<GameDescriptionModel, ErrorList2>) -> Void) {
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
