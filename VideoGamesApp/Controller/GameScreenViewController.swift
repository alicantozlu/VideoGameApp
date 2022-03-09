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
    @IBOutlet var goBackBtn: UIButton!
    @IBOutlet var likeBtn: UIButton!
    
    static var gameInfo = [ShortScreenShots]()
    static var backgroundImage = UIImageView()
    static var descriptionText:String = ""
    
    static var currentGame = [GameInfoModel]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDescriptionLbl.text = GameScreenViewController.descriptionText
        innerImageView.image = GameScreenViewController.backgroundImage.image
    }
    
    @IBAction func goBackBtnTapped(_ sender: Any) {
        dismiss(animated: true,completion: nil)
        if(!GameScreenViewController.currentGame.isEmpty){
            GameScreenViewController.currentGame.removeLast()
            
        }
    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        count += 1
        if(count % 2 == 0){
            likeBtn.setImage(UIImage(named: "heart_3_64"), for: .normal)
            LikedGamesViewController.likedGames.removeLast()
        }else{
            likeBtn.setImage(UIImage(named: "broken-heart_64"), for: .normal)
            LikedGamesViewController.likedGames.append(GameScreenViewController.currentGame[0])
        }
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
