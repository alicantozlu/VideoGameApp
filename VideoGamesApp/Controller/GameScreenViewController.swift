//
//  GameScreenViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    @IBOutlet var innerImageView: UIImageView!
    @IBOutlet var gameScreenCollectionView: UICollectionView!
    @IBOutlet var gameDescriptionLbl: UILabel!
    
    static var gameInfo = [ShortScreenShots]()
    static var descriptionText:String = ""
    
    /*var gameInfo = [ShortScreenShots](){
        didSet{
            DispatchQueue.main.async {
                self.gameScreenCollectionView.reloadData()
            }
        }
    }*/
    
    //var slug:String = "grand-theft-auto-v"
    //let gameInformationRequest = GameInformationRequest(link: "https://api.rawg.io/api/games/grand-theft-auto-v?key=9718fac0b2cd44f5958788cabc198237")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameDescriptionLbl.text = GameScreenViewController.descriptionText
        /*gameInformationRequest.getGames { result in
            do {
                self.gameInfo = try result.get().short_screenshots!
            }catch let error {
                print(error)
            }
        }*/
    }
}

extension GameScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameScreenViewController.gameInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameScreenCellIdentifier", for: indexPath) as! GameScreenCollectionViewCell
        cell.comfigure(model: GameScreenViewController.gameInfo[indexPath.row])
        return cell
    }
}
