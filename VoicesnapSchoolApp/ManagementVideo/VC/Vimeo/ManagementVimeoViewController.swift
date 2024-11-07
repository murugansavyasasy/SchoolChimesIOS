//
//  ManagementVimeoViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 10/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import WebKit

class ManagementVimeoViewController: UIViewController,UIWebViewDelegate {

    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var webKitView: WKWebView!
    
    var strVideoUrl = String()
    var videoId = String()
    var Id = ""
    var VideoType = "VIDEO"
    override func viewDidLoad() {
        super.viewDidLoad()

        
        videoPlayer()
        
        CallReadStatusUpdateApi(Id, VideoType)
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(back))
        viewBack.addGestureRecognizer(backGesture)
    }

    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    

    func videoPlayer(){
        print("videoidbefore",videoId)
        let videoid = videoId
        print("videoid",videoid)
        if let yourVimeoLink = URL(string: "https://player.vimeo.com/video/\(videoid)")  {
            print("yourVimeoLink",yourVimeoLink)
            self.webKitView.backgroundColor = UIColor.black
            self.webKitView.isOpaque = false
            webKitView.contentMode = UIView.ContentMode.scaleToFill
            webKitView.load(URLRequest(url:yourVimeoLink))
            webKitView.contentMode = UIView.ContentMode.scaleToFill
        }
    }
    
    

    func CallReadStatusUpdateApi(_ ID : String, _ type : String) {
      
        
                    let couts = CountReqModal()
                    couts.Types = type
                    couts.ID = ID
                 
                
                
                let countStr = couts.toJSONString()
                print("requessttttt",countStr)

        VideoCountRequest.call_request(param: countStr!){
                    [self] (res) in
                    
                    print("responsAPiii",res)

                   

                }
    }
    
}
