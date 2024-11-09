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
    var isDownload = true
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
//    func downloadVideo(from url: URL, completion: @escaping (URL?) -> Void) {
//        let session = URLSession(configuration: .default)
//        let downloadTask = session.downloadTask(with: url) { (tempLocalUrl, response, error) in
//            if let error = error {
//                print("Download error: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//            
//            guard let tempLocalUrl = tempLocalUrl else {
//                print("Temporary file URL is nil.")
//                completion(nil)
//                return
//            }
//            
//            do {
//                // Get the destination path
//                let fileManager = FileManager.default
//                let documentsDirectory = try fileManager.url(
//                    for: .documentDirectory,
//                    in: .userDomainMask,
//                    appropriateFor: nil,
//                    create: false
//                )
//                let savedURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
//                
//                // Move downloaded file to the destination path
//                if fileManager.fileExists(atPath: savedURL.path) {
//                    try fileManager.removeItem(at: savedURL)
//                }
//                try fileManager.moveItem(at: tempLocalUrl, to: savedURL)
//                print("File saved to: \(savedURL)")
//                completion(savedURL)
//            } catch {
//                print("File error: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }
//        
//        downloadTask.resume()
//    }
    
    
    @objc func getVideoDownload () {
//        btnStart()
        
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
        
//        fetchDownloadURLs(from: urlString)
//        downloadId
        print("Download\(urlString)")
           guard let url = URL(string: urlString) else {
               print("Invalid URL")
               return
           }

           // Set up the URL request
           var request = URLRequest(url: url)
           request.httpMethod = "GET"

          
        request.setValue(vimeoToken, forHTTPHeaderField: "Authorization")

           // Initialize a URLSession
           let session = URLSession.shared

           // Start the data task
        let task = session.dataTask(with: request) { [self] data, response, error in
               // Handle the response
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
                       // Parse the JSON data
                       let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                       
                       // Access the "download" node
                       if let downloadArray = jsonObject?["download"] as? [[String: Any]], let firstDownload = downloadArray.first {
                           print("Download node: \(firstDownload)")
                           
                           // Access individual values in the download node
                           if let link = firstDownload["link"] as? String {
                               print("Download link: \(link)")
                               let userDefaults = UserDefaults.standard
//                               getVideoPath = userDefaults.string(forKey: link)!
                               
                               downloadVideo(downloadUrl : link )
                             
                               let filePath = getVideoPath
                               if isVideoFile(at: filePath) {
                                   print("This is a video file.")
                               } else {
                                   print("This is not a video file.")
                                   
                                   
//                                   if let url = URL(string: link) {
//                                       downloadVideo(downloadUrl : link ){ savedURL in
//                                           if let savedURL = savedURL {
//                                               
//                                               
//                                               
//                                               
////                                               getVideoPath = savedURL.absoluteString
//                                               
//                                               
//                                               
//                                               
//                                               
//                                               print("Downloaded video saved at: \(savedURL)")
//                                               // Use the saved URL as needed
//                                           } else {
//                                               print("Failed to download video.")
//                                           }
//                                       }
//                                   }
                                   
                                   
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

           // Start the request
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
            progressCountLbl.text = String(number) + " % "
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
//            let gifURL = UIImage.gif(name: "video_uploaded")
//                      // Use SDWebImage to load and display the GIF image
//            gifImg.image = gifURL
//            self.gifImg.image = UIImage.gif(name: "video_uploaded")

            print("progressView progressView", progressView.progress)
               progressView.setProgress(progressView.progress, animated: true)
               if(progressView.progress == 1.0)
               {
                   
                   print(" progressView progressView 34444444", progressView.progress)
                   progressBarTimer.invalidate()
                   isRunning = false
                   
    //               btn.setTitle("Start", for: .normal)
               }
           }
    
    
    func isVideoFile(at path: String) -> Bool {
        let fileManager = FileManager.default
        
        // Check if the file exists
        guard fileManager.fileExists(atPath: path) else {
            print("File does not exist at path: \(path)")
            return false
        }
        
        // Get the file URL
        let fileURL = URL(fileURLWithPath: path)
        
        // Verify the file is a video using AVURLAsset
        let asset = AVURLAsset(url: fileURL)
        let videoTracks = asset.tracks(withMediaType: .video)
        
        return !videoTracks.isEmpty
    }
    
    
    
    
    
    
    func downloadVideo(downloadUrl: String) {
        DispatchQueue.main.async { [self] in
            // Inflate the custom layout for the dialog
            let alert = UIAlertController(title: nil, message: "Downloading...", preferredStyle: .alert)
            
            let progressView = UIProgressView(progressViewStyle: .default)
            progressView.frame = CGRect(x: 10, y: 70, width: 250, height: 0)
            alert.view.addSubview(progressView)
            
            let progressLabel = UILabel(frame: CGRect(x: 10, y: 90, width: 250, height: 20))
            progressLabel.text = "0%"
            alert.view.addSubview(progressLabel)
            
            // Show the AlertDialog
            present(alert, animated: true)
            
            // Start the download
            startDownload(downloadUrl: downloadUrl, progressView: progressView, progressLabel: progressLabel, alert: alert)
        }
    }
    func startDownload(downloadUrl: String, progressView: UIProgressView, progressLabel: UILabel, alert: UIAlertController) {
        let downloadDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let videoFolder = downloadDirectory.appendingPathComponent("VIDEO_FOLDER")
        let videoFile = videoFolder.appendingPathComponent("video_for_your_school.mp4")
        if !FileManager.default.fileExists(atPath: videoFolder.path) {
            do {
                try FileManager.default.createDirectory(at: videoFolder, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create directory: \(error.localizedDescription)")
                return
            }
        }
        guard let url = URL(string: downloadUrl) else { return }
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        
        let downloadTask = session.downloadTask(with: url) { [self] (tempUrl, response, error) in
            if let tempUrl = tempUrl {
                do {
                    try FileManager.default.moveItem(at: tempUrl, to: videoFile)
                    DispatchQueue.main.async {
                        alert.dismiss(animated: true) { [self] in
                            showAlert(title: "Downloaded successfully", message: "File stored in: \(videoFile.path)")
                        }
                    }
                } catch {
                   
                    print("Error saving video: \(error)")
                    showAlert(title: "", message: "item with the same name already exists")
                }
            } else {
                DispatchQueue.main.async {
                    alert.dismiss(animated: true) { [self] in
                        showAlert(title: "Download failed", message: "")
                    }
                }
            }
        }
        downloadTask.resume()
        
        // Progress tracking using URLSessionTaskDelegate
        let observation = downloadTask.progress.observe(\.fractionCompleted) { progress, _ in
            DispatchQueue.main.async {
                let percent = Int(progress.fractionCompleted * 100)
                progressView.progress = Float(progress.fractionCompleted)
                progressLabel.text = "\(percent)%"
            }
        }
    }
    func showAlert( title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    func checkAndDownload() {
        if isDownload {
            isDownload = false
            if !isVideoDownloaded() {
                downloadVideo(downloadUrl: downloadUrl)
            } else {
                DispatchQueue.main.async {
                    // Show a toast message (similar to Toast in Android)
                    let alert = UIAlertController(title: "Info", message: "Video is already downloaded!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
