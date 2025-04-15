//
//  NotificationcallVC.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 09/10/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import AVFAudio
import AVFoundation
import ObjectMapper
class NotificationcallVC: UIViewController {

    
    @IBOutlet weak var declineview: UIView!
    
    @IBOutlet weak var durationLbl: UILabel!
    var audioPlayer: AVPlayer?
  
    var durationObserver: Any?
    var urlss = ""
   
    var timer: Timer?
    
   
    var callStatus = ""
    
   
    var StartcurrentTimes : String! = nil
    var Endtime : String! = nil
    
   
    var userInfo = [AnyHashable : Any]()
   
    
    
    
    var player: AVPlayer?
      var playerItem: AVPlayerItem?
      var timeObserverToken: Any?
    var audioURL:  String!
    var totalDuraion:  String!
    var duration : String!
    
    var strMobileNo : String! = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
     
        
        audioURL = urlss
        createGradientLayer(view: self.view)

        
        
        
        setupAudioPlayer()
       
        
        
        let declineClick = UITapGestureRecognizer(target: self, action: #selector(DeclineClcik))
        declineview.addGestureRecognizer(declineClick)
   }


    
    @IBAction func DeclineClcik(){
        callStatus = "OC"
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short // Automatically uses 12-hour or 24-hour based on device settings
        let currentTime = dateFormatter.string(from: Date())
        
        print("Current time is: \(currentTime)")
        
        Endtime = currentTime
        
        stopPlayer()

            
        
    }


    
    func setupAudioPlayer() {
        callStatus = "OC"
           guard let url = URL(string: audioURL) else {
               print("Invalid URL")
               return
           }
           
           playerItem = AVPlayerItem(url: url)
           player = AVPlayer(playerItem: playerItem)
           
           // Observe player item status to ensure it is ready to play
           playerItem?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
           
           // Listen for when the audio finishes
           NotificationCenter.default.addObserver(self,
                                                  selector: #selector(audioDidFinishPlaying),
                                                  name: .AVPlayerItemDidPlayToEndTime,
                                                  object: playerItem)
       }
       
       // Observe AVPlayerItem status
       override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           if keyPath == "status" {
               if playerItem?.status == .readyToPlay {
                   player?.play()
                   addPeriodicTimeObserver()
               } else if playerItem?.status == .failed {
                   print("Failed to load audio.")
               }
           }
       }
       
       func addPeriodicTimeObserver() {
           let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
           
           timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
               guard let self = self else { return }
               
               let currentTime = CMTimeGetSeconds(time)
               let formattedCurrentTime = self.formatTime(seconds: currentTime)
               
               let totalDurationSeconds = CMTimeGetSeconds(self.playerItem?.duration ?? CMTime.zero)
               guard totalDurationSeconds.isFinite && !totalDurationSeconds.isNaN else {
                   print("Total duration is invalid.")
                   return
               }
               let formattedTotalDuration = self.formatTime(seconds: totalDurationSeconds)
               
               self.durationLbl.text = "\(formattedCurrentTime) / \(formattedTotalDuration)"
               print("Playback time: \(formattedCurrentTime) / \(formattedTotalDuration)")
               totalDuraion = formattedCurrentTime
           }
       }
       
       func formatTime(seconds: Double) -> String {
           guard seconds.isFinite && !seconds.isNaN else {
               return "00:00"
           }
           
           let minutes = Int(seconds) / 60
           let seconds = Int(seconds) % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }
       
       @objc func audioDidFinishPlaying(notification: NSNotification) {
           print("Audio file played fully: \(audioURL)")
           stopPlayer()
       }
       
       func stopPlayer() {
           
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           let currentDateTime = Date()
           let formattedDate = formatter.string(from: currentDateTime)

           print(formattedDate)
           
           Endtime = formattedDate
           
           player?.pause()
           player?.seek(to: .zero)
           
           if let token = timeObserverToken {
               player?.removeTimeObserver(token)
               timeObserverToken = nil
           }
           
           player = nil
           playerItem = nil
           print("Player stopped and resources released.")
           
           NotiApi()
           
           
       }
       
       deinit {
           NotificationCenter.default.removeObserver(self)
           playerItem?.removeObserver(self, forKeyPath: "status")
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
        
        let timeString = totalDuraion
        let components = timeString!.split(separator: ":").compactMap { Int($0) }

        if components.count == 2 {
            let hours = components[0]
            let minutes = components[1]
            let totalSeconds = (hours * 3600) + (minutes * 60)
            print("Total seconds: \(totalSeconds)")
            
            duration = String(totalSeconds)
            
        } else {
            print("Invalid time format")
        }
        
        
        let noti = Notimodal()
        
        noti.url = urlss
        noti.call_status = callStatus
        noti.duration = duration
        noti.start_time = StartcurrentTimes
        noti.end_time = Endtime
        print("strMobileNostrMobileNo",Endtime)
        noti.phone = strMobileNo
        
        
       
        
        do{
            if let ei1 = userInfo[AnyHashable("ei1")] as? String {
                print("ei1: \(ei1)")
                noti.ei1 = ei1
            }else{
                
                print("False",userInfo[AnyHashable("ei1")])
            }
            
        }catch let error  {
            
            print("error",error)
        }
        
        if let ei2 = userInfo[AnyHashable("ei2")] as? String {
            print("ei2: \(ei2)")
            
            noti.ei2 = ei2
        }
        
        if let ei3 = userInfo[AnyHashable("ei3")] as? String  {
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
        
        if let retryCount = userInfo[AnyHashable("retrycount")] as? String {
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
            
            [self] (res) in
            
            let notiresponces : [notiRes] = Mapper<notiRes>().mapArray(JSONString: res)!
            
            
            
            if notiresponces[0].Status == 1{
                
               
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                    
                    exit(0)
                }
                   
                    
                
            }else{
                
                exit(0)
                
            }
            
            
            
        }
        
    }

}
