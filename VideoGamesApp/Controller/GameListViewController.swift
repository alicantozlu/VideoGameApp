//
//  GameListViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class GameListViewController: UIViewController {
    
    @IBOutlet var gameSearchBar: UISearchBar!
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var gamePageController: UIPageControl!
    @IBOutlet var bottomCollectionView: UICollectionView!
    @IBOutlet var innerStackView: UIStackView!
    
    var currentPage = 0 {
        didSet{
            gamePageController.currentPage = currentPage
        }
    }
    
    var gameList = [GameInfoModel](){
        didSet {
            // Array icerisine veri degisimi olursa tablolar guncellenmesi icin
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
                self.bottomCollectionView.reloadData()
            }
            for i in 0...2{
                topList.append(gameList[i])
            }
            for i in 2...19{
                bottomList.append(gameList[i])
            }
        }
    }
    var topList = [GameInfoModel]()
    var bottomList = [GameInfoModel]()
    
    let gameListRequest = GameListRequest(link: "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1")
    
    var filteredGames = [GameInfoModel]()
    var isFiltering: Bool = false
    
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
        
        //let backgroundEmpty = EmptyView()
        bottomCollectionView.backgroundView = EmptyView()
        bottomCollectionView.backgroundView?.isHidden = true
        
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
    
    //Hucre boyutu
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView{
            return CGSize(width: self.view.bounds.width, height: 220)
        } else {
            return CGSize(width: self.view.bounds.width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        GameScreenViewController.gameInfo = bottomList[indexPath.row+1].short_screenshots!
        GameScreenViewController.backgroundImage.loadFrom(URLAddress: bottomList[indexPath.row+1].background_image!)
        //bottomList[indexPath.row+1]
        
        let gameDetailRequest = GameListRequest(slug: bottomList[indexPath.row+1].slug!)
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
    
    // Hucre Sayisi - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == topCollectionView{
            return topList.count
        } else {
            if isFiltering {
                innerStackView.isHidden = true
                return filteredGames.count
            }
            return gameList.count-3
        }
    }
    
    //Hucre icerigi - DataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCellIdentity", for: indexPath) as! TopCollectionViewCell
            cell.configure(model: topList[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCellIdentity", for: indexPath) as! BottomCollectionViewCell
            
            if isFiltering {
                cell.configure(model: filteredGames[indexPath.row])
            } else {
                cell.configure(model: gameList[indexPath.row+3])
            }
            
            return cell
        }
    }
    
    //Pagecontroller Hareketi
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension GameListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText == ""){
            isFiltering = false
            innerStackView.isHidden = false
            bottomCollectionView.backgroundView?.isHidden = true
            bottomCollectionView.reloadData()
            return
        }
        filteredGames = gameList.filter({ (gameInfo:GameInfoModel) -> Bool in
            return gameInfo.name!.lowercased().contains(searchText.lowercased())
        })
        
        (filteredGames.count == 0) ? (bottomCollectionView.backgroundView?.isHidden = false) : (bottomCollectionView.backgroundView?.isHidden = true)
        
        isFiltering = true
        bottomCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        bottomCollectionView.reloadData()
    }
}
