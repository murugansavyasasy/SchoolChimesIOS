////
////  AWSS3Manager.swift
////  VoicesnapSchoolApp
////
////  Created by admin on 02/11/23.
////  Copyright © 2023 Gayathri. All rights reserved.
////
//
//import Foundation
//import UIKit
////import AWSS3
//
//
//typealias progressBlock = (_ progress: Double) -> Void //2
//typealias completionBlock = (_ response: Any?, _ error: Error?) -> Void //3
//
//
//class AWSS3Manager {
//    
////    let S3BucketName =  DefaultsKeys.bucketNameIndia
////       
////    let CognitoPoolID = DefaultsKeys.CognitoPoolID
//    
//    static let shared = AWSS3Manager() // 4
//    private init () { }
//    let bucketName = DefaultsKeys.bucketNameIndia //5
//    
//    // Upload image using UIImage object
//    func uploadImage(image: UIImage, progress: progressBlock?, completion: completionBlock?) {
//        
//        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
//            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
//            completion?(nil, error)
//            return
//        }
//        
//        let tmpPath = NSTemporaryDirectory() as String
//        let fileName: String = ProcessInfo.processInfo.globallyUniqueString + (".jpeg")
//        let filePath = tmpPath + "/" + fileName
//        let fileUrl = URL(fileURLWithPath: filePath)
//        
//        do {
//            try imageData.write(to: fileUrl)
//            self.uploadfile(fileUrl: fileUrl, fileName: fileName, contenType: "image", progress: progress, completion: completion)
//        } catch {
//            let error = NSError(domain:"", code:402, userInfo:[NSLocalizedDescriptionKey: "invalid image"])
//            completion?(nil, error)
//        }
//    }
//    
//    // Upload video from local path url
//    func uploadVideo(videoUrl: URL, progress: progressBlock?, completion: completionBlock?) {
//        let fileName = self.getUniqueFileName(fileUrl: videoUrl)
//        self.uploadfile(fileUrl: videoUrl, fileName: fileName, contenType: "video", progress: progress, completion: completion)
//    }
//    
//    // Upload auido from local path url
//    func uploadAudio(audioUrl: URL, progress: progressBlock?, completion: completionBlock?) {
//        let fileName = self.getUniqueFileName(fileUrl: audioUrl)
//        self.uploadfile(fileUrl: audioUrl, fileName: fileName, contenType: "audio/mpeg", progress: progress, completion: completion)
//    }
//    
//    // Upload files like Text, Zip, etc from local path url
//    func uploadOtherFile(fileUrl: URL, conentType: String, progress: progressBlock?, completion: completionBlock?) {
//        let fileName = self.getUniqueFileName(fileUrl: fileUrl)
//        self.uploadfile(fileUrl: fileUrl, fileName: fileName, contenType: conentType, progress: progress, completion: completion)
//    }
//    
//    // Get unique file name
//    func getUniqueFileName(fileUrl: URL) -> String {
//        let strExt: String = "." + (URL(fileURLWithPath: fileUrl.absoluteString).pathExtension)
//        return (ProcessInfo.processInfo.globallyUniqueString + (strExt))
//    }
//    
//    //MARK:- AWS file upload
//    // fileUrl :  file local path url
//    // fileName : name of file, like "myimage.jpeg" "video.mov"
//    // contenType: file MIME type
//    // progress: file upload progress, value from 0 to 1, 1 for 100% complete
//    // completion: completion block when uplaoding is finish, you will get S3 url of upload file here
//    private func uploadfile(fileUrl: URL, fileName: String, contenType: String, progress: progressBlock?, completion: completionBlock?) {
//        // Upload progress block
//        let expression = AWSS3TransferUtilityUploadExpression()
//        expression.progressBlock = {(task, awsProgress) in
//            guard let uploadProgress = progress else { return }
//            DispatchQueue.main.async {
//                uploadProgress(awsProgress.fractionCompleted)
//            }
//        }
//        // Completion block
//        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
//        completionHandler = { (task, error) -> Void in
//            DispatchQueue.main.async(execute: {
//                if error == nil {
//                    let url = AWSS3.default().configuration.endpoint.url
//                    let publicURL = url?.appendingPathComponent(self.bucketName).appendingPathComponent(fileName)
//                    print("Uploaded to:\(String(describing: publicURL))")
//                    if let completionBlock = completion {
//                        completionBlock(publicURL?.absoluteString, nil)
//                    }
//                } else {
//                    if let completionBlock = completion {
//                        completionBlock(nil, error)
//                    }
//                }
//            })
//        }
//        // Start uploading using AWSS3TransferUtility
//        let awsTransferUtility = AWSS3TransferUtility.default()
//        awsTransferUtility.uploadFile(fileUrl, bucket: bucketName, key: fileName, contentType: contenType, expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
//            if let error = task.error {
//                print("error is: \(error.localizedDescription)")
//            }
//            if let _ = task.result {
//                // your uploadTask
//            }
//            return nil
//        }
//    }
//}
//
//
////class AWSS3Manager {
////    
////    var colgId : String!
////    static let shared = AWSS3Manager() // 4
////    private init () { }
//////    let bucketName = "college-app-files" //5
////    
////    let bucketName = "schoolchimes-india"
////    // Upload image using UIImage object
////    
////   
////    func uploadAWS(image : UIImage){
////        
////        
//////    https://college-app-files.s3.amazonaws.com/1/08-09-2023/File_20230908173239_temp_image6737982435270901193.jpg
//////
//////    https://s3.ap-south-1.amazonaws.comgradit-india/2023-18-12/File_vc_-7467165370173942861.jpg
////        
////        let defaults = UserDefaults.standard
//////        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
////        
////        let S3BucketName = "schoolchimes-india"
////        let CognitoPoolID = "ap-south-1:5358f3d7-ec74-4bf5-8b69-df26a06ebd6a"
////        let Region = AWSRegionType.APSouth1
////        
////        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:Region,identityPoolId:CognitoPoolID)
////        let configuration = AWSServiceConfiguration(region:Region, credentialsProvider:credentialsProvider)
////        AWSServiceManager.default().defaultServiceConfiguration = configuration
////        
////        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
////        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
////        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".jpg")
////        let dateFormatter = DateFormatter()
////
////        dateFormatter.dateFormat = "dd-MM-yyyy"
////
////        let  currentDate =   dateFormatter.string(from: Date())
////        
////        
////   
////        
////       
////        
////        let ext = imageName as String
////      
////        let fileName = imageNameWithoutExtension
////        let fileType = ".jpg"
////        
////        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
////        let data = image.jpegData(compressionQuality: 0.9)
////        do {
////            try data?.write(to: imageURL)
////        }
////        catch {}
////        
////        print(imageURL)
////        
////        let uploadRequest = AWSS3TransferManagerUploadRequest()
////        uploadRequest?.body = imageURL
////        uploadRequest?.key = colgId + "/" + currentDate +  "/" + "File_" + ext
////        uploadRequest?.bucket = S3BucketName
////        uploadRequest?.contentType = ".jpg"
////        
////        
////        // upload
////        
////        let transferManager = AWSS3TransferManager.default()
////        transferManager.upload(uploadRequest!).continueWith { [self] (task) -> AnyObject? in
////            
////            if let error = task.error {
////                print("Upload failed : (\(error))")
////            }
////            
////            if task.result != nil {
////                
////                let url = AWSS3.default().configuration.endpoint.url
////                let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
////                if  let absoluteString = publicURL?.absoluteString {
////                    print("Uploaded to:\(absoluteString)")
//////                    imgPdfType = "1"
//////
////                }
////            }
////            else {
////                print("Unexpected empty result.")
////            }
////            return nil
////        }
////    }
////    
////    
////    
////   
////
////
////    
////    // Upload video from local path url
////    func uploadVideo(videoUrl: URL, progress: progressBlock?, completion: completionBlock?) {
////        let fileName = self.getUniqueFileName(fileUrl: videoUrl)
////        self.uploadfile(fileUrl: videoUrl, fileName: fileName, contenType: "video", progress: progress, completion: completion)
////    }
////    
////    // Upload auido from local path url
////    func uploadAudio(audioUrl: URL, progress: progressBlock?, completion: completionBlock?) {
////        let fileName = self.getUniqueFileName(fileUrl: audioUrl)
////        self.uploadfile(fileUrl: audioUrl, fileName: fileName, contenType: "audio", progress: progress, completion: completion)
////    }
////    
////    // Upload files like Text, Zip, etc from local path url
////    func uploadOtherFile(fileUrl: URL, conentType: String, progress: progressBlock?, completion: completionBlock?) {
////        let fileName = self.getUniqueFileName(fileUrl: fileUrl)
////        self.uploadfile(fileUrl: fileUrl, fileName: fileName, contenType: conentType, progress: progress, completion: completion)
////    }
////    
////    // Get unique file name
////    func getUniqueFileName(fileUrl: URL) -> String {
////        let strExt: String = "." + (URL(fileURLWithPath: fileUrl.absoluteString).pathExtension)
////        return (ProcessInfo.processInfo.globallyUniqueString + (strExt))
////    }
////    
////    //MARK:- AWS file upload
////    // fileUrl :  file local path url
////    // fileName : name of file, like "myimage.jpeg" "video.mov"
////    // contenType: file MIME type
////    // progress: file upload progress, value from 0 to 1, 1 for 100% complete
////    // completion: completion block when uplaoding is finish, you will get S3 url of upload file here
////    private func uploadfile(fileUrl: URL, fileName: String, contenType: String, progress: progressBlock?, completion: completionBlock?) {
////        // Upload progress block
////        
////     
////        let expression = AWSS3TransferUtilityUploadExpression()
////        expression.progressBlock = {(task, awsProgress) in
////            guard let uploadProgress = progress else { return }
////            DispatchQueue.main.async {
////                uploadProgress(awsProgress.fractionCompleted)
////            }
////        }
////        // Completion block
////        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
////        completionHandler = { (task, error) -> Void in
////            DispatchQueue.main.async(execute: {
////                if error == nil {
////                    let url = AWSS3.default().configuration.endpoint.url
////                    let publicURL = url?.appendingPathComponent(self.bucketName).appendingPathComponent(fileName)
////                    print("Uploaded to:\(String(describing: publicURL))")
////                    if let completionBlock = completion {
////                        completionBlock(publicURL?.absoluteString, nil)
////                    }
////                } else {
////                    if let completionBlock = completion {
////                        completionBlock(nil, error)
////                    }
////                }
////            })
////        }
////        // Start uploading using AWSS3TransferUtility
////        
////        let dateFormatter = DateFormatter()
////
////        dateFormatter.dateFormat = "yyyy-mm-dd"
////
////        let  currentDate =   dateFormatter.string(from: Date())
////        
////        
////        let aws_file_path = colgId + "/" + currentDate + "/" + fileName
////        
////        print("aws_file_pathaws",aws_file_path)
////
////        
////        let awsTransferUtility = AWSS3TransferUtility.default()
////        awsTransferUtility.uploadFile(fileUrl, bucket: bucketName, key: aws_file_path, contentType: contenType, expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
////            if let error = task.error {
////                print("AWS error is: \(error.localizedDescription)")
////            }
////            if let _ = task.result {
////                // your uploadTask
////            }
////            return nil
////        }
////    }
////}
