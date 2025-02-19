//
//  HomePaucktVC.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 19/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import UIKit

class HomePaucktVC: UIViewController
,UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate,UICollectionViewDelegateFlowLayout{

        @IBOutlet weak var reminingCoinsView: UIView!
        @IBOutlet weak var totalCoinsView: UIView!
        @IBOutlet weak var collectionView: UICollectionView!
        @IBOutlet weak var searchBar: UISearchBar!

           var offers: [Offer] = [
               Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
               Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image"),Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
               Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image"),Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
               Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image"),Offer(title: "Opening Soon at Jalandhar", subtitle: "Hair Dressing, Beauty, Makeup", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "saloon_image"),
               Offer(title: "Fun is Back", subtitle: "Get Ready to Dizzee!", discount: "20% Off", locationInfo: "10 locations", durationInfo: "5 days", imageName: "dizzee_image")
           ]

           var filteredOffers: [Offer] = []

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        gradientLayer.frame = collectionView.bounds // Adjust if applied to collectionView
//        
//        
//    }
           override func viewDidLoad() {
               super.viewDidLoad()
               collectionView.backgroundColor = .clear
               let gradientLayer = CAGradientLayer()
               gradientLayer.colors = [
                   UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0).cgColor,
                   UIColor.white.cgColor
               ]
               gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
               gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
               gradientLayer.frame = collectionView.bounds

               let backgroundView = UIView(frame: collectionView.bounds)
               backgroundView.layer.insertSublayer(gradientLayer, at: 0)
               gradientLayer.frame = view.bounds
             view.layer.insertSublayer(gradientLayer, at: 0)
               collectionView.backgroundView = backgroundView
               
               collectionView.delegate = self
               collectionView.dataSource = self
               searchBar.delegate = self

               filteredOffers = offers
               collectionView.register(UINib(nibName: "CoupenCvCell", bundle: nil), forCellWithReuseIdentifier: "CoupenCvCell")
             
//               reminingCoinsView.layer.cornerRadius = 10
//               
//               // Add shadow
//               reminingCoinsView.layer.shadowColor = UIColor.black.cgColor
//               reminingCoinsView.layer.shadowOffset = CGSize(width: 0, height: 4)
//               reminingCoinsView.layer.shadowRadius = 8
//               reminingCoinsView.layer.shadowOpacity = 0.3
//               
//               // Enable masksToBounds for shadow
//               reminingCoinsView.layer.masksToBounds = false
//               
//               
//               totalCoinsView.layer.cornerRadius = 10
//               
//               // Add shadow
//               totalCoinsView.layer.shadowColor = UIColor.black.cgColor
//               totalCoinsView.layer.shadowOffset = CGSize(width: 0, height: 4)
//               totalCoinsView.layer.shadowRadius = 8
//               totalCoinsView.layer.shadowOpacity = 0.3
//               
//               // Enable masksToBounds for shadow
//               totalCoinsView.layer.masksToBounds = false
//               
           }

           func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return filteredOffers.count
           }

           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoupenCvCell", for: indexPath) as! CoupenCvCell
               let offer = filteredOffers[indexPath.row]

               cell.titleLabel.text = offer.title
               cell.subtitleLabel.text = offer.subtitle
               cell.discountLabel.text = offer.discount
               cell.locationLabel.text = offer.locationInfo
               cell.durationLabel.text = offer.durationInfo
               cell.backgroundImageView.image = UIImage(named: offer.imageName)

               return cell
           }

           func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
               if searchText.isEmpty {
                   filteredOffers = offers
               } else {
                   filteredOffers = offers.filter { $0.title.lowercased().contains(searchText.lowercased()) }
               }
               collectionView.reloadData()
           }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width/2, height: 260)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
        }
       
        
        
    //
       }


    struct Offer {
        let title: String
        let subtitle: String
        let discount: String
        let locationInfo: String
        let durationInfo: String
        let imageName: String
    }
