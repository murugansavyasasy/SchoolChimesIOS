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

    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var webKitView: WKWebView!
    
    var strVideoUrl = String()
    var videoId = String()
    var Id = ""
    var VideoType = "VIDEO"
    
    var bsaeUrl = "https://api.vimeo.com/videos/"
  
    var vimeoToken = "Bearer 8d74d8bf6b5742d39971cc7d3ffbb51a"
    var downloadId = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
                completion(savedURL)
            } catch {
                print("File error: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        downloadTask.resume()
    }
    
    
    @objc func getVideoDownload () {
      
           
        let urlString = bsaeUrl + downloadId
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
                       // Try to decode the JSON or handle the data as needed
                       let json = try JSONSerialization.jsonObject(with: data, options: [])
                       print("Response JSON:", json)
                       if let url = URL(string: "https://player.vimeo.com/progressive_redirect/download/1026844236/container/cc3c9cca-d29d-4051-9ed4-270ae5d3c2bf/f858b363/test_for_download%20%28360p%29.mp4?expires=1731051047&loc=external&oauth2_token_id=1346973768&signature=65b883e59a04e61156286392b5bec0b8969417fbeacd0ff8bd97e1f229392710") {
                           downloadVideo(from: url) { savedURL in
                               if let savedURL = savedURL {
                                   print("Downloaded video saved at: \(savedURL)")
                                   // Use the saved URL as needed
                               } else {
                                   print("Failed to download video.")
                               }
                           }
                       }
                   } catch {
                       print("Error parsing JSON:", error.localizedDescription)
                   }
               }
           }

           // Start the request
           task.resume()
   }
   
    
}
