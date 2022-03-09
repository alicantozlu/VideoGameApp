//
//  LikedGamesViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class LikedGamesViewController: UIViewController {

    @IBOutlet var likedGamesCollectionView: UICollectionView!
    static var likedGames = [GameInfoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likedGamesCollectionView.backgroundView = EmptyView()
        
        likedGamesCollectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "likedGamesIdentifier")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [self] in
            self.likedGamesCollectionView.reloadData()
            LikedGamesViewController.likedGames.isEmpty ? (self.likedGamesCollectionView.backgroundView?.isHidden = false) : (self.likedGamesCollectionView.backgroundView?.isHidden = true)
        }
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
    
    
}
