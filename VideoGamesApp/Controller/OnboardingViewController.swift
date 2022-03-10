//
//  OnboardingViewController.swift
//  VideoGamesApp
//
//  Created by Ali Can Tozlu on 5.03.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet var obCollectionView: UICollectionView!
    @IBOutlet var obPageController: UIPageControl!
    @IBOutlet var obSkipBtn: UIButton!
    @IBOutlet var obNextBtn: UIButton!
    
    var slides = [SlideModel]()
    
    var currentPage = 0{
        didSet{
            obPageController.currentPage = currentPage
            
            if (currentPage == 0){
                obSkipBtn.isHidden = false
                obSkipBtn.setTitle("Skip", for: .normal)
                
                obNextBtn.isHidden = true
                obNextBtn.setTitleColor(UIColor(red: 0/255, green: 31/255, blue: 91/255, alpha: 1), for: .normal)
                obNextBtn.backgroundColor = UIColor(red: 219/255, green: 248/255, blue: 255/255, alpha: 1)
                
            } else if (currentPage == slides.count-1){
                obNextBtn.isHidden = false
                obNextBtn.setTitle("Get Started", for: .normal)
                obNextBtn.backgroundColor  = UIColor(red: 0/255, green: 31/255, blue: 91/255, alpha: 1)
                obNextBtn.setTitleColor(UIColor(red: 219/255, green: 248/255, blue: 255/255, alpha: 1), for: .normal)
                
                obSkipBtn.isHidden = false
                obSkipBtn.setTitle("⏎", for: .normal)
                
            } else {
                obNextBtn.isHidden = true
                obNextBtn.setTitle("Next", for: .normal)
                obNextBtn.backgroundColor = UIColor(red: 219/255, green: 248/255, blue: 255/255, alpha: 0)
                obNextBtn.setTitleColor(UIColor(red: 0/255, green: 31/255, blue: 91/255, alpha: 1), for: .normal)
                
                obSkipBtn.isHidden = true
                obSkipBtn.setTitle("none", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obCollectionView.delegate = self
        obCollectionView.dataSource = self
        
        let page1 = SlideModel(header: "Let's make your game better!", description: "", image: "heart_32")
        let page2 = SlideModel(header: "Find the best game for you!", description: "You can choose the game you like", image: "heart_32")
        let page3 = SlideModel(header: "Start playing today!", description: "", image: "home_32")
        //let page4 = SlideModel(header: "We Go Everywhere!", description: "65000+ Routes \n & \n Over 2300 Operators Worldwide", image: "thumbs-up_32")
        slides = [page1, page2, page3]
        
        obNextBtn.layer.cornerRadius = 15
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            self.currentPage += 1
            let indexPath = IndexPath(item: self.currentPage, section: 0)
            self.obCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            if self.currentPage == self.slides.count-1 {
                timer.invalidate()
            }
        }
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if(currentPage == slides.count-1){
            // navigate to the next page
            dismiss(animated: true, completion: nil)
        } else if(currentPage != slides.count-1){
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            obCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func goToStartBtnAction(_ sender: Any) {
        if(currentPage == 0){
            // Get Started a basildiginde gecilecek ekran calisacak
            dismiss(animated: true, completion: nil)
        } else if(currentPage == slides.count-1){
            obNextBtn.setTitle("Next", for: .normal)
            currentPage = 0
            let indexPath = IndexPath(item: currentPage, section: 0)
            obCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "obCellIdentifier", for: indexPath) as! OnboardingCollectionViewCell
        cell.configure(model: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
