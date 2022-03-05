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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func logInBtnTapped(_ sender: Any) {
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarIdentity") as! UITabBarController
        tabBarVC.modalTransitionStyle = .flipHorizontal
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true, completion: nil)
    }
}
