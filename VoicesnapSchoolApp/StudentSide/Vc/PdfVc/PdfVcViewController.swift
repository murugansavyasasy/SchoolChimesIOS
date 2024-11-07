//
//  PdfVcViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import WebKit

import ObjectMapper


class PdfVcViewController: UIViewController {
    
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    @IBOutlet weak var Adview: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var web_Kit: WKWebView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var backView: UIView!
    var webViewUrl : String!
    var CertificateName : String!
    
    
    var schoolId : String!
    var childId : String!
    var imgaeURl : String  = ""
    var AdName : String  = ""
    var getadID : Int!
    var imageCount : Int  = 0
    var firstImage : Int  = 0
    weak var timer: Timer?
    var menuId : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = CertificateName
        
        print("webViewUrl",webViewUrl)
        let url = URL (string: webViewUrl)
        let requestObj = URLRequest(url: url!)
        web_Kit.load(requestObj)
        
        
        print("Circular")
        let BackGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(BackGesture)
        
        
        
        async {
            do {
                //
                menuId = AdConstant.getMenuId as String
                print("menu_id:\(AdConstant.getMenuId)")
                
                
                
                let AdModal = AdvertismentModal()
                AdModal.MemberId = childId
                AdModal.MemberType = "student"
                if AdConstant.mgmtVoiceType == "1" {
                    AdModal.MenuId = "0"
                }
                AdModal.MenuId = menuId
                AdModal.SchoolId = schoolId
                
                
                let admodalStr = AdModal.toJSONString()
                
                
                print("admodalStr2222",admodalStr)
                AdvertismentRequest.call_request(param: admodalStr!) { [self]
                    
                    (res) in
                    
                    let adModalResponse : [AdvertismentResponse] = Mapper<AdvertismentResponse>().mapArray(JSONString: res)!
                    
                    
                    
                    //            var adDataList : [MenuData] = []
                    for i in adModalResponse {
                        if i.Status.elementsEqual("1") {
                            print("AdConstantadDataListtt",AdConstant.adDataList.count)
                            
                            
                            
                            
                            AdConstant.adDataList.removeAll()
                            AdConstant.adDataList = i.data
                            
                            startTimer()
                            
                        }else{
                            
                        }
                        
                    }
                    
                    print("admodalStr_count", AdConstant.adDataList .count)
                    
                    
                    
                    
                }
                
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        
        
        
        
        let imgTap = AdGesture (target: self, action: #selector(viewTapped))
        Adview.addGestureRecognizer(imgTap)
        
        
    }
    
    
    
    
    
    
    func startTimer() {
        if AdConstant.adDataList.count > 0 {
            let url : String =  AdConstant.adDataList[0].contentUrl!
            self.imgaeURl = AdConstant.adDataList[0].redirectUrl!
            self.AdName = AdConstant.adDataList[0].advertisementName!
            self.getadID = AdConstant.adDataList[0].id!
            self.imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            Adview.isHidden = false
            adViewHeight.constant = 80
            
            if(self.firstImage == 0){
                self.imageCount =  1
            }
            else{
                self.imageCount =  0
            }
            
            let minC : Int = UserDefaults.standard.integer(forKey: ADTIMERINTERVAL)
            print("minC",minC)
            var AdSec = String(minC / 1000)
            print("minutesBefore",AdSec)
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(AdSec)!, repeats: true) { [weak self] _ in
                
                
                if(AdConstant.adDataList.count == self!.imageCount){
                    self!.imageCount = 0
                    self!.firstImage = 1
                }
                
                self!.imageCount = self!.imageCount + 1
                
                let url : String =  AdConstant.adDataList[self!.imageCount-1].contentUrl!
                self!.imgaeURl = AdConstant.adDataList[self!.imageCount-1].redirectUrl!
                self!.AdName = AdConstant.adDataList[self!.imageCount-1].advertisementName!
                self!.getadID = AdConstant.adDataList[self!.imageCount-1].id!
                
                self!.imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            }
        }else {
            Adview.isHidden = true
            adViewHeight.constant = 0
        }
    }
    
    func stopTimer() {
        print("Stopped timer")
        timer?.invalidate()
    }
    
    @IBAction func viewTapped() {
        
        
        if imgaeURl.isEmpty != true {
            let vc = AdRedirectViewController(nibName: nil, bundle: nil)
            
            
            vc.advertisement_Name = AdName
            vc.redirect_urls = imgaeURl
            vc.adIdget = getadID
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
            
        }else{
            print("isEmpty")
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startTimer()
    }
    
    
    
    @IBAction func backVc() {
        
        dismiss(animated: true)
    }
    
    
}
