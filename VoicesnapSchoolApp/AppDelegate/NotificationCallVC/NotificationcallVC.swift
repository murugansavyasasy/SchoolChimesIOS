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
class NotificationcallVC: UIViewController {

    
    @IBOutlet weak var declineview: UIView!
    
    @IBOutlet weak var durationLbl: UILabel!
    var audioPlayer: AVPlayer?
    var playerItem: AVPlayerItem?
    var durationObserver: Any?
    var urlss = ""
    var player: AVAudioPlayer?
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

      let audioURL = urlss
        playAudioFromURL(audioURL)
        
        let  decline = UITapGestureRecognizer(target: self , action: #selector(DeclineClcik))
        declineview.addGestureRecognizer(decline)
   }


    
    @IBAction func DeclineClcik(){
        
        player?.stop()
//        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                exit(0)
        
    }

func playAudioFromURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)

    
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDurationLabel), userInfo: nil, repeats: true)
        
        audioPlayer?.play()
    }



    func fetchAudioDuration(from urlString: String, completion: @escaping (Double) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let asset = AVURLAsset(url: url)
        let duration = asset.duration
        let durationInSeconds = CMTimeGetSeconds(duration)
        
        completion(durationInSeconds)
    }
    
    
    @objc func updateDurationLabel(with totalSeconds: Double) {
           if totalSeconds.isFinite {
               let minutes = Int(totalSeconds) / 60
               let seconds = Int(totalSeconds) % 60
               durationLbl.text = "00 : 0" + String(format: "Duration: %d:%02d", minutes, seconds)
               
               
               durationLbl.text =   String(totalSeconds) + String(minutes)
           }
       }
    

//@objc func updateDuration() {
//guard let player = player else { return }
//let currentTime = Int(player.currentTime)
//print("Current duration: \(currentTime) seconds")
//durationLbl.text = "00 : 0" + String(currentTime)
//// Update UI or do something with the current duration
//}

func stopAudio() {
player?.stop()
timer?.invalidate()
}
}
