//
//  EmptyView.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 8.03.2022.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet var textLbl: UILabel!
    @IBOutlet var notFoundImage: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
        
        shadowMaker(UILabel: textLbl)
        shadowMaker(UILabel: notFoundImage)
    }
    
    func shadowMaker<T> (UILabel: T){
        self.layer.borderWidth = 0.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder){
        fatalError("Error")
    }

    func commonInit(){
        let bundle = Bundle.init(for: EmptyView.self)
        if let viewToAdd = bundle.loadNibNamed("EmptyView", owner: self, options: nil), let contentView = viewToAdd.first as? UIView{
            addSubview(contentView)
            contentView.frame = self.bounds
        }
    }
}
