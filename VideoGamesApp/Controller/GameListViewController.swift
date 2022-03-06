//
//  GameListViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class GameListViewController: UIViewController {
    
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var bottomTableView: UITableView!
    
    var topGameList = [TopCellModel]()
    var bottomGameList = [BottomCellModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarConfig()
        
        topCollectionView.register(UINib(nibName: "TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topCellIdentity")
        
        bottomTableView.register(UINib(nibName: "BottomTableViewCell", bundle: nil), forCellReuseIdentifier: "bottomCell")
        self.bottomTableView.rowHeight = 223
        
        
        
        
    }
    
    // TabBar ozellestirmeleri
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

extension GameListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCellIdentity", for: indexPath) as! TopCollectionViewCell
        return cell
    }
}

}
