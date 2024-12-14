//
//  NotificationCallingscreen.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 09/10/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper
import AVFAudio
class NotificationCallingscreen: UIViewController {
    
    @IBOutlet weak var acceptView: UIView!
    
    @IBOutlet weak var DeclineView: UIView!
    
    
    
    var urlss = ""
    var callStatus = ""
    
   
    var currentTimes : String! = nil
    
   
    var userInfo = [AnyHashable : Any]()
    var strMobileNo : String! = nil
    
    
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        view = GradientView()
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateTime = Date()
        let formattedDate = formatter.string(from: currentDateTime)

        print(formattedDate)
        
        currentTimes = formattedDate
       
        
        
        
        createGradientLayer(view: self.view)
        
        
        let  accept = UITapGestureRecognizer(target: self , action: #selector(appectClcik))
        acceptView.addGestureRecognizer(accept)
        
        let  decline = UITapGestureRecognizer(target: self , action: #selector(DeclineClcik))
        DeclineView.addGestureRecognizer(decline)
    }
    
    @IBAction func appectClcik(){
        
        
        
        if let player = audioPlayer, player.isPlaying {
            print("Stopping currently playing sound")
            player.stop()
        }
        
        callStatus = "OC"
        
        let vcc = NotificationcallVC(nibName: nil, bundle: nil)
        vcc.userInfo = userInfo
        vcc.callStatus = callStatus
        vcc.StartcurrentTimes = currentTimes
        vcc.urlss = urlss
        vcc.strMobileNo = strMobileNo
        vcc.modalPresentationStyle = .fullScreen
        
        present(vcc, animated: true)

        
    }
    
    
    @IBAction func DeclineClcik(){
        
//        if let player = audioPlayer, player.isPlaying {
//            print("Stopping currently playing sound")
//            player.stop()
//        }
        callStatus = "NO"
        

       
        
        
        NotiApi()
        
    }
    
    
    
    func createGradientLayer(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.black.cgColor,          // start color (#000)
            UIColor(red: 0.463, green: 0.502, blue: 0.529, alpha: 1.0).cgColor, // center color (#768087)
            UIColor(red: 0.529, green: 0.808, blue: 0.922, alpha: 1.0).cgColor  // end color (#87CEEB)
        ]
        
        // Set gradient angle (45 degrees)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func NotiApi(){
        
        strMobileNo = UserDefaults.standard.object(forKey: USERNAME) as! String
       
       let noti = Notimodal()
        
        noti.url = urlss
        noti.call_status = callStatus
        noti.duration = "0"
        noti.start_time = currentTimes
        noti.end_time = currentTimes
        print("strMobileNo",strMobileNo)
        
      
        noti.phone = strMobileNo
        if let ei1 = userInfo[AnyHashable("ei1")] as? String {
            print("ei1: \(ei1)")
            noti.ei1 = ei1
        }

        if let ei2 = userInfo[AnyHashable("ei2")] as? String {
            print("ei2: \(ei2)")
            
            noti.ei2 = ei2
        }

        if let ei3 = userInfo[AnyHashable("ei3")] as? String {
            noti.ei3 = ei3
        }

        if let ei4 = userInfo[AnyHashable("ei4")] as? String {
            noti.ei4 = ei4
        }

        if let ei5 = userInfo[AnyHashable("ei5")] as? String {
            print("ei5: \(ei5)")
            noti.ei5 = ei5
            noti.diallist_id = ei5
        }

        if let retryCount = userInfo[AnyHashable("retrycount")] as? String{
            print("retrycount: \(retryCount)")
            noti.retrycount = retryCount
        }

        if let circularId = userInfo[AnyHashable("circular_id")] as? String {
            print("circular_id: \(circularId)")
            noti.circular_id = circularId
        }

        if let receiverId = userInfo[AnyHashable("receiver_id")] as? String {
            print("receiver_id: \(receiverId)")
            
            noti.receiver_id = receiverId
        }

       
        
        
        var  notiModalStr = noti.toJSONString()
        print("punchModalStr",noti.toJSON())


        NotiRequst.call_request(param: notiModalStr!) {
            
      (res) in
            
            let notiresponces : [notiRes] = Mapper<notiRes>().mapArray(JSONString: res)!
            
            
            
            if notiresponces[0].Status == 1{
                
             
               
                    
                    
                exit(0)
                    
               
                
                
                
            }else{
                
                
                
            }
            
            
            exit(0)
        }
        
        
        
       
         
    }
}




