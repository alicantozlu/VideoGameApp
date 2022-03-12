//
//  LikedGamesViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class LikedGamesViewController: UIViewController {
    
    @IBOutlet var likedGamesCollectionView: UICollectionView!
    static var likedGames = [GameInfoModel](){
        didSet{
            UserProfileViewController.gameCount = String(likedGames.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emptyView = EmptyView()
        emptyView.changeText(text: "LIST IS EMPTY")
        emptyView.changeImage(imageName: "among7R")
        likedGamesCollectionView.backgroundView = emptyView
        
        likedGamesCollectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "likedGamesIdentifier")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.likedGamesCollectionView.reloadData()
        LikedGamesViewController.likedGames.isEmpty ? (self.likedGamesCollectionView.backgroundView?.isHidden = false) : (self.likedGamesCollectionView.backgroundView?.isHidden = true)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

extension LikedGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LikedGamesViewController.likedGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "likedGamesIdentifier", for: indexPath) as! BottomCollectionViewCell
        cell.configure(model: LikedGamesViewController.likedGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GameScreenViewController.gameInfo = LikedGamesViewController.likedGames[indexPath.row].short_screenshots!
        GameScreenViewController.backgroundImage.loadFrom(URLAddress: LikedGamesViewController.likedGames[indexPath.row].background_image!)
        GameScreenViewController.currentGame.append(LikedGamesViewController.likedGames[indexPath.row])
        
        let gameDetailRequest = GameListRequest(slug: LikedGamesViewController.likedGames[indexPath.row].slug!)
        gameDetailRequest.getGameDetail { result in
            do {
                GameScreenViewController.descriptionText = try result.get().description_raw!
                DispatchQueue.main.async {
                    let gameScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameScreenIdentifier")
                    gameScreenVC.modalPresentationStyle = .fullScreen
                    gameScreenVC.modalTransitionStyle = .flipHorizontal
                    self.present(gameScreenVC, animated: true, completion: nil)
                }
            }catch let error {
                print(error)
            }
        }
    }
}
