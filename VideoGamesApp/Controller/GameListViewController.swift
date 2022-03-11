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
    
    //PageController kontrolu
    var currentPage = 0 {
        didSet{
            gamePageController.currentPage = currentPage
        }
    }
    
    //Liste sonuna gelindiginde yeni oyunlarin eklenecegi liste
    var newGameList = [GameInfoModel](){
        didSet{
            print("BOTTOM:\(newGameList)")
            for i in 0...19{
                bottomList.append(newGameList[i])
            }
            DispatchQueue.main.async {
                self.bottomCollectionView.reloadData()
            }
        }
    }
    
    //Ilk acilista oyunlarin eklenecegi model
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
            for i in 3...19{
                bottomList.append(gameList[i])
            }
            print("BOTTOM:\(bottomList)")
        }
    }
    var nextPage:String = ""
    
    var topList = [GameInfoModel]()
    var bottomList = [GameInfoModel]()
    
    let gameListRequest = GameListRequest(link: "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1")
    
    var filteredGames = [GameInfoModel]()
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameListRequest.getGames { result in
            do {
                self.gameList = try result.get().results!
                self.nextPage = try result.get().next!
            }catch let error {
                print(error)
            }
        }
        
        tabbarConfig()
        
        gameSearchBar.searchBarStyle = .minimal
        gameSearchBar.searchTextField.backgroundColor = .clear
        gameSearchBar.searchTextField.textColor = .white
        gameSearchBar.searchTextField.tintColor = .white
        gameSearchBar.searchTextField.leftView?.tintColor = .white
        
        bottomCollectionView.backgroundView = EmptyView()
        bottomCollectionView.backgroundView?.isHidden = true
        
        topCollectionView.register(UINib(nibName: "TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "topCellIdentity")
        bottomCollectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "bottomCellIdentity")
    }

    // TabBar Ozellestirmeleri
    private func tabbarConfig() {
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = UIColor.clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .clear
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
        func choose(arr: Array<GameInfoModel>){
            GameScreenViewController.gameInfo = arr[indexPath.row].short_screenshots!
            GameScreenViewController.backgroundImage.loadFrom(URLAddress: arr[indexPath.row].background_image!)
            GameScreenViewController.currentGame.append(arr[indexPath.row])
            GameScreenViewController.gameName.clearName(str: arr[indexPath.row].name!)
            GameScreenViewController.releaseDate = arr[indexPath.row].released!
            GameScreenViewController.metaVal = String(arr[indexPath.row].metacritic!)
            GameScreenViewController.genre = arr[indexPath.row].genres!
            gameDetailRequest = GameListRequest(slug: arr[indexPath.row].slug!)
        }
        var gameDetailRequest = GameListRequest(slug: "")
        if(isFiltering){
            choose(arr: filteredGames)
        }else{
            if(collectionView == topCollectionView){
                choose(arr: topList)
            }else{
                choose(arr: bottomList)
            }
        }
        
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
            if(!newGameList.isEmpty){
                return bottomList.count
            }else{
                return gameList.count-3
            }
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
                if(!newGameList.isEmpty){
                    cell.configure(model: bottomList[indexPath.row])
                }else{
                    cell.configure(model: gameList[indexPath.row+3])
                }
            }
            
            if(indexPath.row+2 == bottomList.count){
                let gameListRequest = GameListRequest(link: self.nextPage)
                
                gameListRequest.getGames { result in
                    do {
                        self.newGameList = try result.get().results!
                        self.nextPage = try result.get().next!
                    }catch let error {
                        print(error)
                    }
                }
            }
            return cell
        }
    }
    
    //Pagecontroller Hareketi
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == topCollectionView{
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
        }
    }
}

extension GameListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count >= 3){
            filteredGames = bottomList.filter({ (gameInfo:GameInfoModel) -> Bool in
                return gameInfo.name!.lowercased().contains(searchText.lowercased())
            })
            
            (filteredGames.count == 0) ? (bottomCollectionView.backgroundView?.isHidden = false) : (bottomCollectionView.backgroundView?.isHidden = true)
            
            isFiltering = true
            bottomCollectionView.reloadData()
        }else{
            isFiltering = false
            innerStackView.isHidden = false
            bottomCollectionView.backgroundView?.isHidden = true
            bottomCollectionView.reloadData()
            return
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        bottomCollectionView.reloadData()
    }
}
