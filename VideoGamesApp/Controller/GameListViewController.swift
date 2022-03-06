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
        
        
        
        
        let urlStr = "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1"
        guard let travelURL = URL(string: urlStr) else { return }
        let topList = try? JSONDecoder().decode([TopCellModel].self, from: Data(contentsOf: travelURL))
        //topGameList = topList!
        
        /*let bottomList = try? JSONDecoder().decode([BottomCellModel].self, from: Data(contentsOf: travelURL))
        bottomGameList = bottomList!*/
        
        print("\(topList)")
        
        
        /*
        for i in 0...travels.count-1{
            destinations.append(DestinationModel(destination1: destination1, destination2: destination2, date: date, travelModel: travels[i]))
        }*/
        
        
        
        
        
        
        
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

extension GameListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bottomCell") as! BottomTableViewCell
        return cell
    }
}
