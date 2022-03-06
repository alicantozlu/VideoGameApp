//
//  GameListViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class GameListViewController: UIViewController {
    
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var bottomCollectionView: UICollectionView!
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = topCollectionView.collectionViewLayout.collectionViewContentSize.height
        myCollectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }*/
    
    var gameList = [GameInfoModel](){
        didSet {
            // Array icerisine veri degisimi olursa tablolar guncellenmesi icin
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
                self.bottomCollectionView.reloadData()
            }
        }
    }
    
    let gameListRequest = GameListRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarConfig()
        
        gameListRequest.getGames { result in
            do {
                self.gameList = try result.get().results!
            }catch let error {
                print(error)
            }
        }
        
        topCollectionView.register(UINib(nibName: "TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topCellIdentity")
        bottomCollectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bottomCellIdentity")
    }
    
    // TabBar Ozellestirmeleri
    private func tabbarConfig() {
        guard let tabBar = tabBarController?.tabBar else { return }
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage() // add this if you want remove tabBar separator
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .clear // here is your tabBar color
        tabBar.layer.backgroundColor = UIColor.clear.cgColor
        let blurEffect = UIBlurEffect(style: .light) // here you can change blur style
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = .flexibleWidth
        tabBar.insertSubview(blurView, at: 0)
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .darkGray
    }
}

extension GameListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView{
            return CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        } else {
            return CGSize(width: self.view.bounds.width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView{
            return 3
        } else {
            return gameList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCellIdentity", for: indexPath) as! TopCollectionViewCell
            
            cell.gameImageView.loadFrom(URLAddress: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")
                    
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCellIdentity", for: indexPath) as! BottomCollectionViewCell
            
            
            
            cell.backgroundColor = .blue
            return cell
        }
    }
}
