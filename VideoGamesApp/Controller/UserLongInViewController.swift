//
//  UserLongInViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class UserLongInViewController: UIViewController {

    @IBOutlet var userNameTxtFld: UITextField!
    @IBOutlet var userPasswordTxtFld: UITextField!
    @IBOutlet var logInBtn: UIButton!
    @IBOutlet var registerBtn: UIButton!
    
    let gameListRequest = GameListRequest(link: "https://api.rawg.io/api/games?key=58d924b9ce4441f48c690d746949c01c&page=1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameListRequest.getGames { result in
            do {
                GameListViewController.tempGameList = try result.get().results!
                GameListViewController.tempNextPage = try result.get().next!
            }catch let error {
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let onboardCheck = UserDefaults.standard.bool(forKey: "Onboarded")
        if(!onboardCheck){
            UserDefaults.standard.set(true, forKey: "Onboarded")
            self.onStart()
        }
    }
    
    func onStart () {
        let onboardingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboardingIdentity") as! OnboardingViewController
        onboardingVC.modalPresentationStyle = .fullScreen
        present(onboardingVC, animated: true, completion: nil)
    }
    
    @IBAction func logInBtnTapped(_ sender: Any) {
        
        
        
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarIdentity") as! UITabBarController
        tabBarVC.modalTransitionStyle = .flipHorizontal
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
}
