//
//  UserProfileViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var userJoinedLbl: UILabel!
    @IBOutlet var favouriteGameLbl: UILabel!
    @IBOutlet var logOutBtn: UIButton!
    
    static var nameText:String = ""
    static var gameCount:String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //User Name
        userNameLbl.text = UserProfileViewController.nameText
        
        //User Joined
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        userJoinedLbl.text = dateFormatter.string(from: Date())

    }
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        
        LikedGamesViewController.likedGames.removeAll()
        
        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logInIdentity") as! UserLongInViewController
        logInVC.modalTransitionStyle = .flipHorizontal
        logInVC.modalPresentationStyle = .fullScreen
        present(logInVC, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        //Fav Game Count
        favouriteGameLbl.text = UserProfileViewController.gameCount
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
