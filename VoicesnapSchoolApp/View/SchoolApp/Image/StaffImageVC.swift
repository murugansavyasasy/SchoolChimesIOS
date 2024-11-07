//
//  StaffImageVC.swift
//  VoicesnapSchoolApp
//
//  Created by Shenll-Mac-04 on 25/01/18.
//  Copyright © 2018 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ImagePicker
import MobileCoreServices

extension StaffImageVC: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        urlPath = url
        self.setPDFFile()
        self.enableButton()
    }
}

class StaffImageVC: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, ImagePickerDelegate  {
    
    @IBOutlet weak var ToStaffGroupsButton: UIButton!
    @IBOutlet weak var MyImageView: UIImageView!
    @IBOutlet weak var DescriptionTitle: UITextField!
    @IBOutlet weak var SendImageLabel: UILabel!
    @IBOutlet weak var ClickImageCaptureButton: UIButton!
    @IBOutlet weak var ImageView: UIView!
    @IBOutlet weak var StandardSectionButton: UIButton!
    @IBOutlet weak var StandardStudentButton: UIButton!
    @IBOutlet weak var ClickHereButton: UIButton!
    @IBOutlet weak var MyImageView2: UIImageView!
    @IBOutlet weak var MyImageView3: UIImageView!
    @IBOutlet weak var MyImageView4: UIImageView!
    @IBOutlet weak var MoreImagesButton: UIButton!
    @IBOutlet weak var MyPDFImage: UIImageView!
    var SchoolId = String()
    var StaffId = String()
    var pdfData : NSData? = nil
    var pdfType : String!
    var moreImagesArray = NSMutableArray()
    var urlPath : URL!
    var strFrom = String()
    var imageLimit = 0
    var strNoRecordAlert = String()
    var strNoInternet = String()
    var strSomething = String()
    var uploadImageData : NSData? = nil
    let picker = UIImagePickerController()
    var LanguageDict = NSDictionary()
    var strCountryName = String()
    var imagePicker = UIImagePickerController()
    var SchoolDetailDict:NSDictionary = [String:Any]() as NSDictionary
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var LoginSchoolDetailArray = NSArray()
    override func viewDidLoad(){
        super.viewDidLoad()
        self.initialSetup()
        imagePicker.delegate = self
        
        SchoolDetailDict = appDelegate.LoginSchoolDetailArray[0] as! NSDictionary
        SchoolId = String(describing: SchoolDetailDict["SchoolID"]!)
        StaffId = String(describing: SchoolDetailDict["StaffID"]!)
        
        strCountryName = UserDefaults.standard.object(forKey: COUNTRY_Name) as? String ?? ""
        print(strCountryName)
    }
    
    func initialSetup(){
        view.isOpaque = false
        
        StandardSectionButton.layer.cornerRadius = 5
        StandardSectionButton.layer.masksToBounds = true
        StandardStudentButton.layer.cornerRadius = 5
        StandardStudentButton.layer.masksToBounds = true
        
        ToStaffGroupsButton.layer.cornerRadius = 5
        ToStaffGroupsButton.layer.masksToBounds = true
        
        ClickImageCaptureButton.layer.cornerRadius = 5
        ClickImageCaptureButton.layer.masksToBounds = true
        ClickImageCaptureButton.isEnabled = false
        StandardSectionButton.isEnabled = false
        StandardStudentButton.isEnabled = false
        ToStaffGroupsButton.isEnabled = false
        
        
        picker.delegate = self
        
        let nc = NotificationCenter.default
        nc.addObserver(self,selector: #selector(StaffImageVC.catchNotification), name: NSNotification.Name(rawValue: "comeBackMenu"), object:nil)
        
        self.MyImageView.isHidden = false
        //
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.callSelectedLanguage()
        let tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionCaptureImageButton(_:)))
        ImageView.addGestureRecognizer(tapped)
        if(UserDefaults.standard.object(forKey: IMAGE_COUNT) != nil){
            let strImageLimit : NSString = UserDefaults.standard.object(forKey: IMAGE_COUNT) as! NSString
            imageLimit = strImageLimit.integerValue
        }
        if(moreImagesArray.count > 0){
            ClickHereButton.isHidden = true
            ClickImageCaptureButton.isEnabled = true
            ClickImageCaptureButton.backgroundColor = UIColor(red: 230.0/255.0, green: 126.0/255.0, blue: 34.0/255.0, alpha: 1)
            
        }else{
            ClickHereButton.isHidden = false
            ClickImageCaptureButton.isEnabled = false
            ClickImageCaptureButton.backgroundColor = UIColor.lightGray
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: TEXTFIELD DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " " {
            return false
        }
        return true
    }
    
    //MARK: CAPTURE BUTTON ACTION
    @IBAction func actionCaptureImageButton(_ sender: UIButton){
        DescriptionTitle.resignFirstResponder()
        
        
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Pdf", style: .default, handler: { _ in
            self.FromPDF()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertClose(gesture: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: CHANGE BUTTON ACTION
    @IBAction func actionChangeImageButton(_ sender: UIButton) {
        DescriptionTitle.resignFirstResponder()
        
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Pdf", style: .default, handler: { _ in
            self.FromPDF()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
        //
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                               [UIImagePickerController.InfoKey : Any]) {
        ClickImageCaptureButton.isEnabled = true
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        MyImageView.contentMode = .scaleToFill
        MyImageView.image = chosenImage
        print("FilePAthImage",chosenImage)
        self.moreImagesArray.add(chosenImage)
        if(self.MyImageView.image != nil){
            enableButton()
            dismiss(animated: true, completion: nil)
            ClickImageCaptureButton.backgroundColor = UIColor(red: 230.0/255.0, green: 126.0/255.0, blue: 34.0/255.0, alpha: 1)
            
        }    }
    
    func openGallary()
    {
        strFrom = "Image"
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    func CloseAlertView(gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera",message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(title: LanguageDict["teacher_btn_ok"] as? String,style:.default,handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int){
        switch (buttonIndex){
        case 0:
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
                dismiss(animated: true, completion: nil)
            }
        case 1:
            shootFromLibrary(sender: integer_t(buttonIndex))
        case 2:
            self.FromPDF()
        default: break
        }
    }
    
    func FromLibrary(){
        self.strFrom = "Image"
        
        self.ImagePickerGallery()
    }
    
    func FromPhoto(){
        self.strFrom = "Image"
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        }else{
            noCamera()
        }
    }
    
    func FromPDF(){
        self.strFrom = "PDF"
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func shootFromLibrary(sender: integer_t){
        self.strFrom = "Image"
        
        self.ImagePickerGallery()
    }
    
    func shootFromPhoto(sender: integer_t){
        self.strFrom = "Image"
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        }else{
            noCamera()
        }
    }
    
    func enableButton(){
        
        StandardSectionButton.isEnabled = true
        StandardSectionButton.backgroundColor = UIColor(red: 230.0/255.0, green: 126.0/255.0, blue: 34.0/255.0, alpha: 1)
        StandardStudentButton.isEnabled = true
        StandardStudentButton.backgroundColor = UIColor(red: 230.0/255.0, green: 126.0/255.0, blue: 34.0/255.0, alpha: 1)
        ToStaffGroupsButton.isEnabled = true
        ToStaffGroupsButton.backgroundColor = UIColor(red: 230.0/255.0, green: 126.0/255.0, blue: 34.0/255.0, alpha: 1)
        ClickImageCaptureButton.backgroundColor = UIColor(red: 230.0/255.0, green: 126.0/255.0, blue: 34.0/255.0, alpha: 1)
        ClickHereButton.isHidden = true
        ClickImageCaptureButton.isEnabled = true
        
    }
    
    
    
    
    //MARK: NEXT BUTTON ACTION
    
    
    
    
    
    @IBAction func actionStaffGroups(_ sender: UIButton) {
        
        
        
        
        let vc =  StaffGroupVoiceViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.selectType = "Image"
        vc.imgDesc = DescriptionTitle.text!
        vc.SchoolId = SchoolId
        vc.StaffId = StaffId
        vc.pdfData = self.pdfData
        vc.pdfDataType = pdfType
        
        print("SchoolId1",SchoolId)
        vc.imagesArrayGet = moreImagesArray 
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func actionStandardOrSectionButton(_ sender: UIButton) {
        DescriptionTitle.resignFirstResponder()
        let StaffVC = self.storyboard?.instantiateViewController(withIdentifier: "StandardOrSectionVCStaff") as! StandardOrSectionVCStaff
        StaffVC.SendedScreenNameStr = "StaffMultipleImage"
        StaffVC.HomeTitleText = DescriptionTitle.text!
        StaffVC.uploadImageData = uploadImageData
        StaffVC.imagesArray = moreImagesArray
        StaffVC.strFrom = strFrom
        StaffVC.pdfData = self.pdfData
        self.present(StaffVC, animated: false, completion: nil)
    }
    
    @IBAction func actionStandardOrStudentButton(_ sender: UIButton) {
        DescriptionTitle.resignFirstResponder()
        DescriptionTitle.resignFirstResponder()
        let StaffStudent = self.storyboard?.instantiateViewController(withIdentifier: "StandardOrStudentsStaff") as! StandardOrStudentsStaff
        StaffStudent.SenderScreenName = "StaffMultipleImage"
        StaffStudent.HomeTitleText = DescriptionTitle.text!
        StaffStudent.uploadImageData = uploadImageData
        StaffStudent.imagesArray = moreImagesArray
        StaffStudent.strFrom = strFrom
        StaffStudent.pdfData = self.pdfData
        self.present(StaffStudent, animated: false, completion: nil)
    }
    
    @IBAction func actionCloseView(_ sender: UIButton) {
        DescriptionTitle.resignFirstResponder()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func actionMoreImages(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "moreImagesSegue", sender: self)
        }
    }
    
    @objc func catchNotification(notification:Notification) -> Void{
        dismiss(animated: false, completion: nil)
        let nc = NotificationCenter.default
        nc.addObserver(self,selector: #selector(ExamTestVC.catchNotification), name: NSNotification.Name(rawValue: "comeBackMenu"), object:nil)
    }
    
    func ImagePickerGallery() {
        let config = ImagePickerConfiguration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        config.allowVideoSelection = false
        
        let imagePicker = ImagePickerController(configuration: config)
        imagePicker.delegate = self
        imagePicker.imageLimit = imageLimit
        present(imagePicker, animated: true, completion: {
            imagePicker.navigationController?.navigationBar.topItem?.title = ""
            imagePicker.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black
        })
    }
    
    // MARK: - ImagePickerDelegate
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        for image in images{
            self.moreImagesArray.add(image)
            print("FilePAthImage",image)
        }
        
        if(moreImagesArray.count > 0){
            self.enableButton()
        }else{
            ClickHereButton.isHidden = false
            ClickImageCaptureButton.isEnabled = false
            ClickImageCaptureButton.backgroundColor = UIColor.lightGray
        }
        self.SetImagesFromPicker(imageCount: (images.count as NSNumber))
        self.SetImagesIntoPath(images: images)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func SetImagesIntoPath(images : [UIImage]){
        if(images.count == 1){
            self.MyImageView.image = images[0]
        }else if(images.count == 2){
            self.MyImageView.image = images[0]
            self.MyImageView2.image = images[1]
        }else if(images.count == 3){
            self.MyImageView.image = images[0]
            self.MyImageView2.image = images[1]
            self.MyImageView3.image = images[2]
        }else if(images.count >= 4){
            self.MyImageView.image = images[0]
            self.MyImageView2.image = images[1]
            self.MyImageView3.image = images[2]
            self.MyImageView4.image = images[3]
        }
    }
    
    func SetImagesFromPicker(imageCount : NSNumber){
        if(imageCount.intValue >= 4){
            self.MyImageView.isHidden = false
            self.MyImageView2.isHidden = false
            self.MyImageView3.isHidden = false
            self.MyImageView4.isHidden = false
            if(imageCount.intValue > 4){
                let moreImagesCount = imageCount.intValue - 3
            }else{
            }
        }else if(imageCount.intValue == 3){
            self.MyImageView.isHidden = false
            self.MyImageView2.isHidden = false
            self.MyImageView3.isHidden = false
            self.MyImageView4.isHidden = true
        }else if(imageCount.intValue == 2){
            self.MyImageView.isHidden = false
            self.MyImageView2.isHidden = false
            self.MyImageView3.isHidden = true
            self.MyImageView4.isHidden = true
        }else if(imageCount.intValue == 1){
            self.MyImageView.isHidden = false
            self.MyImageView2.isHidden = true
            self.MyImageView3.isHidden = true
            self.MyImageView4.isHidden = true
        }else{
            self.MyImageView.isHidden = true
            self.MyImageView2.isHidden = true
            self.MyImageView3.isHidden = true
            self.MyImageView4.isHidden = true
        }
        
    }
    //MARK: Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "moreImagesSegue"){
            let moreImagesVC = segue.destination as! MoreImagesVC
            moreImagesVC.moreImagesArray = moreImagesArray
        }
    }
    
    func setPDFFile(){
        do {
            pdfType = "1"
            pdfData = try NSData(contentsOf: urlPath!, options: NSData.ReadingOptions())
        } catch {
            print("set PDF filer error : ", error)
        }
        
        if(pdfData != nil){
            self.MyPDFImage.image = UIImage(named: "pdfImage")
            self.MyPDFImage.isHidden = false
            self.MyImageView.isHidden = true
            
        }
    }
    
    // MARK: Language Selection
    
    func callSelectedLanguage(){
        let strLanguage = UserDefaults.standard.object(forKey: SELECTED_LANGUAGE) as! String
        let bundle = Bundle(for: type(of: self))
        if let theURL = bundle.url(forResource: strLanguage, withExtension: "json") {
            do {
                let data = try Data(contentsOf: theURL)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as AnyObject {
                    self.loadLanguageData(LangDict: parsedData as! NSDictionary, Language: strLanguage)
                }
            } catch {
            }
        }
    }
    
    func loadLanguageData(LangDict : NSDictionary, Language : String){
        LanguageDict = LangDict
        if(Language == "ar"){
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
            self.view.semanticContentAttribute = .forceRightToLeft
            DescriptionTitle.textAlignment = .right
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
            self.view.semanticContentAttribute = .forceLeftToRight
            DescriptionTitle.textAlignment = .left
        }
        SendImageLabel.text = LangDict["teacher_txt_composeImg"] as? String
        DescriptionTitle.placeholder = LangDict["teacher_image_hint_title"] as? String ?? "Type content here"
        
        if (strCountryName.uppercased() == SELECT_COUNTRY){
            StandardSectionButton.setTitle(LangDict["teacher_staff_to_sections_usa"] as? String, for: .normal)
            StandardStudentButton.setTitle(LangDict["teacher_staff_to_students"] as? String, for: .normal)
        }
        else{
            StandardSectionButton.setTitle(LangDict["teacher_staff_to_sections"] as? String, for: .normal)
            StandardStudentButton.setTitle(LangDict["teacher_staff_to_students"] as? String, for: .normal)
        }
        ClickHereButton.setTitle(LangDict["image_pdf_title_click"] as? String, for: .normal)
        ClickImageCaptureButton.setTitle(LangDict["teacher_txt_change_selection"] as? String, for: .normal)
        strNoRecordAlert = LangDict["no_records"] as? String ?? "No Record Found"
        strNoInternet = LangDict["check_internet"] as? String ?? "Check your Internet connectivity"
        strSomething = LangDict["catch_message"] as? String ?? "Something went wrong.Try Again"
    }
    
}

