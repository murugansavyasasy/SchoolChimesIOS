//
//  ParentImageVc.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 26/12/22.
//  Copyright © 2022 Shenll-Mac-04. All rights reserved.
//

import UIKit
import  ObjectMapper



class ParentImageVc: UIViewController,UITableViewDataSource,Apidelegate,UITableViewDelegate,UISearchBarDelegate  {

    
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    @IBOutlet weak var AdView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var TextDateLabel: UILabel!
    
    @IBOutlet weak var TextDetailstableview: UITableView!
    
    @IBOutlet weak var search_bar: UISearchBar!
    
    var MainDetailTextArray: NSMutableArray = NSMutableArray()
    var SelectedSectionArray : NSMutableArray = NSMutableArray()
    
    var imgaeURl : String  = ""
    var AdName : String  = ""
    var imageCount : Int  = 0
    var firstImage : Int  = 0
    weak var timer: Timer?
    var ArrayData = NSMutableArray()

  
    var getadID : Int!
    var typesArray: NSMutableArray = []
    var strApiFrom = NSString()
    var ChildId = String()
    var SchoolId = String()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let utilObj = UtilClass()
    var selectedDictionary = NSDictionary()
    var strSelectDate = NSString ()
    var SenderType = NSString ()
    var Screenheight = CFloat()
    
    var ImageSelectedDict = [String: Any]() as NSDictionary

    var getArchive : String!
    var detailsDictionaryfull = NSDictionary()
    var languageDict = NSDictionary()
      var strCountryCode = String()
    var strNoRecordAlert = String()
    var strNoInternet = String()
    var strSomething = String()
    var hud : MBProgressHUD = MBProgressHUD()
    var altSting = String()
    var bIsSeeMore = Bool()
    var bIsArchive = Bool()
    
    var menuId : String!

    var popupLoading : KLCPopup = KLCPopup()
    var getMsgFromMgnt : Int! = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        TextDetailstableview.dataSource = self
        TextDetailstableview.delegate = self
        
        TextDateLabel.text = commonStringNames.Images.translated()
        search_bar.delegate = self
        search_bar.placeholder = commonStringNames.Search.translated()
        self.view.backgroundColor = UIColor(named: "serach_color")
        bIsSeeMore = false
        if(appDelegate.isPasswordBind == "0"){
            bIsSeeMore = true
        }
        
        print("ImageCellVc")
        
        

        print("getMsgFromMgnt",getMsgFromMgnt)
        if getMsgFromMgnt == 1 {
            let defaults = UserDefaults.standard
            print("SchoolId",SchoolId)
            bIsSeeMore = true
//

        }else{
            let defaults = UserDefaults.standard
            print("SchoolId",SchoolId)
            
//            SchoolId = defaults.string(forKey:DefaultsKeys.SchoolD)!
//            ChildId = defaults.string(forKey:DefaultsKeys.chilId)!
            
            ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
            SchoolId = String(describing: appDelegate.SchoolDetailDictionary["SchoolID"]!)

            
            async {
                do {
    
                    menuId = AdConstant.getMenuId as String
                    print("menu_id:\(AdConstant.getMenuId)")
                    
                    
                    
                    let AdModal = AdvertismentModal()
                    AdModal.MemberId = ChildId
                    AdModal.MemberType = "student"
                    if AdConstant.mgmtVoiceType == "1" {
                        AdModal.MenuId = "0"
                    }
                    AdModal.MenuId = menuId
                    AdModal.SchoolId = SchoolId
                    
                    
                    let admodalStr = AdModal.toJSONString()
                    
                   
                   print("admodalStr2222",admodalStr)
                    AdvertismentRequest.call_request(param: admodalStr!) { [self]
                        
                        (res) in
                        
                        let adModalResponse : [AdvertismentResponse] = Mapper<AdvertismentResponse>().mapArray(JSONString: res)!
                        
                        
                        
                        for i in adModalResponse {
                            if i.Status.elementsEqual("1") {
                                print("AdConstantadDataListtt",AdConstant.adDataList.count)
                                
                               
                              
                                
                                AdConstant.adDataList.removeAll()
                                AdConstant.adDataList = i.data
                                
                                startTimer()
                                
                            }else{
                                
                            }
                            
                        }
                        
                        print("admodalStr_count", AdConstant.adDataList .count)

                        

            //
                    }
               
                    
                } catch {
                    print("Error fetching data: \(error)")
                }
            }
            
            
   
            
            let imgTap = AdGesture (target: self, action: #selector(viewTapped))
            AdView.addGestureRecognizer(imgTap)
            
        }
    }
    
    
    
    func startTimer() {
        if AdConstant.adDataList.count > 0 {
            
            let url : String =  AdConstant.adDataList[0].contentUrl!
            self.imgaeURl = AdConstant.adDataList[0].redirectUrl!
            self.AdName = AdConstant.adDataList[0].advertisementName!
            self.getadID = AdConstant.adDataList[0].id!
            self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            
            AdView.isHidden = false
                           adViewHeight.constant = 80
            
            if(self.firstImage == 0){
                self.imageCount =  1
            }
            else{
                self.imageCount =  0
            }
            
            let minC : Int = UserDefaults.standard.integer(forKey: ADTIMERINTERVAL)
            print("minC",minC)
            var AdSec = String(minC / 1000)
            print("minutesBefore",AdSec)
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(AdSec)!, repeats: true) { [weak self] _ in
                
                
                if(AdConstant.adDataList.count == self!.imageCount){
                    self!.imageCount = 0
                    self!.firstImage = 1
                }
                
                self!.imageCount = self!.imageCount + 1
                
                let url : String =  AdConstant.adDataList[self!.imageCount-1].contentUrl!
                self!.imgaeURl = AdConstant.adDataList[self!.imageCount-1].redirectUrl!
                self!.AdName = AdConstant.adDataList[self!.imageCount-1].advertisementName!
                self!.getadID = AdConstant.adDataList[self!.imageCount-1].id!
                
                self!.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            }
            
        }else {
            AdView.isHidden = true
            adViewHeight.constant = 0
        }
        
    }



    func stopTimer() {
        print("Stopped timer")
        timer?.invalidate()
    }
    
    @IBAction func viewTapped() {
        
   
        if imgaeURl.isEmpty != true {
            let vc = AdRedirectViewController(nibName: nil, bundle: nil)
               
              
               vc.advertisement_Name = AdName
               vc.redirect_urls = imgaeURl
            vc.adIdget = getadID
            vc.getMenuID = menuId
               vc.modalPresentationStyle = .fullScreen
               present(vc, animated: true, completion: nil)
      
           

        }else{
            print("isEmpty")
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        if(SenderType == "FromStaff")
        {
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "comeBackStaff"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }else
        {
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name(rawValue: "comeBack"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
     strCountryCode = UserDefaults.standard.object(forKey: COUNTRY_CODE) as! String
       
      self.callSelectedLanguage()
    }
    //CallImageDetailApi
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
    


     func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(typesArray.count == 0){
            if(appDelegate.isPasswordBind != "0"){
                emptyView()
            }
            return 0
        }else{
            restoreView()
            if(!bIsSeeMore){
                return typesArray.count + 1
                
            }else{
                return typesArray.count
                
            }
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row <= (typesArray.count - 1)){

            
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ImageFileTableViewCell", for: indexPath) as! ImageFileTableViewCell
        
        let detailsDictionary = typesArray.object(at: indexPath.row) as! NSDictionary
        
        cell1.TimeLbl.text =  String(describing: detailsDictionary["Time"]!)
        cell1.SubjectLbl.text = String(describing: detailsDictionary["Subject"]!)
        cell1.DateLbl.text = String(describing: detailsDictionary["Date"]!)
        if(SenderType == "FromStaff")
        {
                 var desc  = String(describing: detailsDictionary["Description"]!)

            if desc != "" && desc != nil {

                cell1.TitleLbl.text = desc

                print("desc",desc)
                cell1.TitleLbl.isHidden = false

            }else{
                cell1.TitleLbl.isHidden = true
                print("desEmptyc",desc)


            }

        }else{
            cell1.TitleLbl.text = String(describing: detailsDictionary["Description"]!)
        }
        DispatchQueue.global(qos: .background).async {
            
            
            cell1.MyImageView?.setIndicatorStyle(.whiteLarge)
            cell1.MyImageView?.setShowActivityIndicator(true)
            
            SDImageCache.shared().shouldDecompressImages = false
            SDWebImageDownloader.shared().shouldDecompressImages = false
            
            DispatchQueue.main.async {
                
                cell1.MyImageView.sd_setImage(
                    with: NSURL(string: (detailsDictionary["URL"] as? String)!) as URL?,
                    placeholderImage: nil,
                    options: SDWebImageOptions.retryFailed,
                    progress: nil,
                    completed: { (image, error, cacheType, imageUrl) in
                        
                        guard let image = image else {
                            cell1.MyImageView.image = UIImage(named: "placeHolder")
                            return }
                        //  print("Image arrived!")
                        cell1.MyImageView.image = self.resizeImage(image: image, newWidth: 100)
                        cell1.MyImageView?.setShowActivityIndicator(false)
                }
                )
                
            }
        }
       
            cell1.ViewFullImageButton.setTitle(commonStringNames.hint_save_image.translated() as? String, for: .normal)
                                               cell1.SaveButton.setTitle(commonStringNames.btn_save_image.translated() as? String, for: .normal)
        
        cell1.MyImageView?.isUserInteractionEnabled = true
        cell1.MyImageView?.tag = indexPath.row
        
        cell1.NewLbl.tag = indexPath.row
        cell1.ViewFullImageButton.addTarget(self, action: #selector(ViewFullImage(sender:)), for: .touchUpInside)
        cell1.ViewFullImageButton.tag = indexPath.row
        cell1.SaveButton.addTarget(self, action: #selector(ImageTVCTableViewController.SaveImageButton(sender:)), for: .touchUpInside)
        cell1.SaveButton.tag = indexPath.row
        let iReadVoice : Int? = Int((detailsDictionary["AppReadStatus"] as? String)!)
        // iReadVoice = 0
        if(iReadVoice == 0){
            
            cell1.NewLbl.isHidden = false
            
        }
        else
        {
            cell1.NewLbl.isHidden = true
            
            
        }
        cell1.backgroundColor = UIColor.clear
        
        return cell1
        }
        else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SeeMoreTVCell", for: indexPath) as! SeeMoreTVCell
           
            print("SeeMoreTVCell921")
            cell.SeeMoreBtn.isHidden = false
                    cell.SeeMoreBtn.addTarget(self, action: #selector(self.seeMoreButtonTapped), for: .touchUpInside)
                    cell.backgroundColor = .clear
                    return cell

                }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let newHeight = newWidth
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row <= (typesArray.count - 1)){

        let dict = typesArray[indexPath.row] as! NSDictionary
        
        var DescriptionText = String()
        var CheckNilText = String()
        if(SenderType == "FromStaff")
        {
            DescriptionText = String(describing: dict["Description"]!)
            CheckNilText  = Util .checkNil(DescriptionText)
        }else
        {
            DescriptionText = String(describing: dict["Description"]!)
            CheckNilText  = Util .checkNil(DescriptionText)
        }
        
        
        if(CheckNilText != "")        {
            
            let Stringlength : Int = CheckNilText.count
            
            if(UIDevice.current.userInterfaceIdiom == .pad)
            {
                
                let MuValue : Int = Stringlength/61
                if(indexPath.row <= (typesArray.count - 1)){
                    return (412 + ( 22 * CGFloat(MuValue)))

                }else{
                    return (412 + 40 + ( 22 * CGFloat(MuValue)))

                }
            }else{
                if(indexPath.row <= (typesArray.count - 1)){

                if(Screenheight > 580)
                {
                    let MuValue : Int = Stringlength/50
                    return (268 + ( 18 * CGFloat(MuValue)))
                    
                }else{
                    let MuValue : Int = Stringlength/44
                    return (268 + ( 18 * CGFloat(MuValue)))
                }
                }else{
                    if(Screenheight > 580)
                    {
                        let MuValue : Int = Stringlength/50
                        return (268 + 40 + ( 18 * CGFloat(MuValue)))
                        
                    }else{
                        let MuValue : Int = Stringlength/44
                        return (268 + 40 + ( 18 * CGFloat(MuValue)))
                    }
                }
            }
            
        }
        else{
            if(indexPath.row <= (typesArray.count - 1)){
                if(UIDevice.current.userInterfaceIdiom == .pad)
                {
                    return 358
                }else{
                    return 238
                }
            }else{
                if(UIDevice.current.userInterfaceIdiom == .pad)
                {
                    return 358 + 40
                }else{
                    return 238 + 40
                }
            }
           
        }
        }else{
            return 40

        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ImageFileTableViewCell", for: indexPath) as! ImageFileTableViewCell
        cell1.NewLbl.tag = indexPath.row
        
        let detailsDictionary = typesArray.object(at: indexPath.row) as! NSDictionary
        
        detailsDictionaryfull = detailsDictionary
        
        let dict = NSMutableDictionary(dictionary: detailsDictionary)
        
        var iReadVoice : Int? = Int((detailsDictionary["AppReadStatus"] as? String)!)
        
        //  iReadVoice = 0
        bIsArchive = dict["is_Archive"] as? Bool ?? false

        if(iReadVoice == 0){
            cell1.NewLbl.isHidden = false
            
            dict["AppReadStatus"] = "1"
            
            typesArray[indexPath.row] = dict
            //
            if(SenderType == "FromStaff")
            {
                CallStaffImageReadStatusUpdateApi(String(describing: detailsDictionary["ID"]!) , "IMAGE")
            }else
            {


                CallReadStatusUpdateApi(String(describing: detailsDictionary["MessageID"]!) , "IMAGE")
            }
            
        }
        else
        {
            cell1.NewLbl.isHidden = true
            
        }
        //callViewFullImage(indexPath.row)
        TextDetailstableview.reloadData()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ImageDetailVCSeg", sender: self)
        }
        
    }
    @objc func ViewFullImage(sender: UIButton)
    {
        let buttonTag = sender.tag
        
        callViewFullImage(buttonTag)
        
    }
    func callViewFullImage(_ buttonTag : NSInteger) -> Void {
        
        let detailsDictionary = typesArray.object(at: buttonTag) as! NSDictionary
        
        detailsDictionaryfull = detailsDictionary
        
        let dict = NSMutableDictionary(dictionary: detailsDictionary)
        
        let iReadVoice : Int? = Int((detailsDictionary["AppReadStatus"] as? String)!)
        
        //  iReadVoice = 0
        bIsArchive = dict["is_Archive"] as? Bool ?? false

        if(iReadVoice == 0){
            //  cell1.NewOrOldLabel.isHidden = false
            
            dict["AppReadStatus"] = "1"
            
            typesArray[buttonTag] = dict
            
            if(SenderType == "FromStaff")
            {
                CallStaffImageReadStatusUpdateApi(String(describing: detailsDictionary["ID"]!) , "IMAGE")
            }else
            {
                CallReadStatusUpdateApi(String(describing: detailsDictionary["MessageID"]!) , "IMAGE")
            }
            
        }
        else
        {
            //  cell1.NewOrOldLabel.isHidden = true
            
        }
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ImageDetailVCSeg", sender: self)
        }
        
        
    }
    
    @objc func SaveImageButton (sender : UIButton)
    {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        
        showLoading()
        // mystring = "ImageFile"
        let buttonTag = sender.tag
        
        let detailsDictionary = typesArray.object(at: buttonTag) as! NSDictionary
        
        //print(typesArray)
        detailsDictionaryfull = detailsDictionary
        
        let dict = NSMutableDictionary(dictionary: detailsDictionary)
        bIsArchive = dict["is_Archive"] as? Bool ?? false

        let iReadVoice : Int? = Int((detailsDictionary["AppReadStatus"] as? String)!)
        
        //  iReadVoice = 0
        
        if(iReadVoice == 0){
            //  cell1.NewOrOldLabel.isHidden = false
            
            dict["AppReadStatus"] = "1"
            
            typesArray[buttonTag] = dict
            
            if(SenderType == "FromStaff")
            {
                CallStaffImageReadStatusUpdateApi(String(describing: detailsDictionary["MessageID"]!) , "IMAGE")
            }else
            {
                CallReadStatusUpdateApi(String(describing: detailsDictionary["MessageID"]!) , "IMAGE")
            }
            
        }
        
        DispatchQueue.global(qos: .background).async {
            
            // Validate user input
            
            SDImageCache.shared().shouldDecompressImages = false
            SDWebImageDownloader.shared().shouldDecompressImages = false
            let urlstring : String =  String(describing: detailsDictionary["URL"]!)
            
            // FullImageView.getURLString(urlString: urlstring)
            var imagefull : UIImage = UIImage()
            let url = URL(string: urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
          //  print(url)
            if let data = try? Data(contentsOf: url)
            {
                let image: UIImage = UIImage(data: data)!
                imagefull = image
            }
          //  print(imagefull)
          
            // Go back to the main thread to update the UI
            DispatchQueue.main.async {
                
                UIImageWriteToSavedPhotosAlbum(imagefull, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                
            }
        }
        
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        hideLoading()
        if error != nil {
            Util.showAlert("", msg: SAVE_ERROR)
            
        } else {
            Util.showAlert("", msg: SAVE_SUCCESS)
            
        }
    }
    
    func CallReadStatusUpdateApi(_ ID : String, _ type : String) {
        //showLoading()
        
        strApiFrom = "UpdateReadStatus"
        let apiCall = API_call.init()
        apiCall.delegate = self;
        let baseUrlString = UserDefaults.standard.object(forKey:PARENTBASEURL) as? String
        
        var requestStringer = baseUrlString! + READ_STATUS_UPDATE
        
        print("bIsArchivebIsArchive",bIsArchive)
        if(bIsArchive){
        // if(appDelegate.isPasswordBind == "1" && bIsArchive){
                   requestStringer = baseUrlString! + READ_STATUS_UPDATE_SEEMORE
               }
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        //{"ID":"16037816","Type":"SMS"}
        let myDict:NSMutableDictionary = ["ID" : ID,"Type" : type, COUNTRY_CODE: strCountryCode]
        
        let myString = Util.convertNSDictionary(toString: myDict)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "UpdateReadStatus")
    }
    
    func CallStaffImageReadStatusUpdateApi(_ ID : String, _ type : String) {
        //showLoading()
        
        strApiFrom = "StaffImageReadStatus"
        let apiCall = API_call.init()
        apiCall.delegate = self;
        let baseUrlString = UserDefaults.standard.object(forKey:BASEURL) as? String
        
        var requestStringer = baseUrlString! + READ_STATUS_UPDATE
        

        // if(appDelegate.isPasswordBind == "1" && bIsArchive){
        if(bIsArchive){
                   requestStringer = baseUrlString! + READ_STATUS_UPDATE_SEEMORE
               }
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        //{"ID":"16037816","Type":"SMS"}
        let myDict:NSMutableDictionary = ["ID" : ID,"Type" : type, COUNTRY_CODE: strCountryCode]
        
        let myString = Util.convertNSDictionary(toString: myDict)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "StaffImageReadStatus")
    }
    
    
    func CallStaffImageMessageApi() {
        showLoading()
        strApiFrom = "CallStaffImageMessageApi"
        print("CallStaffImageMessageApi")
        let apiCall = API_call.init()
        apiCall.delegate = self;
        
        let baseUrlString = UserDefaults.standard.object(forKey:BASEURL) as? String
        var requestStringer = baseUrlString! + GET_FILES_STAFF
        let baseReportUrlString = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL) as? String

                if(appDelegate.isPasswordBind == "1"){
                    requestStringer = baseReportUrlString! + GET_FILES_STAFF
                }
        
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        //{"SchoolId":"1235","MemberId":"112712","CircularDate":"20-05-2018","Type":"VOICE"}
        print("SCHOOL",SchoolId)
        print("MEMEBER",ChildId)
        let myDict:NSMutableDictionary = ["SchoolId": SchoolId,"MemberId" : ChildId,"CircularDate" : TextDateLabel.text!,"Type" : "IMAGE", COUNTRY_CODE: strCountryCode]
        print("myDictmyDictCallStaffImageMessageApi",myDict)
        utilObj.printLogKey(printKey: "myDict", printingValue: myDict)
        let myString = Util.convertNSDictionary(toString: myDict)
        utilObj.printLogKey(printKey: "myString", printingValue: myString!)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "CallStaffImageMessageApi")
        
        
    }
    
    func CallSeeMoreStaffImageMessageApi() {
        showLoading()
        strApiFrom = "CallSeeMoreStaffImageMessageApi"
        let apiCall = API_call.init()
        apiCall.delegate = self;
        
        let baseUrlString = UserDefaults.standard.object(forKey:BASEURL) as? String
        var requestStringer = baseUrlString! + GET_FILES_STAFF_ARCHIVE
        let baseReportUrlString = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL) as? String

                       if(appDelegate.isPasswordBind == "1"){
                           requestStringer = baseReportUrlString! + GET_FILES_STAFF_ARCHIVE
                       }
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        print("requestString",requestString)
        //{"SchoolId":"1235","MemberId":"112712","CircularDate":"20-05-2018","Type":"VOICE"}
        let myDict:NSMutableDictionary = ["SchoolId": SchoolId,"MemberId" : ChildId,"CircularDate" : TextDateLabel.text!,"Type" : "IMAGE", COUNTRY_CODE: strCountryCode]
        utilObj.printLogKey(printKey: "myDict", printingValue: myDict)
        let myString = Util.convertNSDictionary(toString: myDict)
        utilObj.printLogKey(printKey: "myString", printingValue: myString!)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "CallSeeMoreStaffImageMessageApi")
        
     
    }
    func CallImageDetailApi() {
        
        
        showLoading()
        strApiFrom = "CallImageDetailApi"
        let apiCall = API_call.init()
        apiCall.delegate = self;
        
        let baseUrlString = UserDefaults.standard.object(forKey:PARENTBASEURL) as? String
        var requestStringer = baseUrlString! + GET_EMERGENCY_FILES
        let baseReportUrlString = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL) as? String

                if(appDelegate.isPasswordBind == "1"){
                    requestStringer = baseReportUrlString! + GET_EMERGENCY_FILES
                }
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        //{"ChildID":"7466","SchoolID":"1806","Type":"VOICE"}
        let myDict:NSMutableDictionary = ["ChildID": ChildId,"SchoolID" : SchoolId, "Type" : "IMAGE", COUNTRY_CODE: strCountryCode,MOBILE_NUMBER : appDelegate.strMobileNumber ]
        utilObj.printLogKey(printKey: "myDict", printingValue: myDict)
        let myString = Util.convertNSDictionary(toString: myDict)
        utilObj.printLogKey(printKey: "myString", printingValue: myString!)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "CallImageDetailApi")
    }
    
    func CallSeeMoreImageDetailApi() {
        showLoading()
        strApiFrom = "CallSeeMoreImageDetailApi"
        let apiCall = API_call.init()
        apiCall.delegate = self;
        
        let baseUrlString = UserDefaults.standard.object(forKey:PARENTBASEURL) as? String
        var requestStringer = baseUrlString! + GET_EMERGENCY_FILES_SEEMORE
        
        let baseReportUrlString = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL) as? String

                if(appDelegate.isPasswordBind == "1"){
                    requestStringer = baseReportUrlString! + GET_EMERGENCY_FILES_SEEMORE
                }
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print("requestStringrequestString",requestString)
        //{"ChildID":"7466","SchoolID":"1806","Type":"VOICE"}
        let myDict:NSMutableDictionary = ["ChildID": ChildId,"SchoolID" : SchoolId, "Type" : "IMAGE", COUNTRY_CODE: strCountryCode,MOBILE_NUMBER : appDelegate.strMobileNumber ]
        utilObj.printLogKey(printKey: "myDict", printingValue: myDict)
        let myString = Util.convertNSDictionary(toString: myDict)
        utilObj.printLogKey(printKey: "myString", printingValue: myString!)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "CallSeeMoreImageDetailApi")
    }
    
    @objc func responestring(_ csData: NSMutableArray?, _ pagename: String!) {
        hideLoading()
        
        
        if(csData != nil)
        {
            utilObj.printLogKey(printKey: "csData", printingValue: csData)
            if(strApiFrom == "StaffImageReadStatus"){
                if((csData?.count)! > 0){
                    TextDetailstableview.reloadData()
                }
            }else if(strApiFrom == "UpdateReadStatus"){
                if((csData?.count)! > 0){
                    TextDetailstableview.reloadData()
                }
            }
            else if(strApiFrom == "CallImageDetailApi")
            {
                print("typesArray,CallImageDetailApi",typesArray.count)
               
                
                
                if let CheckedArray = csData as? NSArray
                {
                    let arrayData = CheckedArray
                    for i in 0..<arrayData.count
                    {
                        let dict = CheckedArray[i] as! NSDictionary
                        let Status = String(describing: dict["Status"]!)
                        let Message = String(describing: dict["Message"]!)
                        if(Status == "1")
                        {
                            typesArray.add(dict)
                            ArrayData.add(dict)
                            
                        }else{
                            
                          //  AlerMessage()
                            altSting = Message
                            if(appDelegate.isPasswordBind == "0"){
                                AlerMessage()
                            }
                            
                        }
                    }
            
                    utilObj.printLogKey(printKey: "typesArray", printingValue: typesArray)
                    TextDetailstableview.reloadData()
                    
                    
                }
                else{
                    Util.showAlert("", msg: strSomething)
                }
            }else if(strApiFrom == "CallSeeMoreImageDetailApi")
            {
//                typesArray.removeAllObjects()
                if let CheckedArray = csData as? NSArray
                {
                    let arrayData = CheckedArray
                    for i in 0..<arrayData.count
                    {
                        let dict = CheckedArray[i] as! NSDictionary
                        let Status = String(describing: dict["Status"]!)
                        let Message = String(describing: dict["Message"]!)
                        if(Status == "1")
                        {
                            typesArray.add(dict)
                            MainDetailTextArray.add(dict)

                            
                        }else{
                            
                            AlerMessage()
                            
                        }
                    }
                    utilObj.printLogKey(printKey: "typesArray", printingValue: typesArray)
                    TextDetailstableview.reloadData()
                    
                    
                }
                else{
                    Util.showAlert("", msg: strSomething)
                }
            }
            
            if(strApiFrom == "CallStaffImageMessageApi")
            {
                if let CheckedArray = csData as? NSArray
                {
                    let arrayData = CheckedArray
                    for i in 0..<arrayData.count
                    {
                        let dict = CheckedArray[i] as! NSDictionary
                        let Status = String(describing: dict["ID"]!)
                        
                        let Message = String(describing: dict["URL"]!)
                        let CheckNilText : String = Util .checkNil(Status)
                        if(CheckNilText != "")
                        {
                            typesArray.add(dict)
                            MainDetailTextArray.add(dict)

                        }else{
                            AlerMessage()
                           
                            
                            
                        }
                    }
                    
                    TextDetailstableview.reloadData()
                    
                    
                }
                else{
                    Util.showAlert("", msg: strSomething)
                }
            }
            else if(strApiFrom == "CallSeeMoreStaffImageMessageApi")
            {
                if let CheckedArray = csData as? NSArray
                {
                    let arrayData = CheckedArray
                    for i in 0..<arrayData.count
                    {
                        let dict = CheckedArray[i] as! NSDictionary
                        let Status = String(describing: dict["ID"]!)
                        
                        let Message = String(describing: dict["URL"]!)
                        let CheckNilText : String = Util .checkNil(Status)
                        if(CheckNilText != "")
                        {
                            typesArray.add(dict)
                            MainDetailTextArray.add(dict)

                        }else{
                            AlerMessage()
                            
                            
                        }
                    }
                    
                    TextDetailstableview.reloadData()
                    
                    
                }
                else{
                    Util.showAlert("", msg: strSomething)
                }
            }
        }
        else
        {
            Util.showAlert("", msg: strSomething)
        }
        
        
        
    }
    
    @objc func failedresponse(_ pagename: Error!) {
        hideLoading()
        
        Util .showAlert("", msg: pagename.localizedDescription);
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ImageDetailVCSeg")
        {
            let segueid = segue.destination as! ImageDetailVC
            segueid.SenderType = SenderType
            segueid.selectedDictionary = detailsDictionaryfull
        }
    }
    
    func showLoading() -> Void {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.animationType = MBProgressHUDAnimationFade
        hud.labelText = "Loading"
        
    }
    
    func hideLoading() -> Void{
        
        hud.hide(true)
    }
    func AlerMessage()
    {
        
                let alertController = UIAlertController(title: commonStringNames.alert.translated() as? String, message: strNoRecordAlert, preferredStyle: .alert)
        
                let okAction = UIAlertAction(title: commonStringNames.teacher_btn_ok.translated() as? String, style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Language Selection
    
    func callSelectedLanguage(){
        
        print("typesArray1",typesArray.count)
        if typesArray != nil{
            
            typesArray.removeAllObjects()
        }
        print("typesArray2",typesArray.count)
        let strLanguage = UserDefaults.standard.object(forKey: SELECTED_LANGUAGE) as! String
        let bundle = Bundle(for: type(of: self))
        if let theURL = bundle.url(forResource: strLanguage, withExtension: "json") {
            do {
                let data = try Data(contentsOf: theURL)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as AnyObject {
                    self.loadLanguageData(LangDict: parsedData as! NSDictionary, Language: strLanguage)
                }else{
                    self.loadViewData()
                }
            } catch {
                 self.loadViewData()
            }
        }
    }
    
    func loadLanguageData(LangDict : NSDictionary, Language : String){
        languageDict = LangDict
        if(Language == "ar"){
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
            self.view.semanticContentAttribute = .forceRightToLeft
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
            self.view.semanticContentAttribute = .forceLeftToRight
        }
        strNoRecordAlert = commonStringNames.no_records.translated() as? String ?? "No Record Found"
        strNoInternet = commonStringNames.check_internet.translated() as? String ?? "Check your Internet connectivity"
        strSomething = commonStringNames.catch_message.translated() as? String ?? "Something went wrong.Try Again"
        loadViewData()
    }
    
    func loadViewData(){
        Screenheight = CFloat(self.view.frame.size.height)
        
        if typesArray != nil{
            
            typesArray.removeAllObjects()
        }
        if(Util .isNetworkConnected()){
            if(SenderType == "FromStaff"){
                if(appDelegate.LoginSchoolDetailArray.count > 0){
                    let dict:NSDictionary = appDelegate.LoginSchoolDetailArray[0] as! NSDictionary
                    if getMsgFromMgnt == 1 {
                        let defaults = UserDefaults.standard
                        print("SchoolId",SchoolId)
                    }
                    else{
                            ChildId = String(describing: dict["StaffID"]!)
                            SchoolId = String(describing: dict["SchoolID"]!)
                        }
                    TextDateLabel.text = String(describing: ImageSelectedDict["Date"]!)
                    bIsArchive = ImageSelectedDict["is_Archive"] as? Bool ?? false

                    if(Util .isNetworkConnected()){
                        if(bIsArchive){
                           
                            print("bIsArchive12345432")
                            CallSeeMoreStaffImageMessageApi()
                        }else{
                            
                    
                            CallStaffImageMessageApi()

                        }
                    }else{
                        Util .showAlert("", msg: strNoInternet)
                    }
                }else{
                    Util.showAlert("", msg: strNoRecordAlert)
                }
            }else{
                if getMsgFromMgnt == 1 {
                    let defaults = UserDefaults.standard
                    print("SchoolId",SchoolId)
                }
                else{
                    ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
                    SchoolId = String(describing: appDelegate.SchoolDetailDictionary["SchoolID"]!)
                }
                self.CallImageDetailApi()
            }
        }else{
            Util .showAlert("", msg: strNoInternet)
        }
    }
    //Mark:- SeeMore Feature
    func emptyView(){
        let noview : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.TextDetailstableview.bounds.size.width, height: self.TextDetailstableview.bounds.size.height))

        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y:  40, width: self.TextDetailstableview.bounds.size.width, height: 80))
        noDataLabel.text = altSting
        noDataLabel.textColor = .red
        noDataLabel.backgroundColor = UIColor(named: "NoDataColor")

        noDataLabel.numberOfLines = 0
        
        noDataLabel.textAlignment = NSTextAlignment.center
        noview.addSubview(noDataLabel)
        
        let button = UIButton(frame: CGRect(x: self.TextDetailstableview.bounds.size.width - 108, y: noDataLabel.frame.height + 55, width: 100, height: 32))
         button.setTitle(commonStringNames.SeeMore.translated(), for: .normal)
         button.backgroundColor = .white
        button.setTitleColor(utilObj.PARENT_NAV_BAR_COLOR, for: .normal)
         button.addTarget(self, action: #selector(self.seeMoreButtonTapped), for: .touchUpInside)
            noview.addSubview(button)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = utilObj.PARENT_NAV_BAR_COLOR.cgColor
        
        self.TextDetailstableview.backgroundView = noview
    }
    func restoreView(){
        self.TextDetailstableview.backgroundView = nil
    }
    
    @objc func seeMoreButtonTapped(sender : UIButton) {
                    //Write button action here
//        bIsSeeMore = true
        self.TextDetailstableview.reloadData()
        
        if(SenderType == "FromStaff"){
            CallSeeMoreStaffImageMessageApi()
          
        }
        else{
            bIsSeeMore = true
            CallSeeMoreImageDetailApi()
        }
       
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.count == 0{
            typesArray = ArrayData
            self.TextDetailstableview.reloadData()

        }else{
            let resultPredicate = NSPredicate(format: "Description CONTAINS [c] %@ OR Date CONTAINS [c] %@ ", searchText, searchText)
            let arrSearchResults = ArrayData.filter { resultPredicate.evaluate(with: $0) } as NSArray
            typesArray = NSMutableArray(array: arrSearchResults)
            if(typesArray.count > 0){
                self.TextDetailstableview.reloadData()
                print("DetailVoiceArray.count > 0")
            }else{
                print("noDataLabel.isHidden = false")
            }
        }

        self.TextDetailstableview.reloadData()
        print("search is worked")
    }



    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        typesArray = ArrayData

        print("searchBarCancelButtonClicked")
        self.TextDetailstableview.reloadData()


    }



    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {


        searchBar.resignFirstResponder()
    }
    
    
    
    
    
    
    
}
