//
//  StaffGroupVoiceViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 04/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import KRProgressHUD


class StaffGroupVoiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,Apidelegate {
    
    
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var tv: UITableView!
    
    let rowIdentifier = "SendStaffGroupsVoiceTableViewCell"
    
    var getGroupList : [SendStaffGroupsVoiceResponse] = []
    var targetListArr : [StaffGroupsVoiceGrpCode] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var StaffId = UserDefaults.standard.object(forKey: STAFFID) as? String
    var hud : MBProgressHUD = MBProgressHUD()
    var absoluteStringPdf : String!
    var DescStr : String!
    var MessageStr : String!
    var SchoolId = String()
    var selectType : String!
    var SchoolDetailDict:NSDictionary = [String:Any]() as NSDictionary
    var strCountryCode = String()
    var strSomething = String()
    var strApiFrom = NSString()
    let UtilObj = UtilClass()
    var SelectedSectionDeatil:NSDictionary = [String:Any]() as NSDictionary
    var SendedScreenNameStr = String()
    var sendToGroupType : String!
    
    //    IMAGE / PDF USING VARIABLES
    var imgDesc : String!
    var imgFilePath = NSMutableArray()
    var pdfData : NSData?
    var pdfDataType : String!
    var absoluteStringImg : String!
    var ImageFileNameArrayArr : [StaffGroupsImagePdfFileNameArray] = []
    var ImageTargetListArr : [StaffGroupsImagePdfGrpCode] = []
    var currentImageCount = 0
    var totalImageCount = 0
    var imageUrlArray = NSMutableArray()
    var originalImagesArray = [UIImage]()
    var convertedImagesUrlArray = NSMutableArray()
    var imagesArrayGet = NSMutableArray()
    var imgPdfType : String!
    
    
    
    //    VOICE USING VARIABLES
    var voiceDesc : String!
    var voiceUrlData : URL!
    var voiceDurationString : String!
    var VoiceTargetListArr : [StaffVoiceGrpCode] = []
    
    var targetIds : String!
    
    var fromView :String!
    var voiceHistoryArray = NSMutableArray()
    
    //    VIDEO USING VARIABLES
    var vimeoVideoDictURL : String!
    var vimeoVideoURL : URL!
    var vimeoVideoDictIframe : String!
    var VideoData : NSData? = nil
    var vimeoVideoDict = NSMutableDictionary()
    var videoDesc : String!
    var videoTitle : String!
    var videoProcessBy : String!
    var VideoTargetListArr : [StaffGroupsVideoGrpCode] = []
    

    var countryCoded : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
        countryCoded =  UserDefaults.standard.object(forKey: COUNTRY_ID) as! String
        
        self.tv.estimatedRowHeight = 200.0
        self.tv.rowHeight = 200
        tv.dataSource = self
        tv.delegate = self
        
        strApiFrom = "VimeoVidoUpload"
        print("strApiFrom",strApiFrom)
        
        
        
        
        
        print("voiceUrlData",voiceUrlData)
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(cancelVC))
        closeView.addGestureRecognizer(backGesture)
        
        groupsList()
    }
    
//    
//    func CallUploadVideoToVimeoServer() {
//        self.showLoading()
//        strApiFrom = "VimeoVidoUpload"
//        
//        let vimeoAccessToken = appDelegate.VimeoToken
//        
//        print("vimeoVideoURL!",vimeoVideoURL)
//        print("VimeoTokenVimeoToken",appDelegate.VimeoToken)
//        createVimeoUploadURL(authToken: vimeoAccessToken, videoFilePath: vimeoVideoURL) { [self] result in
//            switch result {
//            case .success(let uploadLink):
//                uploadVideoToVimeo(uploadLink: uploadLink, videoFilePath: vimeoVideoURL, authToken: vimeoAccessToken) { [self] result in
//                    switch result {
//                    case .success:
//                        print("Video uploaded successfully!")
//                        
//                        
//                    case .failure(let error):
//                        print("Failed to upload video: \(error)")
//                        
//                        let refreshAlert = UIAlertController(title: "", message: "Failed to upload video", preferredStyle: UIAlertController.Style.alert)
//                        
//                        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                            
//                            
//                        }))
//                        
//                        
//                        present(refreshAlert, animated: true, completion: nil)
//                        
//                        
//                    }
//                }
//            case .failure(let error):
//                print("Failed to create upload URL: \(error)")
//                
//                let refreshAlert = UIAlertController(title: "", message: "Failed to upload video", preferredStyle: UIAlertController.Style.alert)
//                
//                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
//                }))
//                
//                
//                present(refreshAlert, animated: true, completion: nil)
//                
//                
//            }
//        }
//        
//    }
//    
//    
//    
//    enum UploadResult {
//        case success(String)
//        case failure(Error)
//    }
//    
//    func getFileSize(at url: URL) -> UInt64? {
//        do {
//            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
//            if let fileSize = attributes[FileAttributeKey.size] as? UInt64 {
//                return fileSize
//            }
//        } catch {
//            print("Error: \(error)")
//        }
//        return nil
//    }
//    
  
//    
//    func uploadVideoToVimeo(uploadLink: String, videoFilePath: URL, authToken: String, chunkSize: Int = 5 * 1024 * 1024, completion: @escaping (UploadResult) -> Void) {
//        guard let fileHandle = try? FileHandle(forReadingFrom: videoFilePath) else {
//            completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to read video file"])))
//            return
//        }
//        print("fileHandleBefore",fileHandle)
//        var offset: Int = 0
//        let fileSize = fileHandle.seekToEndOfFile()
//        fileHandle.seek(toFileOffset: 0)
//        
//        print("fileHandleBefore",fileHandle)
//        func uploadNextChunk() {
//            let chunkData = fileHandle.readData(ofLength: chunkSize)
//            
//            if chunkData.isEmpty {
//                fileHandle.closeFile()
//                completion(.success(("")))
//                return
//            }
//            
//            var request = URLRequest(url: URL(string: uploadLink)!)
//            request.httpMethod = "PATCH"
//            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
//            request.setValue("application/offset+octet-stream", forHTTPHeaderField: "Content-Type")
//            request.setValue("\(offset)", forHTTPHeaderField: "Upload-Offset")
//            request.setValue("1.0.0", forHTTPHeaderField: "Tus-Resumable")
//            request.httpBody = chunkData
//            
//            let uploadTask = URLSession.shared.uploadTask(with: request, from: chunkData) { (data, response, error) in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                
//                if let httpResponse = response as? HTTPURLResponse {
//                    if httpResponse.statusCode == 204 {
//                        offset += chunkSize
//                        uploadNextChunk()
//                    } else if httpResponse.statusCode == 412 {
//                        // Handle 412 error (precondition failed), retry or get correct offset from server
//                        if let rangeHeader = httpResponse.value(forHTTPHeaderField: "Upload-Offset"), let serverOffset = Int(rangeHeader) {
//                            offset = serverOffset
//                            uploadNextChunk()
//                        } else {
//                            let error = NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to upload chunk: Precondition Failed"])
//                            completion(.failure(error))
//                        }
//                    } else {
//                        let error = NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to upload chunk, status code: \(httpResponse.statusCode)"])
//                        completion(.failure(error))
//                    }
//                }
//            }
//            
//            uploadTask.resume()
//        }
//        
//        uploadNextChunk()
//    }
//    
//    
    
    
    func CallUploadVideoToVimeoServer() {
        self.showLoading()
        strApiFrom = "VimeoVidoUpload"
        
        //
        let vimeoAccessToken =  appDelegate.VimeoToken
        print("vimeoVideoURL!",vimeoVideoURL)
        print("vimeoAccessToken!",vimeoAccessToken)
        
        createVimeoUploadURL(authToken: vimeoAccessToken, videoFilePath: vimeoVideoURL) { [self] result in
            switch result {
            case .success(let uploadLink):
                uploadVideoToVimeo(uploadLink: uploadLink, videoFilePath: vimeoVideoURL, authToken: vimeoAccessToken) { [self] result in
                    switch result {
                    case .success:
                        print("")
                        
                        
                        
                    case .failure(let error):
                        print("Failed to upload video: \(error)")
                        hideLoading()
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
    
    
    
    enum UploadResult {
        case success(String)
        case failure(Error)
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
        
        
        var TitleGet =  vimeoVideoDict["Title"] as! String
        var TitleDescriotion = vimeoVideoDict["Description"] as! String
        if TitleGet != "" && TitleGet != nil {
            TitleGet =  vimeoVideoDict["Title"] as! String
        }else{
            TitleGet =  "Test Name"
        }
        if TitleDescriotion != "" &&  TitleDescriotion != nil {
            TitleDescriotion = vimeoVideoDict["Description"] as! String
            
        }else{
            TitleDescriotion =  "Test Description"
        }
        
        
        
        guard let fileSize = getFileSize(at: videoFilePath) else {
            completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to get file size"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(authToken)",
            "Content-Type": "application/json",
            "Accept": "application/vnd.vimeo.*+json;version=3.4"
        ]
        let userDefaults = UserDefaults.standard
        let getDownload = UserDefaults.standard.value(forKey: DefaultsKeys.allowVideoDownload) as? Bool ?? false
        let parameters: [String: Any] = [
            "upload": [
                "approach": "tus",
                "size": "\(fileSize)"
            ],
            "privacy":[
                "view":"unlisted",
                "download": true
            ],
            "embed":[
                "buttons":[
                    "share":"false"
                ]
            ],
            "name": TitleGet,
            "description": TitleDescriotion
        ]
        
        AF.request("https://api.vimeo.com/me/videos", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { [self] response in
                switch response.result {
                case .success(let value):
                    print("Vimeo API Response: \(value)")
                    if let json = value as? [String: Any],
                       let upload = json["upload"] as? [String: Any],
                       let uploadLink = upload["upload_link"] as? String {
                        
                        let embedUrl = json["player_embed_url"] as! String
                        let IFrameLink : String!
                        let embed = json["embed"]! as AnyObject
                        IFrameLink = embed["html"]! as! String
                        
                        let LinkGet  = json["link"] as! String
                        vimeoVideoDict["URL"] = LinkGet
                        vimeoVideoDict["Iframe"] = embed["html"]!
                        vimeoVideoDict["videoFileSize"] = DefaultsKeys.videoFilesize
                        
                        print(vimeoVideoDict)
                        hideLoading()
                       VideoUpload()
                        print("videe=embedUrl",IFrameLink)
                        //                        print("IFrameLink",IFrameLink)
                        completion(.success(uploadLink))
                    } else {
                        completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Upload link not found"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func uploadVideoToVimeo(uploadLink: String, videoFilePath: URL, authToken: String, chunkSize: Int = 5 * 1024 * 1024, completion: @escaping (UploadResult) -> Void) {
        guard let fileHandle = try? FileHandle(forReadingFrom: videoFilePath) else {
            completion(.failure(NSError(domain: "com.vimeo", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to read video file"])))
            return
        }
        print("fileHandleBefore",fileHandle)
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
    
    
    
    
    
    func responestring(_ csData: NSMutableArray!, _ pagename: String!) {
        print("strApiFrom12",strApiFrom)
        if(csData != nil)        {
            
            if(strApiFrom.isEqual(to:"SendStaffVoiceMessageApi"))
            {
                UtilObj.printLogKey(printKey: "csdata", printingValue: csData!)
                var dicResponse: NSDictionary = [:]
                if let arrayDatas = csData as? NSArray
                {
                    dicResponse = arrayDatas[0] as! NSDictionary
                    let myalertstring = String(describing: dicResponse["Message"]!)
                    let mystatus = String(describing: dicResponse["Status"]!)
                    
                    if(mystatus == "1")
                    {
                        Util.showAlert("", msg: myalertstring)
                        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                        
                    }
                    else
                    {
                        Util.showAlert("", msg: myalertstring)
                        dismiss(animated: false, completion: nil)
                        
                    }
                    
                }
                else{
                    Util.showAlert("", msg: strSomething)
                }
                
            }
        }
    }
    
    func hideLoading() -> Void{
        hud.hide(true)
        
    }
    func failedresponse(_ pagename: Error!) {
        Util .showAlert("", msg: strSomething);
        print("Errorr")
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("pdfDataType",pdfDataType)
        if pdfDataType == "1" {
           
        }
        
//        else if pdfDataType == "Video" {
//            SendedScreenNameStr = "VimeoVideoToParents"
//            CallUploadVideoToVimeoServer()
//        }
    }
    @IBAction func cancelVC(){
        dismiss(animated: true, completion: nil)
    }
    
    func groupsList() {
        
        
        print("SchoolIdqq",SchoolId)
        print("StaffId",StaffId)
        
        let groupModal = SendStaffGroupsVoiceModal()
        groupModal.SchoolId = SchoolId
        groupModal.StaffId = StaffId
        
        let groupModalStr = groupModal.toJSONString()
        print("groupModalStr",groupModalStr)
        SendStaffGroupsVoiceRequest.call_request(param: groupModalStr!) {
            [self]   (res) in
            
            
            
            
            
            let groupResponse : [SendStaffGroupsVoiceResponse] = Mapper<SendStaffGroupsVoiceResponse>().mapArray(JSONString: res)!
        
//            if groupResponse[0].s
            if groupResponse.count < 0 {
                getGroupList = groupResponse
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }else{
                KRProgressHUD.dismiss()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getGroupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! SendStaffGroupsVoiceTableViewCell
        
        let groupName : SendStaffGroupsVoiceResponse = getGroupList[indexPath.row]
        
        cell.groupNameLbl.text = groupName.GroupName
        
        
        let selectedGesture = CheckBoxGesture(target: self, action: #selector(changeSelection))
        selectedGesture.checkBox = cell.groupCheckBoxView
        selectedGesture.pos = indexPath.row
        cell.groupCheckBoxView.addGestureRecognizer(selectedGesture)
        
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    @IBAction func changeSelection(gesture : CheckBoxGesture ){
        
        
        if getGroupList[gesture.pos].isSelected == true{
            
            //            gesture.checkBox.isSelected = true
            
            getGroupList[gesture.pos].isSelected = false
            gesture.checkBox.setImage(UIImage.init(named: "UnChechBoxImage"), for: .normal)
            
            
        }else{
            
            getGroupList[gesture.pos].isSelected = true
            gesture.checkBox.setImage(UIImage.init(named: "CheckBoximage"), for: .normal)
            
        }
        
        
        
        
        tv.reloadData()
        
    }
    
    
    //    AWS Upload
    func getImageURL(images: [UIImage]) {
    
        self.originalImagesArray = images
        self.totalImageCount = images.count
            if currentImageCount < images.count {
               
                self.uploadAWS(image: images[currentImageCount])
            } else {
                print("All images uploaded. Final URLs: \("")")
                // Handle final uploaded URLs (e.g., send them to the server or update the UI)
            }
    }

    func uploadAWS(image: UIImage) {
        let currentTimeStamp = NSString.init(format: "%ld", Date() as CVarArg)
        let imageNameWithoutExtension = NSString.init(format: "vc_%@", currentTimeStamp)
        let imageName = NSString.init(format: "%@%@", imageNameWithoutExtension, ".png")
        let ext = imageName as String
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)

        if let data = image.jpegData(compressionQuality: 0.9) {
            do {
                try data.write(to: imageURL)
            } catch {
                print("Error writing image data to file: \(error)")
                return
            }
        }
        
        
        let currentDate = AWSPreSignedURL.shared.getCurrentDateString()
        var bucketName = ""
        var bucketPath = ""
        if countryCoded == "4" {
            bucketName = DefaultsKeys.THAI_SCHOOL_CHIMES_COMMUNICATION
            bucketPath = currentDate+"/"+String(SchoolId)
        }
        else
        {
            bucketName = DefaultsKeys.SCHOOL_CHIMES_COMMUNICATION
            bucketPath = currentDate+"/"+String(SchoolId)

        }
                       
        
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: bucketName,
            fileName: imageURL,
            bucketPath: bucketPath,
            fileType: "image/png"
        ) { [self] result in
            switch result {
            case .success(let awsResponse):
                print("Presigned URL fetched: \(awsResponse.data?.presignedUrl ?? "")")
                let presignedURL = awsResponse.data?.presignedUrl
                let Uploadimages = awsResponse.data?.fileUrl
              
                AWSUploadManager.shared.uploadImageToAWS(image: image, presignedURL: presignedURL!) { [self] result in
                    switch result {
                    case .success(let uploadedURL):
                        print("Image uploaded successfully: \(uploadedURL)")
                        
                      
                    case .failure(let error):
                        print("Failed to upload image: \(error.localizedDescription)")
                    }
        
//                    let imageDict = NSMutableDictionary()
//                    imageDict["FileName"] = Uploadimages
//                    imageUrlArray.add(imageDict)
                    self.currentImageCount += 1
                      if self.currentImageCount < self.totalImageCount {
                          
                          DispatchQueue.main.async {
                              self.getImageURL(images: self.originalImagesArray)
                              print("getImageURL",self.getImageURL)
                          }
                       } else {
                           print("All images uploaded. Final URLs: \(imageUrlArray)")
                           // Handle final uploaded URLs (e.g., send them to the server or update the UI
                         
                           
                           imgPdfType = "1"
                           absoluteStringImg = Uploadimages
                           imgPdfUpload()
                           let imageDict = NSMutableDictionary()
                           imageDict["FileName"] = Uploadimages
                           self.imageUrlArray.add(imageDict)
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
           
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
        }
        
   
       
    }
    
    
    

    func uploadPDFFileToAWS(pdfData : NSData){
//        self.showLoading()
        let currentTimeStamp = NSString.init(format: "%ld",Date() as CVarArg)
        let imageNameWithoutExtension = NSString.init(format: "vc_%@",currentTimeStamp)
        let imageName = NSString.init(format: "%@%@",imageNameWithoutExtension, ".pdf")
        let ext = imageName as String
        let fileName = imageNameWithoutExtension
        let fileType = ".pdf"
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(ext)
        do {
            try pdfData.write(to: imageURL)
        }
        catch {}
        print(imageURL)
       
      
        
        
        let currentDate = AWSPreSignedURL.shared.getCurrentDateString()
        var bucketName = ""
        var bucketPath = ""
        if countryCoded == "4" {
            bucketName = DefaultsKeys.THAI_SCHOOL_CHIMES_COMMUNICATION
            bucketPath = currentDate+"/"+String(SchoolId)
        }
        else
        {
            bucketName = DefaultsKeys.SCHOOL_CHIMES_COMMUNICATION
            bucketPath = currentDate+"/"+String(SchoolId)

        }
                       
        
        AWSPreSignedURL.shared.fetchPresignedURL(
            bucket: bucketName,
            fileName: imageURL,
            bucketPath: bucketPath,
            fileType: "application/pdf"
        ) { [self] result in
            switch result {
            case .success(let awsResponse):
                print("Presigned URL fetched: \(awsResponse.data?.presignedUrl ?? "")")
                let presignedURL = awsResponse.data?.presignedUrl
                let UploadPDf = awsResponse.data?.fileUrl
              
                AWSUploadManager.shared.uploadPDFAWSUsingPresignedURL(pdfData: pdfData as Data, presignedURL:presignedURL! ){ [self] result in
                    
                    switch result {
                    case .success(let uploadedURL):
                        print("Image uploaded successfully: \(uploadedURL)")
                      
                    case .failure(let error):
                        print("Failed to upload image: \(error.localizedDescription)")
                    }
        
                   
                    
                    imgPdfType = "2"
                    absoluteStringPdf = UploadPDf
                    imgPdfUpload()
                    let imageDict = NSMutableDictionary()
                    imageDict["FileName"] = UploadPDf
                    self.imageUrlArray.add(imageDict)
                    self.convertedImagesUrlArray = self.imageUrlArray
                          }
           
            case .failure(let error):
                print("Error fetching presigned URL: \(error.localizedDescription)")
            }
        }
        
    }
    

    
    @IBAction func SendAction(_ sender: UIButton) {
        
        
        
        
        if selectType == "Text" {
            
            
            var idNameArr : [String] = []
            
            var idList : String!
            
            for listItem in getGroupList {
                if listItem.isSelected == true{
                    
                    
                    let shortNames = listItem.GroupID.filter { _ in listItem.isSelected == true   }
                    
                    
                    idList = listItem.GroupID
                    
                    
                    
                    idNameArr.append(idList)
                    print("idNameArr",idNameArr)
                }
            }
            
            
            let smsModalGrpCode = StaffGroupsVoiceGrpCode()
            
            for i in idNameArr {
                smsModalGrpCode.TargetCode = i
            }
            
            print("smsModalGrpCode.TargetCode",smsModalGrpCode.TargetCode)
            targetListArr.append(smsModalGrpCode)
            let smsModal = SendSMSAsStaffToGroupsModal()
            //            "10023358"
            smsModal.SchoolID = SchoolId
            smsModal.StaffID = StaffId
            
            smsModal.Description = DescStr
            smsModal.Message = MessageStr
            smsModal.GrpCode = targetListArr
            
            let SmsModalStr = smsModal.toJSONString()
            print("SmsModalStr",SmsModalStr)
            SendSMSAsStaffToGroupsRequest.call_request(param: SmsModalStr!) {
                [self]   (res) in
                
                let SmsResponse : [StaffSmsResponse] = Mapper<StaffSmsResponse>().mapArray(JSONString: res)!
                
                for i in SmsResponse {
                    if i.Status.elementsEqual("1") {
                        
                        
                        _ = SweetAlert().showAlert("Alert", subTitle: i.Message, style: .none, buttonTitle: "OK") { isOtherButton in
                            
                            if isOtherButton {
                                
                                self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                                
                            }
                        }
                    }
                }
                
                
            }
        }else if selectType == "Image" {
            
            
            if imgPdfType == "1" {
                self.getImageURL(images: self.imagesArrayGet as! [UIImage])

            }else{
                self.uploadPDFFileToAWS(pdfData: pdfData!)
                print("uploadPDFFileToAWS",uploadPDFFileToAWS)
            }
            
           
            
        }else if selectType == "Voice" {
            
            print("selectType123",selectType)
            SendedScreenNameStr = "StaffVoiceMessage"
            
            
            
            var idNameArr : [String] = []
            
            var idList : String!
            
            for listItem in getGroupList {
                if listItem.isSelected == true{
                    
                    
                    let shortNames = listItem.GroupID.filter { _ in listItem.isSelected == true   }
                    
                    
                    idList = listItem.GroupID
                    
                    
                    
                    idNameArr.append(idList)
                    print("idNameArr",idNameArr)
                }
            }
            
            let voiceModalGrpCode = StaffVoiceGrpCode()
            for i in idNameArr {
                voiceModalGrpCode.TargetCode = i
                targetIds = i
                print("fromView",fromView)
                if(self.fromView == "Record"){
                    self.SendStaffVoiceMessageApi()
                }else{
                    self.SendStaffHistoryVoiceMessageApi()
                }            }
            
            VoiceTargetListArr.append(voiceModalGrpCode)
            
        }
        else if selectType == "Video" {
            print("Video")
            SendedScreenNameStr = "VimeoVideoToParents"
            CallUploadVideoToVimeoServer()
           
        }
    }
    
    func imgPdfUpload() {
        print("get",self.getImageURL)
        var idNameArr : [String] = []
        
        var idList : String!
        
        for listItem in getGroupList {
            if listItem.isSelected == true{
                
                
                let shortNames = listItem.GroupID.filter { _ in listItem.isSelected == true   }
                
                
                idList = listItem.GroupID
                
                
                
                idNameArr.append(idList)
                print("idNameArr",idNameArr)
            }
        }
        
        let imageModalGrpCode = StaffGroupsImagePdfGrpCode()
        for i in idNameArr {
            imageModalGrpCode.TargetCode = i
        }
        
        
        print("smsModalGrpCode.TargetCode",imageModalGrpCode.TargetCode)
        ImageTargetListArr.append(imageModalGrpCode)
        
        
        let imageModalFilePath = StaffGroupsImagePdfFileNameArray()
        if imgPdfType == "1" {
            imageModalFilePath.FileName = absoluteStringImg
            print("imageModalFilePath.FileName",  imageModalFilePath.FileName)
        }else {
            imageModalFilePath.FileName = absoluteStringPdf
        }
        ImageFileNameArrayArr.append(imageModalFilePath)
        
        
        let imageModal = SendImageStaffModal()
        
        imageModal.SchoolID = SchoolId
        imageModal.StaffID = StaffId
        
        imageModal.Description = imgDesc
        imageModal.Message = MessageStr
        imageModal.GrpCode = ImageTargetListArr
        imageModal.Duration = "0"
        
        print("imgPdfType",imgPdfType)
        if imgPdfType == "1" {
            imageModal.FileType = "IMG"
            imageModal.isMultiple = "1"
        }else{
            imageModal.FileType = ".pdf"
            imageModal.isMultiple = "0"
        }
        imageModal.FileNameArray = ImageFileNameArrayArr
        print("imageModal.FileNameArray", imageModal.FileNameArray)
        let imageModalStr = imageModal.toJSONString()
        print("SmsModalStr",imageModalStr)
        SendImagePdfRequest.call_request(param: imageModalStr!) {
            [self]   (res) in
            
            let imageResponse : [StaffImagePdfResponse] = Mapper<StaffImagePdfResponse>().mapArray(JSONString: res)!
            
            for i in imageResponse {
                if i.Status.elementsEqual("1") {
                    
                    
                    _ = SweetAlert().showAlert("Alert", subTitle: i.Message, style: .none, buttonTitle: "OK") { isOtherButton in
                        
                        if isOtherButton {
                            
                            self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                        }
                    }
                }
                
            }
        }
    }
    
    
    func VideoUpload() {
        
        
        var idNameArr : [String] = []
        
        var idList : String!
        
        for listItem in getGroupList {
            if listItem.isSelected == true{
                
                
                let shortNames = listItem.GroupID.filter { _ in listItem.isSelected == true   }
                
                
                idList = listItem.GroupID
                idNameArr.append(idList)
                print("idNameArr",idNameArr)
            }
        }
        
        let videoModalGrpCode = StaffGroupsVideoGrpCode()
        for i in idNameArr {
            videoModalGrpCode.TargetCode = i
        }
        
        
        VideoTargetListArr.append(videoModalGrpCode)
        
        
        print("MessageStr",MessageStr)
        let videoModal = SendVideoStaffToGroupsModal()
        
        videoModal.SchoolId = SchoolId
        videoModal.Title = videoTitle
        
        videoModal.Description = videoDesc
        videoModal.Iframe = vimeoVideoDictIframe
        videoModal.URL = vimeoVideoDictURL
        videoModal.ProcessBy = videoProcessBy
        videoModal.GrpCode = VideoTargetListArr
        videoModal.videoFileSize = DefaultsKeys.videoFilesize
        let videoModalStr = videoModal.toJSONString()
        print("videoModalStr",videoModalStr)
        SendStaffGroupsVideoRequest.call_request(param: videoModalStr!) {
            [self]   (res) in
            
            let videoResponse : [StaffVideoResponse] = Mapper<StaffVideoResponse>().mapArray(JSONString: res)!
            
            for i in videoResponse {
                if i.result.elementsEqual("1") {
                    
                    
                    _ = SweetAlert().showAlert("Alert", subTitle: i.Message, style: .none, buttonTitle: "OK") { isOtherButton in
                        
                        if isOtherButton {
                            
                            self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                        }
                    }
                }
                
            }
        }
        
        
        
    }
    
    
    func showLoading() -> Void {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.animationType = MBProgressHUDAnimationFade
        hud.labelText = "Loading"
        
    }
    
    func SendStaffVoiceMessageApi(){
        showLoading()
        strApiFrom = "SendStaffVoiceMessageApi"
        let VoiceData = NSData(contentsOf: self.voiceUrlData!)
        let apiCall = API_call.init()
        apiCall.delegate = self;
        let baseUrlString = UserDefaults.standard.object(forKey:BASEURL) as? String
        print("DefaultsKeys.SelectInstantSchedule",DefaultsKeys.SelectInstantSchedule)
        let defaults = UserDefaults.standard
        var initialTime = DefaultsKeys.initialDisplayDate
        var doNotDial =  DefaultsKeys.doNotDialDisplayDate
        print("initialTime",initialTime)
        print("doNotDial",doNotDial)
        
        if DefaultsKeys.SelectInstantSchedule == 0 {
            let requestStringer = baseUrlString! + STAFF_SEND_VOICE_MESSAGE_TO_GROUPS
            print("requestStringerSTAFF_SEND_VOICE_MESSAGE_TO_GROUPS",requestStringer)
            let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            print("requestString",requestString)
            let SectionID = targetIds
            print("SectionID",SectionID)
            let myDict:NSMutableDictionary = ["SchoolID" : SchoolId,"StaffID" : StaffId,"Description" : voiceDesc,"Duration": voiceDurationString ,"GrpCode" : [["TargetCode":SectionID]]]
            print("myDict",myDict)
            UtilObj.printLogKey(printKey: "myDict", printingValue: myDict)
            let myString = Util.convertDictionary(toString: myDict)
            apiCall.callPassVoiceParms(requestString, myString, "VoiceToParents", VoiceData as Data?)
        }else{
            let requestStringer = baseUrlString! + SCHEDULE_STAFF_SEND_VOICE_MESSAGE_TO_GROUPS
            print("requestStringerSCHEDULE_STAFF_SEND_VOICE_MESSAGE_TO_GROUPS",requestStringer)
            
            let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            print("requestString",requestString)
            let SectionID = targetIds
            print("SectionID",SectionID)
            let myDict:NSMutableDictionary = ["SchoolID" : SchoolId,"StaffID" : StaffId,"Description" : voiceDesc,"Duration": voiceDurationString ,"GrpCode" : [["TargetCode":SectionID]], "StartTime" : initialTime , "EndTime" : doNotDial , "Dates" : DefaultsKeys.dateArr ]
            print("myDict",myDict)
            UtilObj.printLogKey(printKey: "myDict", printingValue: myDict)
            let myString = Util.convertDictionary(toString: myDict)
            apiCall.callPassVoiceParms(requestString, myString, "VoiceToParents", VoiceData as Data?)
        }
    }
    
    func SendStaffHistoryVoiceMessageApi(){
        showLoading()
        let voiceDict = voiceHistoryArray[0] as! NSDictionary
        strApiFrom = "SendStaffVoiceMessageApi"
        let apiCall = API_call.init()
        apiCall.delegate = self;
        let VoiceData = NSData(contentsOf: self.voiceUrlData!)
        
        let baseUrlString = UserDefaults.standard.object(forKey:BASEURL) as? String
        print("DefaultsKeys.SelectInstantSchedule",DefaultsKeys.SelectInstantSchedule)
        let defaults = UserDefaults.standard
        var initialTime = DefaultsKeys.initialDisplayDate
        var doNotDial =  DefaultsKeys.doNotDialDisplayDate
        print("initialTime",initialTime)
        print("doNotDial",doNotDial)
        
        if DefaultsKeys.SelectInstantSchedule == 0 {
            let requestStringer = baseUrlString! + STAFF_SEND_VOICE_MESSAGE_TO_GROUPS
            print("requestStringerSTAFF_SEND_VOICE_MESSAGE_TO_GROUPS",requestStringer)
            
            let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            print("requestString",requestString)
            let SectionID = targetIds
            
            let myDict:NSMutableDictionary = ["SchoolID" : SchoolId,"StaffID" : StaffId,"Description" : voiceDesc,"Duration": voiceDurationString,"GrpCode" : [["TargetCode":SectionID]]]
            print("myDict",myDict)
            UtilObj.printLogKey(printKey: "myDict", printingValue: myDict)
            let myString = Util.convertDictionary(toString: myDict)
            apiCall.nsurlConnectionFunction(requestString, myString, "StaffVoiceHistory")
            
        }else{
            let requestStringer = baseUrlString! + SCHEDULE_STAFF_SEND_VOICE_MESSAGE_TO_GROUPS
            print("requestStringerSCHEDULE_STAFF_SEND_VOICE_MESSAGE_TO_GROUPS",requestStringer)
            
            let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            print("requestString",requestString)
            let SectionID = targetIds
            
            let myDict:NSMutableDictionary = ["SchoolID" : SchoolId,"StaffID" : StaffId,"Description" : voiceDesc,"Duration": voiceDurationString,"GrpCode" : [["TargetCode":SectionID]], "StartTime" : initialTime , "EndTime" : doNotDial , "Dates" : DefaultsKeys.dateArr ]
            print("myDict",myDict)
            UtilObj.printLogKey(printKey: "myDict", printingValue: myDict)
            let myString = Util.convertDictionary(toString: myDict)
            apiCall.nsurlConnectionFunction(requestString, myString, "StaffVoiceHistory")
        }
    }
    
}



class CheckBoxGesture : UITapGestureRecognizer{
    
    var pos : Int!
    var checkBox : StaffCheckBox!
    
}
