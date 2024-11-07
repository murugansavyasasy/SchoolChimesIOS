//
//  VimeoVideoDetailVC.swift
//  VoicesnapSchoolApp
//
//  Created by Preethi on 27/05/20.
//  Copyright © 2020 Shenll-Mac-04. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import PlayerKit
import WebKit

class VimeoVideoDetailVC: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webKitView: WKWebView!
    var strVideoUrl = String()
    var videoId = String()
    let player = RegularPlayer()
    var hud : MBProgressHUD = MBProgressHUD()
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        //
        print("ManageVideo")
        print("Video4")
        print("videoId",videoId)
        
        
        
        videoPlayer()
        
        
        
    }
    
    func videoPlayer(){
        let videoid = videoId.components(separatedBy:"/")
        print("videoid",videoid)
        if let yourVimeoLink = URL(string: "https://player.vimeo.com/video/\(videoid[0])")  {
            print("yourVimeoLink",yourVimeoLink)
            self.showLoading()
            self.webKitView.backgroundColor = UIColor.black
            self.webKitView.isOpaque = false
            webKitView.contentMode = UIView.ContentMode.scaleToFill
            webKitView.load(URLRequest(url:yourVimeoLink))
            webKitView.contentMode = UIView.ContentMode.scaleToFill
        }
    }
    
    
    func videoPlayer2(){
        let player = RegularPlayer()
        
        view.addSubview(player.view) // RegularPlayer conforms to `ProvidesView`, so we can add its view
        if let yourVimeoLink = URL(string: "https://player.vimeo.com/video/423522889")  {
            player.set(AVURLAsset(url: yourVimeoLink))
            player.volume = 1
            player.play()
        }
    }
    
    func videoPlayer1(){
        
        if let yourVimeoLink = URL(string: strVideoUrl)  {
            self.showLoading()
            let videoid = videoId.components(separatedBy:"/")
            let width = String(describing: self.webKitView.frame.size.width)
            let height = String(describing: self.webKitView.frame.size.height)
            print(height)
            webKitView.backgroundColor = UIColor.clear
            let embedHTML = "<iframe src=\"https://player.vimeo.com/video/\(videoid[0])?title=0&amp;byline=1&amp;playsinline=1&amp;portrait=1&amp;badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=177030\" frameborder=\"0\" width=\"350\" height=\"600\" allow=\"autoplay; fullscreen\" allowfullscreen></iframe>"
            webKitView.loadHTMLString(embedHTML as String, baseURL:yourVimeoLink )
            webKitView.contentMode = UIView.ContentMode.scaleToFill
            
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideLoading()
    }
    
    func showLoading() -> Void {
        //  self.view.window?.userInteractionEnabled = false
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.animationType = MBProgressHUDAnimationFade
        hud.labelText = "Loading"
        
    }
    
    func hideLoading() -> Void{
        
        hud.hide(true)
    }
    
    @IBAction func actionBack(_ sender: UIButton){
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "comeBackVimeoVideo"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
}
