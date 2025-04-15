//
//  notisample.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 12/12/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation



//class NotificationHandler {
//    // AVAudioPlayer instance to manage audio
//    var audioPlayer: AVAudioPlayer?
//
//    // Function to play a notification sound
//    func playNotificationSound() {
//        guard let soundURL = Bundle.main.url(forResource: "schoolchimes_tone", withExtension: "wav") else {
//            print("Sound file not found")
//            return
//        }
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error)")
//        }
//    }
//
//    // Function to stop the sound
//    func stopNotificationSound() {
//        if let player = audioPlayer, player.isPlaying {
//            player.stop()
//            print("Notification sound stopped")
//        }
//    }
//}



import AVFoundation
class AudioManager { static let shared = AudioManager()
    private var audioPlayer: AVAudioPlayer?
    private var isAudioPlaying = false
    // Flag to track if audio is playing private init() {}
    func playSound(fileName: String, fileExtension: String) {
        guard let soundURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        else { print("Audio file not found.")
            return
        }
        
        
       
        if isAudioPlaying {
            stopAudio()
            
            print("Audio Stopped")
            
        }
        
        do {
            
            
            
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try audioSession.setActive(true)
            audioPlayer =
            try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            isAudioPlaying = true
            print("play Started")
            audioPlayer?.play()
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() +  30.0) { self.isAudioPlaying = false } }
        catch { print("Failed to play audio: \(error.localizedDescription)") } }
    
    func stopAudio()
    {
        if let player = audioPlayer, player.isPlaying {
            print("Audio Stopped22")
            player.stop()
        }
        isAudioPlaying = false
        audioPlayer = nil
        
    } }
