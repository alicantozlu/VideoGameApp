//
//  InputAlertViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 12.03.2022.
//

import UIKit

class InputAlertViewController: UIViewController {

    @IBOutlet var alertTextLbl: UILabel!
    @IBOutlet var alertBtn: UIButton!
    @IBOutlet var alertContainer: UIView!
    
    var textMessage:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertTextLbl.text = textMessage
        alertContainer.layer.borderColor = UIColor.white.cgColor
        alertContainer.layer.borderWidth = 2
        alertContainer.layer.cornerRadius = 8
    }

    @IBAction func alertBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
