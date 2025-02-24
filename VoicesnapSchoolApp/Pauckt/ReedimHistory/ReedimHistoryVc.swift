//
//  ReedimHistoryVc.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import UIKit

class ReedimHistoryVc: UIViewController {

    @IBOutlet weak var segments: UISegmentedControl!
    
    @IBOutlet weak var cv: UICollectionView!
    override func viewDidLoad() {
            super.viewDidLoad()
           
        
//        segments.backgroundColor = .clear
           
           // Set text color to white
        
        
        
        cv.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = cv.bounds
        
        let backgroundView = UIView(frame: cv.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        cv.backgroundView = backgroundView
        
           segments.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
           segments.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        
        cv.register(UINib(nibName: "ReedimHistoryCell", bundle: nil), forCellWithReuseIdentifier: "ReedimHistoryCell")
         
        cv.delegate = self
        cv.dataSource = self
        
        
           
        }
        
       
    }
extension ReedimHistoryVc:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReedimHistoryCell", for: indexPath) as! ReedimHistoryCell
        
        return cell
    }
}
extension ReedimHistoryVc:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: 200)
    }
}
