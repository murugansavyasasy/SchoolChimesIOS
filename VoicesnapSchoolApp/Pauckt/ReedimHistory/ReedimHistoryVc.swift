//
//  ReedimHistoryVc.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper

class ReedimHistoryVc: UIViewController {

    @IBOutlet weak var Searchbar: UISearchBar!
    @IBOutlet weak var segments: UISegmentedControl!
    @IBOutlet weak var cv: UICollectionView!
    
    var CouponType = "all"
    var couponList: [Coupon] = []

    
    override func viewDidLoad() {
        
            super.viewDidLoad()
           
        cv.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
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
        
        segments.selectedSegmentIndex = 0
        
        Searchbar.delegate = self
        addDoneButtonOnKeyboard()
           
        MyCouponDetails(coupon_type: CouponType)
        }
    
    @IBAction func SegmentAction(_ sender: Any) {
        
       if segments.selectedSegmentIndex == 0 {
           CouponType = "all"
       }else if segments.selectedSegmentIndex == 1{
           CouponType = "activated"
       }else if segments.selectedSegmentIndex == 2 {
           CouponType = "expired"
       }else if segments.selectedSegmentIndex == 3 {
           CouponType = "claimed"
       }
        
        MyCouponDetails(coupon_type: CouponType)
        Searchbar.resignFirstResponder()
    }
    
    
    
    func MyCouponDetails(coupon_type : String){
        
        let param : [String : Any] = ["mobile_no": "917550144367","coupon_status":coupon_type]
        
        let headers: [String: Any] = [
            "api-key": "b9634e2c3aa9b6fdc392527645c43871",
            "Partner-Name": "voicesnaps"
        ]
        
        My_Coupons_Request.call_request(param: param, headers: headers){ [self]
            (res) in

            if let couponResponse = Mapper<MyCouponResponse>().map(JSONString: res) {
               
                if let coupons = couponResponse.data?.couponList?.data {
                    
                    couponList = coupons
                    cv.reloadData()
                }
            }

            
        }
    }
        
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    }
extension ReedimHistoryVc:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        couponList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReedimHistoryCell", for: indexPath) as! ReedimHistoryCell
        
        cell.BrandLogoImage.sd_setImage(with:URL(string: couponList[indexPath.row].merchantLogo ?? ""), placeholderImage: UIImage(named: "placeHolder.png"), options: SDWebImageOptions.refreshCached)
        
        if couponList[indexPath.row].couponStatus == "expired" {
            cell.CouponStatusView.isHidden = false
            cell.CouponStatusView.backgroundColor = .systemGray
            cell.CouponStatusLbl.text = couponList[indexPath.row].couponStatus
        }else if couponList[indexPath.row].couponStatus == "claimed"{
            
            cell.CouponStatusView.isHidden = false
            cell.CouponStatusView.backgroundColor = .systemGreen
            cell.CouponStatusLbl.text = "Redeemed"
        }
        
        cell.BrandNameLbl.text = couponList[indexPath.row].merchantName
        cell.OfferLbl.text = couponList[indexPath.row].offerToShow
        let expiresIn = couponList[indexPath.row].expiresIn ?? 0
        cell.ExpireyDateLbl.text = "Expires in " + String(expiresIn) + " days"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = cv.cellForItem(at: indexPath) as! ReedimHistoryCell
        
        let vc = ClaimCouponVc(nibName: nil, bundle: nil)
        vc.couponDetails = couponList[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
extension ReedimHistoryVc:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: 200)
    }
}

extension ReedimHistoryVc : UISearchBarDelegate {
    
//        func addDoneButtonToKeyboard() {
//            let toolbar = UIToolbar()
//            toolbar.sizeToFit()
//            
//            // Create flexible space to push the Done button to the right
//            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//            
//            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
//            toolbar.items = [flexibleSpace, doneButton]
//            
//            Searchbar.inputAccessoryView = toolbar
//        }
    
//    func addDoneButtonToKeyboard() {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
//        toolbar.barTintColor = .white.withAlphaComponent(0.5)
//        doneButton.tintColor = .blue
//        toolbar.items = [flexSpace, doneButton]
//        Searchbar.inputAccessoryView = toolbar
//    }
//        
//        @objc func doneButtonTapped() {
//            Searchbar.resignFirstResponder() // Hide the keyboard
//        }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.isUserInteractionEnabled = true

        // Assign toolbar to inputAccessoryView
        Searchbar.searchTextField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        Searchbar.resignFirstResponder()
        print("Done button tapped. Search text: \(Searchbar.text ?? "")")
    }

}
