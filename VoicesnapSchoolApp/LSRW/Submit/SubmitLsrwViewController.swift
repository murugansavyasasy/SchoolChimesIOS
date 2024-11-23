//
//  SubmitLsrwViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/20/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import DropDown
import PhotosUI
import Alamofire
import AVFoundation

class SubmitLsrwViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate, PHPickerViewControllerDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate,UITextViewDelegate {
    
    
    
    
    
    @IBOutlet weak var playVoiceHeight: NSLayoutConstraint!
    @IBOutlet weak var voiceOverAllHeight: NSLayoutConstraint!
    @IBOutlet weak var addAttachTop: NSLayoutConstraint!
    @IBOutlet weak var timeCountingLbl: UILabel!
    @IBOutlet weak var PlayVocieButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var overallTimeLbl: UILabel!
    @IBOutlet weak var uploadFileImg: UIImageView!
    @IBOutlet weak var uploadFileLbl: UILabel!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var voicePlayView: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var imgPdfPathShowView: UIView!
    @IBOutlet weak var overAllTextView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var voiceeTapView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var recordlbl: UILabel!
    @IBOutlet weak var voiceOverAllVie: UIView!
    @IBOutlet weak var contentTextViw: UITextView!
    @IBOutlet weak var voiceRecordBtn: UIButton!
    @IBOutlet weak var changeImgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgPathLbl: UILabel!
    @IBOutlet weak var imageOverAllView: UIView!
    @IBOutlet weak var dropDownView: UIViewX!
    @IBOutlet weak var dropDownTextLbl: UILabel!
    
    var items = ["Text", "Voice", "Image","Pdf","Video"]
    var rowId = "FileAttachmentTableViewCell"
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
    var time : Float64 = 0;
    var settings         = [String : Int]()
    var imageStr : [String] = []
    var totalImageCount = 0
    var onImagesPicked: (([UIImage]) -> Void)?
    var aswImg : [String] = []
    var onPdfPicked: ((Data) -> Void)?
    var onImagePicked: (([UIImage]) -> Void)?
    var pathArr : [String] = []
    var overAllPathArr : [String] = []
    var overAllFileArr : [String] = []
    var typeArr : [String] = []
    var fileArr : [String] = []
    var timer = Timer()
    var urlData: URL?
    var TotaldurationFormat = String()
    var MaxMinutes = Int()
    var MaxSeconds = Int()
    var durationString = String()
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var meterTimer:Timer!
    var audioRecorder    : AVAudioRecorder!
    var strPlayStatus : NSString = ""
    var dropDown  = DropDown()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextViw.delegate = self
        addBtn.backgroundColor = .lightGray
        voiceOverAllVie.isHidden = true
        imgPdfPathShowView.isHidden = true
        imageOverAllView.isHidden = true
        dropDownView.isHidden = false
        overAllTextView.isHidden = false
        contentTextViw.isHidden = false
        timerLbl.text = "00:00"
        addBtn.setTitle("Add Content", for: .normal)
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        tv.register(UINib(nibName: rowId, bundle: nil), forCellReuseIdentifier: rowId)
        
        let selectMonth = UITapGestureRecognizer(target: self, action: #selector(selectMonthViewClick))
        dropDownView.addGestureRecognizer(selectMonth)
        
        pdfData?.removeAll()
        pathArr.removeAll()
        fileArr.removeAll()
        overAllPathArr.removeAll()
        addAttachTop.constant = -100
        
        let imgGesture = UITapGestureRecognizer(target: self, action: #selector(selectImages))
        changeImgView.addGestureRecognizer(imgGesture)
        
        let submitGesture = UITapGestureRecognizer(target: self, action: #selector(submitAct))
        submitView.addGestureRecognizer(submitGesture)
        
        
        
    }

    @IBAction func backVc() {
        dismiss(animated: true)
    }
    

    
    
    @IBAction func selectMonthViewClick(){
        
        
        let myArray = items
        
        dropDown.dataSource = myArray//4
        dropDown.anchorView = dropDownView //5
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show() //7
        
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
          
            
            dropDownTextLbl.text = item
            
           
            
            if item == "Text" {
                addBtn.backgroundColor = .lightGray
                overAllTextView.isHidden = false
                contentTextViw.isHidden = false
                voiceOverAllVie.isHidden = true
                imgPdfPathShowView.isHidden = true
                imageOverAllView.isHidden = true
                addAttachTop.constant = -100
                addBtn.setTitle("Add Content", for: .normal)

            } else if item == "Image" {
                addBtn.backgroundColor = .lightGray

                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = true
                imgPdfPathShowView.isHidden = true
                uploadFileLbl.text = "Upload Image"
                imageOverAllView.isHidden = false
                addBtn.setTitle("Add File Attachments", for: .normal)
                addAttachTop.constant = -150
                uploadFileImg.image = UIImage(named: "ImageIcon")
                changeImgView.isHidden = false
                
                
            } else if item == "Pdf" {
                addBtn.backgroundColor = .lightGray

                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = true
                uploadFileLbl.text = "Browse File"
                imgPdfPathShowView.isHidden = true
                imageOverAllView.isHidden = false
                addAttachTop.constant = -180
                addBtn.setTitle("Add File Attachments", for: .normal)
                uploadFileImg.image = UIImage(named: "pdfImage")
                changeImgView.isHidden = false

                
            } else if item == "Voice" {
                addBtn.backgroundColor = .lightGray

                playVoiceHeight.constant = 0
                voiceOverAllHeight.constant = 100
                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = false
                imgPdfPathShowView.isHidden = true
                imageOverAllView.isHidden = true
                addAttachTop.constant = -80
                voicePlayView.isHidden = true
                addBtn.setTitle("Add File Attachments", for: .normal)
                
            } else if item == "Video" {
                addBtn.backgroundColor = .lightGray

                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = true
                imgPdfPathShowView.isHidden = true
//                imageOverAllView.isHidden = true
                uploadFileLbl.text = "Upload Video"
                addAttachTop.constant = -150
                addBtn.setTitle("Add File Attachments", for: .normal)
                uploadFileImg.image = UIImage(named: "p23")
                changeImgView.isHidden = false
                imageOverAllView.isHidden = false

                
                
            }
            
           
        }
        
        
    }

    @IBAction func addFileAttachmentBtnAction(_ sender: UIButton) {
        if addBtn.backgroundColor != .lightGray {
            
            
            
            if dropDownTextLbl.text == "Text" {
                pathArr.append(contentTextViw.text)
                print("pathArrpathArr",pathArr.count)
                contentTextViw.text = ""
                fileArr.append("")
                typeArr.append("TEXT")
                overAllPathArr.append(contentsOf: pathArr)
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }else  if dropDownTextLbl.text == "Image" {
                //            pathArr.removeAll()
                pathArr.append(contentsOf: aswImg)
                overAllPathArr.append(contentsOf: pathArr)
                
                for i in pathArr {
                    typeArr.append("IMAGE")
                }
                
                
                
                
                fileArr.append("ImageIcon")
                overAllFileArr.append(contentsOf: typeArr)
                aswImg.removeAll()
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }else  if dropDownTextLbl.text == "Pdf" {
                
                
                pathArr.append(contentsOf: aswImg)
                overAllPathArr.append(contentsOf: pathArr)
                
                fileArr.append("ImageIcon")
                typeArr.append("PDF")
                aswImg.removeAll()
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }else  if dropDownTextLbl.text == "Voice" {
                pathArr.append(contentTextViw.text)
            }else  if dropDownTextLbl.text == "Video" {
             
                
                pathArr.append(contentsOf: aswImg)
                overAllPathArr.append(contentsOf: pathArr)
                
                fileArr.append("p23")
                typeArr.append("VIDEO")
                aswImg.removeAll()
                tv.delegate = self
                tv.dataSource = self
                tv.reloadData()
                
            }
            
        }else{
            print("Backgroud light")
        }
       

    }
    
    
    
    
    @IBAction func voiceRecordBtnAction(_ sender: UIButton) {
        
        self.playerDidFinishPlaying()
        
        
        
        
        
        
        
        
        
//        pathImg.isHidden = true
//        pathLbl.isHidden = true
//        disableButtonAction()
        if audioRecorder == nil {
//            self.disableButtonAction()
//            self.TitleForStopRecord()
            self.voiceRecordBtn.setBackgroundImage(UIImage(named:"VoiceRecordSelect"), for: UIControl.State.normal)
        
            self.startRecording()
            self.meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(_:)), userInfo:nil, repeats:true)
        }else{
            self.funcStopRecording()
        }
        
    }
    
    func directoryURL() -> NSURL? {
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.appendingPathComponent("sample.mp4")
        
        return soundURL as NSURL?
    }
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do{
            audioRecorder = try AVAudioRecorder(url: self.directoryURL()! as URL, settings: settings)
            urlData = audioRecorder.url
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            
        }catch{
            finishRecording(success: false)
        }
        do{
            try audioSession.setActive(true)
            audioRecorder.record()
        }catch{
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        if success {
            audioRecorder = nil
           
        } else {
            audioRecorder = nil
        }
    }
    
    
    
    
    func funcStopRecording(){
//        self.TitleForStartRecord()
        self.voiceRecordBtn.setBackgroundImage(UIImage(named:"VocieRecord"), for: UIControl.State.normal)
        self.finishRecording(success: true)
//        playVoiceMessageView.isHidden = false
        calucalteDuration()
        if(UIDevice.current.userInterfaceIdiom == .pad){
            
//            PlayVoiceMsgViewHeight.constant = 180
            
            self.overallTimeLbl.text = TotaldurationFormat
            self.timeCountingLbl.text = "00.00"
        }else{
//            PlayVoiceMsgViewHeight.constant = 120
            
            self.overallTimeLbl.text = TotaldurationFormat
            self.timeCountingLbl.text = "00.00"
        }
        
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    @objc func updateSlider(){
        if self.player!.currentItem?.status == .readyToPlay{
            time = CMTimeGetSeconds(self.player!.currentTime())
        }
        
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        slider.maximumValue = Float(seconds)
        slider.minimumValue = 0.0
        
        slider.value = Float(time)
        
        if(time > 0){
            let minutes = Int(time) / 60 % 60
            let secondss = Int(time) % 60
            MaxSeconds = secondss
            let durationFormat = String(format:"%02i:%02i", minutes, secondss)
            timeCountingLbl.text = durationFormat
            
        }
        
        if(time == seconds){
            
            timer.invalidate()
            PlayVocieButton.isSelected = false
            slider.value = 0.0
        }
    }
    
    func actionPlayButton(){
        
        playerItem = AVPlayerItem(url: urlData!)
        player = AVPlayer(playerItem: playerItem!)
        
        if(strPlayStatus.isEqual(to: "close")){
            slider.value = 0.0
        }
        
        if(PlayVocieButton.isSelected){
            
            PlayVocieButton.isSelected = false
            let seconds1 : Int64 = Int64(slider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            
            player!.seek(to: targetTime)
            strPlayStatus = "play"
            player?.pause()
        }else{
            PlayVocieButton.isSelected = true
            let seconds1 : Int64 = Int64(slider.value)
            let targetTime : CMTime = CMTimeMake(value: seconds1, timescale: 1)
            player!.seek(to: targetTime)
            
            strPlayStatus = "play"
            player?.volume = 1
            player?.play()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func updateAudioMeter(_ timer:Timer) {
        if let audioRecorder1 = self.audioRecorder {
            if audioRecorder1.isRecording {
                let min = Int(audioRecorder1.currentTime / 60)
                let sec = Int(audioRecorder1.currentTime.truncatingRemainder(dividingBy: 60))
                let s = String(format: "%02d:%02d", min, sec)
                let SecString = sec
                timerLbl.text = s
                audioRecorder1.updateMeters()
//                if(HomeWorkSecondStr < 60){
//                    if(sec == ApiHomeWorkSecondInt){
//                        self.funcStopRecording()
//                    }
//                }else{
//                    if(min == ApiHomeWorkSecondInt){
//                        self.funcStopRecording()
//                    }
//                }
            }
        }
    }
    
    func playbackSliderValueChanged(playbackSlider:UISlider){
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime : CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        if(player != nil){
            player!.seek(to: targetTime)
        }else{
            
            slider.value = playbackSlider.value
        }
        
    }
    
    func calucalteDuration() -> Void{
        playerItem = AVPlayerItem(url: urlData!)
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        
        slider.maximumValue = Float(seconds)
        //let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        let secondss = Int(seconds) % 60
        durationString = String(format:"%i",Int(seconds))
        
        TotaldurationFormat = String(format:"/ %02i:%02i", minutes, secondss)
        overallTimeLbl.text = TotaldurationFormat
        
    }
    
    // MARK: Player close
    func playerDidFinishPlaying() {
        
        if(player != nil){
            timer.invalidate()
            player?.pause()
            
            slider.value = 0.0
            player?.rate = 0.0
            timerLbl.text = "00.00"
            
            PlayVocieButton.isSelected = false
            strPlayStatus = "close"
            player = nil
            player =  AVPlayer.init()
            
            playerItem?.seek(to: CMTime.zero, completionHandler: nil)
                 time = CMTimeGetSeconds(self.player!.currentTime())
        }
    }
    
    //MARK:Play Audio BUTTON ACTION
    @IBAction func actionPlayVoiceMessage(_ sender: UIButton){
        calucalteDuration()
        
        actionPlayButton()
        audioRecorder = nil
    }
    
    @IBAction func actionSliderButton(_ sender: UISlider) {
        playbackSliderValueChanged(playbackSlider: slider)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("pathArrcount",pathArr.count)
        return pathArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowId, for: indexPath) as! FileAttachmentTableViewCell
        
        cell.contentFilePathLbl.text = pathArr[indexPath.row]
        
//     img   cell.contentFilePathLbl.text = fileArr[indexPath.row]
        cell.selectionStyle = .none
//        for i in typeArr {
//            
//            print("getTypeArr",typeArr)
//            if i == "IMAGE" {
//                
//                cell.img.image = UIImage(named: "ImageIcon")
//            }else if  i == "TEXT" {
//                
//                cell.img.image = UIImage(named: "TextIcon")
//            }else if  i == "VIDEO" {
//                
//                cell.img.image = UIImage(named: "p23")
//            }else if i == "PDF" {
//                
//                cell.img.image = UIImage(named: "pdfImage")
//            }else if  i == "VOICE" {
//                
//                cell.img.image = UIImage(named: "TextIcon")
//            }
//        }
        
        let currentType = typeArr[indexPath.row]
                
                // Update the cell's image based on type
                switch currentType {
                case "IMAGE":
                    cell.img.image = UIImage(named: "ImageIcon")
                case "TEXT":
                    cell.img.image = UIImage(named: "TextIcon")
                case "VIDEO":
                    cell.img.image = UIImage(named: "p23")
                case "PDF":
                    cell.img.image = UIImage(named: "pdfImage")
                case "VOICE":
                    cell.img.image = UIImage(named: "TextIcon")
                default:
                    cell.img.image = nil // Fallback image or nil
                }
        
        cell.indexPath = indexPath
               
               // Set the delete action closure
               cell.deleteAction = { [weak self] indexPath in
                   self?.deleteSelectdItem(at: indexPath)
               }
               
        
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(selectMonthViewClick))
        dropDownView.addGestureRecognizer(closeGesture)
        
        
        
        
        return  cell
        
        
    }
    
    
    func deleteSelectdItem(at indexPath: IndexPath) {
        print("indexPath",indexPath.row)
        guard indexPath.row < pathArr.count else { return }
           
           // Remove the time slot at the given row
           pathArr.remove(at: indexPath.row)
           
           // Perform batch updates to delete the row from the table view
           tv.performBatchUpdates({
               tv.deleteRows(at: [indexPath], with: .automatic)
           }, completion: nil)
        }
//
       
    
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
    
    
    func textViewDidChange(_ textView: UITextView) {
          print("Text changed to: \(textView.text ?? "")")
        if textView.text.count > 0 {
                // Change the button color to blue when text exists
                addBtn.backgroundColor = .blue
            } else {
                // Change the button color to gray when no text exists
                addBtn.backgroundColor = .lightGray
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
            
            
            if pdfData!.count > 0 {
                    // Change the button color to blue when text exists
                self.addBtn.backgroundColor = .blue
                } else {
                    // Change the button color to gray when no text exists
                    self.addBtn.backgroundColor = .lightGray
                }
            uploadPDFFileToAWS(pdfData: pdfData!)
            
        } catch {
            print("set PDF filer error : ", error)
            
        }
        
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectImages() {
        
        
        if dropDownTextLbl.text == "Image" {
            var config = PHPickerConfiguration()
            config.selectionLimit = 5  // Limit selection to 5 images
            config.filter = .images    // Only allow images
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }else if dropDownTextLbl.text == "Pdf"{
            selectPDF()
        }else if dropDownTextLbl.text == "Video"{
            pickVideoFromGallery()
        }
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
                    aswImg.removeAll()
                    aswImg.append(absoluteString)
                    addBtn.backgroundColor = .blue
                    
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
                        
                        if images.count > 0 {
                                // Change the button color to blue when text exists
                            self!.addBtn.backgroundColor = .blue
                            } else {
                                // Change the button color to gray when no text exists
                                self!.addBtn.backgroundColor = .lightGray
                            }
                        self!.uploadAWS(image:image)
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
    
        aswImg.removeAll()
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
                    addBtn.backgroundColor = .blue
                  
                    aswImg.append(absoluteString)
                    
                    print("aswImg",aswImg.count)
                  
                    
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
                    print("videoEmbdUrl",videoEmbdUrl)
                    aswImg.append(videoEmbdUrl)
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
                   
                    addBtn.backgroundColor = .blue
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


  
    

    
    
  
  
    
   
    
   
    func Awws3Voice(URLPath : URL) {
        
        
        
        let audioUrl = URL(fileURLWithPath: URLPath.path)
        
        AWSS3Manager.shared.uploadAudio(audioUrl: audioUrl, progress: { [weak self] (progress) in
            
            
            
            
            
            
            
            print("audioUrl!",audioUrl)
            
            guard let strongSelf = self else { return }
            
            
            
        }) { [weak self] (uploadedFileUrl, error) in
            
            
            guard let strongSelf = self else { return }
            
            if let finalPath = uploadedFileUrl as? String {
                
                self!.urlData = URL(string: finalPath)
                print("finalPath123!",finalPath)
                
                
            } else {
                
                print("\(String(describing: error?.localizedDescription))")
                
            }
            
        }
        
        
    }
//    func directoryURL() -> NSURL? {
//        print("urlData12",urlData)
//        let fileManager = FileManager.default
//        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentDirectory = urls[0] as NSURL
//        let soundURL = documentDirectory.appendingPathComponent("sample.mp4")
////        UtilObj.printLogKey(printKey: "Recorded Audio", printingValue: soundURL!)
//        
//        
//        
//        return soundURL as NSURL?
//    }
    
    @IBAction func takeReadingSkill() {
        let vc = LSRWTakingSkillViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:   true)
    }

    
    
    
    
  
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    
    @IBAction func AttachmentRedirect(ges : LsrwListShowGesture) {
        
        
        let vc = LSRWTakingSkillViewController(nibName: nil, bundle: nil)
        vc.skillId = ges.getSkillId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    
    @IBAction func submitAct() {
        
        
        var imageAryy : [AttachmentData] = []
        
        
        let attachModal = AttachmentData()
       
        
//        for (type, content) in zip(typeArr, pathArr) {
//            print("Number: \(type), Letter: \(content)")
//            attachModal.type = type
//            attachModal.content = content
//            imageAryy.append(attachModal)
//        }
      
        
        for path in pathArr {
            attachModal.content = path
            print("pathArr",path)
//
        }
        
        for path in typeArr {
            attachModal.type = path
            print("typeArr",path)
//
        }
        
        
        
        var attachments: [AttachmentData] = []

        // Ensure pathArr and typeArr are of the same length
        guard pathArr.count == typeArr.count else {
            print("Error: pathArr and typeArr must have the same number of elements")
            return
        }
        
        
        for (index, path) in pathArr.enumerated() {
            let attachModal = AttachmentData()
            attachModal.content = path
            attachModal.type = typeArr[index]
            attachments.append(attachModal)
        }

        for attachment in attachments {
            print("Content: \(attachment.content ?? ""), Type: \(attachment.type ?? "")")
        }
        print("attacattachmentsl",attachments)
        
        let submitModal = SubmitResponseForSkillModal()
        submitModal.StudentID = "10391374"
        submitModal.SkillId = "7050"
        submitModal.attachment = attachments
        
        
        var  submitModalStr = submitModal.toJSONString()
        print("submitModalStr",submitModalStr)
      
        
        ViewAllSkillByStudentRequest.call_request(param: submitModalStr!) {
            
            [self] (res) in
            
//            let submitModalResp : ViewAllSkillByStudentResponse = Mapper<ViewAllSkillByStudentResponse>().map(JSONString: res)!
//            
//            if submitModalResp.Status == 1 {
//                viewSkillDatas = submitModalResp.viewAllSkillByData
//                tv.dataSource = self
//                tv.delegate = self
//                tv.reloadData()
                
//            }
            
            
        }
        
    }
    
}


struct  FileAttach {
    
    
    let pathLbl: String!
    let img: String!
    
}
   
