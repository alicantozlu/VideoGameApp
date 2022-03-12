//
//  AlertViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 12.03.2022.
//

import UIKit

class AlertViewController: UIViewController {

    var delegate: MessageDelegate?
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var containerView: UIView!
    
    var textMessage:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 8
    
        yesButton.layer.cornerRadius = 8
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !containerView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Tapped inside the view")
        }
    }
    
    @IBAction func yesBtnAction(_ sender: Any) {
        self.delegate?.sendMessage(check: true)
        dismiss(animated: true, completion: nil)
    }
}

protocol MessageDelegate{
    func sendMessage(check:Bool)
}
