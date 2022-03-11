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

            } else if (currentPage == slides.count-1){
                obNextBtn.isHidden = false
                obNextBtn.setTitle("Ready!", for: .normal)
                obNextBtn.layer.borderColor = UIColor.white.cgColor
                obNextBtn.layer.borderWidth = 1
                obNextBtn.layer.cornerRadius = 4
                obSkipBtn.isHidden = false
                obSkipBtn.setTitle("⏎", for: .normal)
                
            } else {
                obNextBtn.isHidden = true
                obSkipBtn.isHidden = true
                obSkipBtn.setTitle("none", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obCollectionView.delegate = self
        obCollectionView.dataSource = self
        
        let page1 = SlideModel(header: "LEVEL UP YOUR GAMING EXPERIENCE!", description: "Search Over 100000+ Games", image: "Page_1")
        let page2 = SlideModel(header: "FIND THE BEST GAME FOR YOU!", description: "Find Your Next Favourite Game", image: "Page_2")
        let page3 = SlideModel(header: "NEVER FORGET WHAT TO PLAY!", description: "Check Your Favourites Anytime", image: "Page_3")
        //let page4 = SlideModel(header: "We Go Everywhere!", description: "65000+ Routes \n & \n Over 2300 Operators Worldwide", image: "thumbs-up_32")
        slides = [page1, page2, page3]
        
        obNextBtn.layer.cornerRadius = 15
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            self.currentPage += 1
            let indexPath = IndexPath(item: self.currentPage, section: 0)
            self.obCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            if self.currentPage == self.slides.count-1 {
                timer.invalidate()
                self.obCollectionView.isUserInteractionEnabled = true
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
