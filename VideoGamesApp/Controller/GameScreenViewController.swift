//
//  GameScreenViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class GameScreenViewController: UIViewController{
    
    @IBOutlet var innerImageView: UIImageView!
    @IBOutlet var gameScreenCollectionView: UICollectionView!
    @IBOutlet var gameDescriptionLbl: UILabel!
    @IBOutlet var goBackBtn: UIButton!
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var gameNameLbl: UILabel!
    @IBOutlet var gameReleaseDate: UILabel!
    @IBOutlet var metaValLbl: UILabel!
    @IBOutlet var genreLbl: UILabel!
    @IBOutlet var gameScreenPageController: UIPageControl!
    
    static var gameInfo = [ShortScreenShots]()
    static var backgroundImage = UIImageView()
    static var descriptionText:String = ""
    
    static var gameName:String = ""
    static var releaseDate:String = ""
    static var metaVal:String = ""
    static var genre = [Genres]()
    
    static var currentGame = [GameInfoModel]()
    
    var check:Bool = false{
        didSet{
            let tempArray = LikedGamesViewController.likedGames.filter{ $0 != GameScreenViewController.currentGame[0]}
            LikedGamesViewController.likedGames = tempArray
            likeBtn.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    var currentPage = 0{
        didSet{
            gameScreenPageController.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDescriptionLbl.text = GameScreenViewController.descriptionText
        innerImageView.image = GameScreenViewController.backgroundImage.image
        gameNameLbl.text!.clearName(str: GameScreenViewController.gameName)
        gameReleaseDate.text!.changeDateFormat(str: GameScreenViewController.releaseDate)
        metaValLbl.text = GameScreenViewController.metaVal
        genreLbl.text = configureGenre(gen: GameScreenViewController.genre)
        
        gameNameLbl.text = GameScreenViewController.gameName
        gameNameLbl.text = GameScreenViewController.gameName
        
        if(LikedGamesViewController.likedGames.contains {$0 == GameScreenViewController.currentGame[0]}){
            likeBtn.setImage(UIImage(named: "heart_filled"), for: .normal)
        } else{
            likeBtn.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        func configureGenre(gen: [Genres]) -> (String){
            var text = ""
            for i in 0..<gen.count{
                if(i == 3) {break}
                (i == gen.count-1 || i == 2) ? (text += gen[i].name! + " ") : (text += gen[i].name! + ", ")
            }
            return text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func goBackBtnTapped(_ sender: Any) {
        dismiss(animated: true,completion: nil)
        if(!GameScreenViewController.currentGame.isEmpty){
            GameScreenViewController.currentGame.removeLast()
        }
        
    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        if(likeBtn.currentImage == UIImage(named: "heart")){
            LikedGamesViewController.likedGames.append(GameScreenViewController.currentGame[0])
            likeBtn.setImage(UIImage(named: "heart_filled"), for: .normal)
        } else if (likeBtn.currentImage == UIImage(named: "heart_filled")){

            let alertVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alertIdentity") as! AlertViewController
            alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            alertVC.textMessage = "Remove game from favourite games?"
            self.present(alertVC, animated: true, completion: nil)
        
            alertVC.delegate = self
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension Array {
    func containS<T>(obj: T) -> Bool where T: Equatable {
        return !self.filter({$0 as? T == obj}).isEmpty
    }
}

extension GameScreenViewController: MessageDelegate {
    func sendMessage(check: Bool) {
        self.check = check
    }
}
