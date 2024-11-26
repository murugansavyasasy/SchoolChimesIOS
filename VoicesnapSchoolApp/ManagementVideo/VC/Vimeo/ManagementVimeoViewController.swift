//
//  ManagementVimeoViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 10/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation


class ManagementVimeoViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var progressCountLbl: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var progressShowView: UIView!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var webKitView: WKWebView!
    
    @IBOutlet weak var gifImg: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    var strVideoUrl = String()
    var videoId = String()
    var Id = ""
    var VideoType = "VIDEO"
    var getVideoPath = ""
    var downloadData : [DownloadResponseData] = []
    
    var bsaeUrl = "https://api.vimeo.com/videos/"
  
    var progressBarTimer: Timer!
    var isRunning = false
    var vimeoToken = "Bearer 8d74d8bf6b5742d39971cc7d3ffbb51a"
    var downloadId = ""
    var downloadUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  
    var getDownloadShowID : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.isHidden = true
      
        progressShowView.isHidden = true

        progressCountLbl.isHidden = true
        gifImg.isHidden = true
        
        
        videoPlayer()
        
        CallReadStatusUpdateApi(Id, VideoType)
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(back))
        viewBack.addGestureRecognizer(backGesture)
        
        print("managementDownloadShowID",getDownloadShowID)
        if getDownloadShowID == 0 {
            videoView.isHidden = false
        }else{
            videoView.isHidden = true
        }
        
        let videoGest = UITapGestureRecognizer(target: self, action: #selector(getVideoDownload))
        videoView.addGestureRecognizer(videoGest)
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
    
    
    
    
    func isVideoDownloaded() -> Bool {
        let fileManager = FileManager.default
        if let downloadsDirectory = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first {
            let videoFolder = downloadsDirectory.appendingPathComponent("VIDEO_FOLDER")
            let videoFile = videoFolder.appendingPathComponent("video_for_your_school.mp4")
            return fileManager.fileExists(atPath: videoFile.path)
        }
        return false
    }
    
    
    @objc func getVideoDownload () {
        btnStart()
        
        let jsonData = """
        {
            "app": {
                "name": "Voicesnap for schools",
                "uri": "/apps/177030"
            },
            "categories": [],
            "content_rating": ["unrated"],
            "content_rating_class": "unrated",
            "created_time": "2024-11-06T10:56:07+00:00",
            "description": "test",
            "download": [
                {
                    "created_time": "2024-11-06T10:56:53+00:00",
                    "expires": "2024-11-10T07:02:21+00:00",
                    "fps": 20,
                    "height": 320,
                    "link": "https://player.vimeo.com/progressive_redirect/download/1026844236/container/cc3c9cca-d29d-4051-9ed4-270ae5d3c2bf/f858b363/test_for_download%20%28360p%29.mp4?expires=1731222141&loc=external&oauth2_token_id=1346973768&signature=b2588e9344c656225dd7c506ccd1c6d81f56825ad3ec43505b37a46972fe4c73",
                    "md5": "<null>",
                    "public_name": "360p",
                    "quality": "sd",
                    "rendition": "360p",
                    "size": 38034,
                    "size_short": "37.14KB",
                    "type": "video/mp4",
                    "width": 320
                }
            ]
        }
        """.data(using: .utf8)!
           
        let urlString = bsaeUrl +  "1026844236"
        

        print("Download\(urlString)")
           guard let url = URL(string: urlString) else {
               print("Invalid URL")
               return
           }

           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"

          
        request.setValue(vimeoToken, forHTTPHeaderField: "Authorization")

          
           let session = URLSession.shared

          
        let task = session.dataTask(with: request) { [self] data, response, error in
               
               if let error = error {
                   print("Error:", error.localizedDescription)
                   return
               }

               guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                   print("Server error")
                   return
               }

               if let data = data {
                   do {
                       
                       let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                       
                       
                       if let downloadArray = jsonObject?["download"] as? [[String: Any]], let firstDownload = downloadArray.first {
                           print("Download node: \(firstDownload)")
                           
                         
                           if let link = firstDownload["link"] as? String {
                               print("Download link: \(link)")
                               
                               if let url = URL(string: link) {
                                   downloadVideo(from: url) { savedURL in
                                       if let savedURL = savedURL {
                                           
                                           
                                           getVideoPath = savedURL.absoluteString
                                           
                                           
                                           
                                           
                                           
                                           
                                           
                                           print("Downloaded video saved at: \(savedURL)")
                                           
                                       } else {
                                           print("Failed to download video.")
                                       }
                                   }
                               }
                               
                               
                           }
                           
                           if let size = firstDownload["size"] as? Int {
                               print("Size: \(size) bytes")
                           }
                       }
                   } catch {
                       print("Error parsing JSON: \(error)")
                   }
               }
           }

           
           task.resume()
   }
   
    

    
    func btnStart() {
                
                if(isRunning){
                    progressBarTimer.invalidate()
                }
                else{
                progressView.progress = 0.0
                self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
              
                }
                isRunning = !isRunning
            }

        @objc func updateProgressView(){
               progressView.progress += 0.1
            progressView.isHidden = false
          
            progressShowView.isHidden = false

            progressCountLbl.isHidden = false
            gifImg.isHidden = false
            
            var number = Int(progressView.progress*100)
            progressCountLbl.text = "Downloading" + " " + String(number) + " % "
            print("pr1234567", progressView.progress*100)
            if progressView.progress*100 == 100 {
                progressShowView.isHidden = true
                
                
                progressCountLbl.isHidden = true
                gifImg.isHidden = true
                
                
                _ = SweetAlert().showAlert("", subTitle: getVideoPath, style: .none, buttonTitle: "Ok", buttonColor: .black){
                    (okClick) in
                    if okClick{
                        self.dismiss(animated: true)
                    }else{
                        
                    }
                }
            }

            print("progressView progressView", progressView.progress)
               progressView.setProgress(progressView.progress, animated: true)
               if(progressView.progress == 1.0)
               {
                   
                   print(" progressView progressView 34444444", progressView.progress)
                   progressBarTimer.invalidate()
                   isRunning = false
                   
    
               }
           }
    
    
    
    
    func downloadVideo(from url: URL, completion: @escaping (URL?) -> Void) {
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { (tempLocalUrl, response, error) in
            if let error = error {
                print("Download error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let tempLocalUrl = tempLocalUrl else {
                print("Temporary file URL is nil.")
                completion(nil)
                return
            }
            
            do {
                // Get the destination path
                let fileManager = FileManager.default
                let documentsDirectory = try fileManager.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: false
                )
                let savedURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
                
                // Move downloaded file to the destination path
                if fileManager.fileExists(atPath: savedURL.path) {
                    try fileManager.removeItem(at: savedURL)
                }
                try fileManager.moveItem(at: tempLocalUrl, to: savedURL)
                print("File saved to: \(savedURL)")
                var urlConvert = savedURL.absoluteString
                var refreshAlert = UIAlertController(title: "", message: urlConvert, preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                  
//                    UserDefaults.standard.removeObject(forKey: Constant.DefaultsKeys.token)
                   

                
                                                     }))
                
                
                
               
            
                
                
                completion(savedURL)
            } catch {
                print("File error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        downloadTask.resume()
    }
    
}
