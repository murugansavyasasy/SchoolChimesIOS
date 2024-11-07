//
//  QuizExamSelectionViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 01/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ObjectMapper


class QuizExamSelectionViewController: UIViewController {
    
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var examView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var quizExam: UIView!
    
    var imageCount : Int  = 0
    var firstImage : Int  = 0
    var imgaeURl : String  = ""
    weak var timer: Timer?
    var AdName : String  = ""
    var menuId : String!
    var getadID : Int!
    var SchoolId  = String()
    var StaffId  = String()
    var ChildId  = String()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        let examGesture = UITapGestureRecognizer(target: self, action: #selector(ExamVc))
        examView.addGestureRecognizer(examGesture)
        
        
        let quizGesture = UITapGestureRecognizer(target: self, action: #selector(QuizVc))
        quizExam.addGestureRecognizer(quizGesture)
        
        SchoolId = String(describing: appDelegate.SchoolDetailDictionary["SchoolID"]!)
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        
        
        async {
            do {
                //
                menuId = AdConstant.getMenuId as String
                print("menu_id:\(AdConstant.getMenuId)")
                
                
                
                let AdModal = AdvertismentModal()
                AdModal.MemberId = ChildId
                AdModal.MemberType = "student"
                if AdConstant.mgmtVoiceType == "1" {
                    AdModal.MenuId = "0"
                }
                AdModal.MenuId = menuId
                AdModal.SchoolId = SchoolId
                
                
                let admodalStr = AdModal.toJSONString()
                
                
                print("admodalStr2222",admodalStr)
                AdvertismentRequest.call_request(param: admodalStr!) { [self]
                    
                    (res) in
                    
                    let adModalResponse : [AdvertismentResponse] = Mapper<AdvertismentResponse>().mapArray(JSONString: res)!
                    
                    
                    
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
                    
                    
                    
                    //
                }
                
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        let imgTap = AdGesture (target: self, action: #selector(viewTapped))
        adView.addGestureRecognizer(imgTap)
        
    }
    
    
    
    func stopTimer() {
        print("Stopped timer")
        timer?.invalidate()
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    
    
    func startTimer() {
        
        if AdConstant.adDataList.count > 0 {
            
            let url : String =  AdConstant.adDataList[0].contentUrl!
            self.imgaeURl = AdConstant.adDataList[0].redirectUrl!
            self.AdName = AdConstant.adDataList[0].advertisementName!
            self.getadID = AdConstant.adDataList[0].id!
            self.imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            
            adView.isHidden = false
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
            adView.isHidden = true
            adViewHeight.constant = 0
        }
    }
    
    @IBAction func viewTapped() {
        
        
        if imgaeURl.isEmpty != true {
            let vc = AdRedirectViewController(nibName: nil, bundle: nil)
            
            
            vc.advertisement_Name = AdName
            vc.redirect_urls = imgaeURl
            vc.adIdget = getadID
            vc.getMenuID = menuId
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
            
        }else{
            print("isEmpty")
        }
    }
    
    @IBAction func backVc() {
        
        
        dismiss(animated: true)
        
        
    }
    
    
    
    @IBAction func QuizVc() {
        
        
        let vc  = QuizExamMenuViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        
    }
    //
    @IBAction func ExamVc() {
        
        let vc  = ExamViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    
}
