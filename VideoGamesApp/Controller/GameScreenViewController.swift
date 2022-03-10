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
    @IBOutlet var gameNameLbl: UILabel!
    @IBOutlet var gameReleaseDate: UILabel!
    @IBOutlet var metaValLbl: UILabel!
    @IBOutlet var genreLbl: UILabel!
    
    static var gameInfo = [ShortScreenShots]()
    static var backgroundImage = UIImageView()
    static var descriptionText:String = ""
    
    static var gameName:String = ""
    static var releaseDate:String = ""
    static var metaVal:String = ""
    static var genre = [Genres]()
    
    static var currentGame = [GameInfoModel]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDescriptionLbl.text = GameScreenViewController.descriptionText
        innerImageView.image = GameScreenViewController.backgroundImage.image
        gameNameLbl.clearName(str: GameScreenViewController.gameName)
        gameReleaseDate.changeDateFormat(str: GameScreenViewController.releaseDate)
        metaValLbl.text = GameScreenViewController.metaVal
        genreLbl.text = configureGenre(gen: GameScreenViewController.genre)
        
        gameNameLbl.text = GameScreenViewController.gameName
        gameNameLbl.text = GameScreenViewController.gameName
        
        func configureGenre(gen: [Genres]) -> (String){
            var text = ""
            for i in 0..<gen.count{
                text += gen[i].name! + " "
            }
            return text
        }
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
            likeBtn.setImage(UIImage(named: "heart"), for: .normal)
            LikedGamesViewController.likedGames.removeLast()
        }else{
            likeBtn.setImage(UIImage(named: "heart_filled"), for: .normal)
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
