//
//  LsrwListShowViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/20/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import PhotosUI
import Alamofire
import ObjectMapper

enum UploadResult {
case success(String)
case failure(Error)
}

class LsrwListShowViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate, PHPickerViewControllerDelegate,UITableViewDelegate,UITableViewDataSource {
  
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var tv: UITableView!
    var currentImageCount = 0
    var originalImagesArray = [UIImage]()
    var imageUrlArray = NSMutableArray()
    var  getImagePdfType : String!
    var convertedImagesUrlArray = NSMutableArray()
    var pdfData : Data? = nil
    
    var selectedImages: [UIImage] = []
    var authToken = "8d74d8bf6b5742d39971cc7d3ffbb51a"
    var videoEmbdUrl : String!
    var iframeLink : String!
    var videoSucessId = 0
  
    var imageStr : [String] = []
    var totalImageCount = 0
    var onImagesPicked: (([UIImage]) -> Void)?

    var onPdfPicked: ((Data) -> Void)?
    var onImagePicked: (([UIImage]) -> Void)?
    var viewSkillDatas : [ViewAllSkillByData] = []
    var rowIdentifier = "LsrwListShowTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        
        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier: rowIdentifier)
        
        
        viewAllSkillByStudent()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
    @IBAction func presentSelectionAlert() {
        let alertController = UIAlertController(title: "Select", message: "Choose an option", preferredStyle: .actionSheet)
        
        // Camera option
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [self] _ in
            
            openCamera()
        }
        alertController.addAction(cameraAction)
        
        // Gallery option
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [self] _ in
            
            selectImages()
            
        }
        alertController.addAction(galleryAction)
        
        
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func openCamera() {
        // Check if the camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true // Allows editing of the captured image
            present(imagePicker, animated: true, completion: nil)
        } else {
            // Camera is not available, show an alert
            let alert = UIAlertController(title: "Camera Not Available", message: "This device has no camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    func selectPDF() {
        
        print("SELECT PDF")
        
        
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt urls: URL) {
        
        
        
        
        let fileurl: URL = urls as URL
        let filename = urls.lastPathComponent
        let fileextension = urls.pathExtension
        print("URL: \(fileurl)", "NAME: \(filename)", "EXTENSION: \(fileextension)")
        
        
        let imageData = NSData(contentsOf: urls)
        
        
        
        
        do {
            pdfData = try Data(contentsOf: urls, options: NSData.ReadingOptions())
            uploadPDFFileToAWS(pdfData: pdfData!)
            
        } catch {
            print("set PDF filer error : ", error)
            
        }
        
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func selectImages() {
           var config = PHPickerConfiguration()
           config.selectionLimit = 5  // Limit selection to 5 images
           config.filter = .images    // Only allow images
           
           let picker = PHPickerViewController(configuration: config)
           picker.delegate = self
           present(picker, animated: true, completion: nil)
       }
    
    
    func uploadPDFFileToAWS(pdfData : Data){
        let S3BucketName = DefaultsKeys.bucketNameIndia
        let CognitoPoolID = DefaultsKeys.CognitoPoolID
        let Region = AWSRegionType.APSouth1
        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".pdf")
        
        let ext = imageName as String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let  currentDate =   dateFormatter.string(from: Date())
        
        
        let fileName = imageNameWithoutExtension
        let fileType = ".pdf"
        
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
        
        do {
            try pdfData.write(to: imageURL)
        }
        catch {}
        
        print(imageURL)
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        
        uploadRequest?.body = imageURL
        uploadRequest?.key =  currentDate +  "/" + "File_" + ext
        uploadRequest?.bucket = S3BucketName
        
        uploadRequest?.contentType = "application/pdf"
        
        
        let transferManager = AWSS3TransferManager.default()
        transferManager.upload(uploadRequest!).continueWith { [self] (task) -> AnyObject? in
            
            if let error = task.error {
                print("Upload failed : (\(error))")
                
                
            }
            
            if task.result != nil {
                let url = AWSS3.default().configuration.endpoint.url
                let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
                if let absoluteString = publicURL?.absoluteString {
                    print("Uploaded to:\(absoluteString)")
                    
                    let imageDict = NSMutableDictionary()
                    imageDict["FileName"] = absoluteString
                    self.imageUrlArray.add(imageDict)
                    self.convertedImagesUrlArray = self.imageUrlArray
                    
                    
                    
                    
                    
                }
            }
            else {
                
                
                print("Unexpected empty result.")
            }
            return nil
        }
    }
    
    
    
    func presentPhotoPicker(from viewController: UIViewController, selectionLimit: Int = 1) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = selectionLimit
        configuration.filter = .images // Only images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        viewController.present(picker, animated: true, completion: nil)
    }

    // Delegate method to handle selected items
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        var images = [UIImage]()
        let dispatchGroup = DispatchGroup()
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                dispatchGroup.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                    if let image = object as? UIImage {
                        images.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.onImagePicked?(images)
        }
    }
    
    func uploadAWS(image : UIImage){
    
        let S3BucketName =  DefaultsKeys.bucketNameIndia
           
        let CognitoPoolID = DefaultsKeys.CognitoPoolID
        let Region = AWSRegionType.APSouth1
        
        
      
        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".png")
        
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let  currentDate =   dateFormatter.string(from: Date())
        
        let ext = imageName as String
        
        let fileName = imageNameWithoutExtension
        let fileType = ".jpg"
        
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
        let data = image.jpegData(compressionQuality: 0.9)
        do {
            try data?.write(to: imageURL)
        }
        catch {}
        
        print(imageURL)
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.body = imageURL
        uploadRequest?.key =   currentDate +  "/" + "File_" + ext
        uploadRequest?.bucket = S3BucketName
        
        if getImagePdfType == "Image" {
            uploadRequest?.contentType = "image/png"
        } else{
            uploadRequest?.contentType = "image/png"
        }
      
        
        let transferManager = AWSS3TransferManager.default()
        transferManager.upload(uploadRequest!).continueWith { [self] (task) -> AnyObject? in
            
            if let error = task.error {
                print("Upload failed : (\(error))")
            }
            var imageFilePath = NSMutableArray()
            if task.result != nil {
                let url = AWSS3.default().configuration.endpoint.url
                let publicURL = url?.appendingPathComponent((uploadRequest?.bucket!)!).appendingPathComponent((uploadRequest?.key!)!)
                if let absoluteString = publicURL?.absoluteString {
                    print("Uploaded to:\(absoluteString)")
                    
                  
                    
                    
               
                  
                    
                    let imageDicthome = NSMutableDictionary()
                    imageDicthome["path"] = absoluteString
                    imageDicthome["type"] = "IMAGE"
                    let imageDict = NSMutableDictionary()
                    var emptyDictionary = [String: String]()
                    
                    imageFilePath.add(imageDicthome)
                    
                    
                    
                
                    
                    self.currentImageCount = self.currentImageCount + 1
                    if self.currentImageCount < self.totalImageCount{
                        DispatchQueue.main.async {
                            self.getImageURL(images: self.originalImagesArray)
                        }
                    }else{
                        self.convertedImagesUrlArray = self.imageUrlArray
                        
                        
                    }
                }
            }
            
            return nil
        }
       
    }
    func getImageURL(images : [UIImage]){
        
        
        
        self.originalImagesArray = images
        self.totalImageCount = images.count
        if currentImageCount < images.count{
            self.uploadAWS(image: images[currentImageCount])
        }
    }
    
    @IBAction   func pickVideoFromGallery() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.mediaTypes = ["public.movie"] // Only show videos
                imagePickerController.allowsEditing = true // Optional: allows users to edit video
                
                present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Photo library not available.")
            }
        }
        
        // MARK: This method is called when the user has picked a video
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                print("Selected video URL: \(videoURL)")
                uploadVideo(authToken: authToken, videoFilePath: videoURL)
                
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        //MARK: This method is called when the user cancels the picker
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }

    
    
    
    func getFileSize(at url: URL) -> UInt64? {
    do {
        let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
        if let fileSize = attributes[FileAttributeKey.size] as? UInt64 {
            return fileSize
        }
    } catch {
        print("Error: \(error)")
    }
    return nil
    }

    func createVimeoUploadURL(authToken: String, videoFilePath: URL, completion: @escaping (UploadResult) -> Void) {

  

    
    guard let fileSize = getFileSize(at: videoFilePath) else {
        completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to get file size"])))
        return
    }

    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(authToken)",
        "Content-Type": "application/json",
        "Accept": "application/vnd.vimeo.*+json;version=3.4"
    ]

    let parameters: [String: Any] = [
        "upload": [
            "approach": "tus",
            "size": "\(fileSize)"
        ],
        "name": "TestTitle",
        "description": "descTxtFld.text"
    ]

    AF.request("https://api.vimeo.com/me/videos", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                print("Vimeo API Response: \(value)") // Print the full JSON
                if let json = value as? [String: Any],
                   let upload = json["upload"] as? [String: Any],
                   let uploadLink = upload["upload_link"] as? String {
                    
                    let embedUrl = json["player_embed_url"] as! String
                    
                    let embed = json["embed"]! as AnyObject
//                    iframeLink = embed["html"]  as! String
                    videoEmbdUrl = embedUrl as! String
                   
                    videoSucessId = 1
                    
                    VideoStatus()
                    completion(.success(uploadLink))
                    
                    
                } else {
                    completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Upload link not found"])))
                    
                    videoSucessId = 0
                    VideoStatus()
                }
            case .failure(let error):
                completion(.failure(error))
                
                
                videoSucessId = 0
                VideoStatus()
            }
        }
    }

    func uploadVideoToVimeo(uploadLink: String, videoFilePath: URL, authToken: String, chunkSize: Int = 5 * 1024 * 1024, completion: @escaping (UploadResult) -> Void) {
    guard let fileHandle = try? FileHandle(forReadingFrom: videoFilePath) else {
        completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to read video file"])))
        return
    }
   
    var offset: Int = 0
    let fileSize = fileHandle.seekToEndOfFile()
    fileHandle.seek(toFileOffset: 0)

    print("fileHandleBefore",fileHandle)
    func uploadNextChunk() {
        let chunkData = fileHandle.readData(ofLength: chunkSize)
        
        if chunkData.isEmpty {
            fileHandle.closeFile()
            completion(.success(("")))
            return
        }
        
        var request = URLRequest(url: URL(string: uploadLink)!)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/offset+octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue("\(offset)", forHTTPHeaderField: "Upload-Offset")
        request.setValue("1.0.0", forHTTPHeaderField: "Tus-Resumable")
        request.httpBody = chunkData
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: chunkData) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 204 {
                    offset += chunkSize
                    uploadNextChunk()
                } else if httpResponse.statusCode == 412 {
                    // Handle 412 error (precondition failed), retry or get correct offset from server
                    if let rangeHeader = httpResponse.value(forHTTPHeaderField: "Upload-Offset"), let serverOffset = Int(rangeHeader) {
                        offset = serverOffset
                        uploadNextChunk()
                    } else {
                        let error = NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to upload chunk: Precondition Failed"])
                        completion(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to upload chunk, status code: \(httpResponse.statusCode)"])
                    completion(.failure(error))
                }
            }
        }
        
        uploadTask.resume()
    }

    uploadNextChunk()
    }

        
        func VideoStatus(){
            
            if videoSucessId == 0 {
                

            }else{
                
            }
            
        }
    func uploadVideo(authToken: String, videoFilePath: URL) {
    createVimeoUploadURL(authToken: authToken, videoFilePath: videoFilePath) { [self] result in
        switch result {
        case .success(let uploadLink):
            uploadVideoToVimeo(uploadLink: uploadLink, videoFilePath: videoFilePath, authToken: authToken) { [self] result in
                switch result {
                case .success:
                    print("Video uploaded successfully!")
                   
                   
                case .failure(let error):
                    print("Failed to upload video: \(error)")
   
                   
                    let refreshAlert = UIAlertController(title: "", message: "Failed to upload video", preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                        
                    }))
                    
                    
                    present(refreshAlert, animated: true, completion: nil)
                    
                    
                   
                }
                
                
            }
        case .failure(let error):
            print("Failed to create upload URL: \(error)")
   
           
            let refreshAlert = UIAlertController(title: "", message: "Failed to upload video", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
            }))
            
            
            present(refreshAlert, animated: true, completion: nil)
            
            
        }
    }
    }


    
    
    @IBAction func takeReadingSkill() {
        let vc = LSRWTakingSkillViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:   true)
    }

    
    
    
    
    
    func viewAllSkillByStudent(){
        
        
        
        
        let viewAllSkillByStudentModal = ViewAllSkillByStudentModal()
        viewAllSkillByStudentModal.StudentID = "10391374"
        viewAllSkillByStudentModal.SchoolID = "7050"
        
        
        var  viewAllSkillByStudentModalStr = viewAllSkillByStudentModal.toJSONString()
      
        
        ViewAllSkillByStudentRequest.call_request(param: viewAllSkillByStudentModalStr!) {
            
            [self] (res) in
            
            let viewAllSkillByStudentResp : ViewAllSkillByStudentResponse = Mapper<ViewAllSkillByStudentResponse>().map(JSONString: res)!
            
            if viewAllSkillByStudentResp.Status == 1 {
                viewSkillDatas = viewAllSkillByStudentResp.viewAllSkillByData
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
            }
            
            
        }
        
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewSkillDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! LsrwListShowTableViewCell
        
        
        let skillData : ViewAllSkillByData = viewSkillDatas[indexPath.row]
        cell.descLbl.text = ": " + skillData.Description
//        cell.sentByLbl.text = ": " + skillData.SentBy
        cell.subLbl.text = ": " + skillData.Subject
        cell.titleLbl.text =  ": " + skillData.Title
        cell.submittedOnLbl.text = ": " + skillData.SubmittedOn
        
        if skillData.Issubmitted == "1" {
            cell.takingSkillView.isHidden = true
            cell.submittedOnLbl.isHidden = false
            cell.submittedHeadingLbl.isHidden = false
            
        }else{
            cell.takingSkillView.isHidden = false
            cell.typeLbl.text = skillData.ActivityType
            cell.submittedOnLbl.isHidden = true
            cell.submittedHeadingLbl.isHidden = true
//            cell.takingSkillBtn.setTitle(skillData.ActivityType, for: .normal)
        }
        
        
        let attachGes = LsrwListShowGesture(target: self, action: #selector(AttachmentRedirect))
        attachGes.getSkillId = String(skillData.SkillId)
        cell.takingSkillView.addGestureRecognizer(attachGes)

        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    @IBAction func AttachmentRedirect(ges : LsrwListShowGesture) {
        
        
        let vc = LSRWTakingSkillViewController(nibName: nil, bundle: nil)
        vc.skillId = ges.getSkillId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
}


class LsrwListShowGesture : UITapGestureRecognizer {
    var getSkillId : String!
}
