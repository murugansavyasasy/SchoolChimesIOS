//
//  AdRedirectViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 06/12/22.
//  Copyright © 2022 Shenll-Mac-04. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD
import ObjectMapper

class AdRedirectViewController: UIViewController {
    
    
    @IBOutlet weak var web_view: WKWebView!
    
    @IBOutlet weak var advertisementNameLbl: UILabel!
    
    var redirect_urls : String!
    var advertisement_Name : String!
    var adIdget : Int!
    var StaffId : String!
    var SchoolId  = String()
    
    var getMenuID : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let userDefaults = UserDefaults.standard
        
        SchoolId = userDefaults.string(forKey: DefaultsKeys.SchoolD)!
        StaffId = userDefaults.string(forKey: DefaultsKeys.StaffID)
        
        
        advertisementNameLbl.text = advertisement_Name
        print("getMenuID\(getMenuID)")
        KRProgressHUD.show()
        print("redirect_urls\(redirect_urls)")
        print("advertisement_Name\(advertisement_Name)")
        
        if redirect_urls.isEmpty {
            
            KRProgressHUD.dismiss()
            print("isEmpty")
            //            let link = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSf4H6kiqMbK5tsahPGUSMo72kYzwin4W9HxBhG-SS56E6n5pQ/viewform")!
            //            let request = URLRequest(url: link)
            //            web_view.load(request)
        }else{
            let link = URL(string: redirect_urls)!
            let request = URLRequest(url: link)
            web_view.load(request)
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
                
                KRProgressHUD.dismiss()
            }
            
        }
        
        
        
        AdsViewer()
    }
    
    
    @IBAction func backAct(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func AdsViewer() {
        
        let adview = AdViewerModal()
        
        adview.schoolId = SchoolId
        adview.memberId = StaffId
        adview.menuId = Int(getMenuID)
        adview.member_type = "parent"
        adview.adId = adIdget
        
        
        //        print("GetAllStandardsAndGroupsModal.CountryID",)
        print("adview.StaffID",StaffId)
        print("adview.SchoolId",SchoolId)
        
        let adviewModalStr = adview.toJSONString()
        
        
        print("adviewModalStr",adviewModalStr!)
        
        AdViewerRequest.call_request(param: adviewModalStr!) {
            
            [self] (res) in
            
            
            let adResponse : [AdViewerResponse] = Mapper<AdViewerResponse>().mapArray(JSONString : res)!
            
            
            //
        }
        
    }
    
    
}
