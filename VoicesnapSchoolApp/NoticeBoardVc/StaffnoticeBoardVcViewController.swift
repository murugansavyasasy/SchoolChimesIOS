//
//  StaffnoticeBoardVcViewController.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 04/10/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class StaffnoticeBoardVcViewController: UIViewController, Apidelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
  
    
    var DetailTextArray = NSMutableArray()
    
    var hud : MBProgressHUD = MBProgressHUD()
    var strApiFrom = NSString()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var SelectedStr = String()
    var SelectedIndex = IndexPath()
    let utilObj = UtilClass()
    var strSomething = String()
    var altSting = String()
    var languageDictionary = NSDictionary()
    var MainDetailTextArray: NSMutableArray = NSMutableArray()
    var type : Int!
    var instituteId : Int!
    var staffId  : Int!
    var strCountryCode : String!
    var identifer = "TextFileTableViewCell"
    var bIsSeeMore = Bool()
    var SelectedSectionArray : NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var HiddenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        strCountryCode = UserDefaults.standard.object(forKey: COUNTRY_CODE) as! String
        
        bIsSeeMore = false
        HiddenLabel.isHidden = true
        let userDefaults = UserDefaults.standard
      

        if  type  == 1{
            
            
        }else{
            
            
            instituteId = userDefaults.integer(forKey: DefaultsKeys.SchoolD)
            staffId = userDefaults.integer(forKey: DefaultsKeys.StaffID)        }
        

        CallDetailNoticeMessageApi()
        
        NoticeBoardTableview.dataSource = self
        NoticeBoardTableview.delegate = self
        search_bar.delegate = self
        search_bar.placeholder = commonStringNames.Search.translated()
        
//        NoticeBoardTableview.reloadData()
      
    }


    
  
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var NoticeBoardTableview: UITableView!
    
    @IBAction func backBtn(_ sender: Any) {
        
        
        dismiss(animated: true)
        
        
    }
    
    
    @objc func responestring(_ csData: NSMutableArray?, _ pagename: String!) {
        hideLoading()
        
        if(csData != nil)
        {
            utilObj.printLogKey(printKey: "csData", printingValue: csData!)
            if(strApiFrom == "CallDetailNoticeMessage")
            {
                if let CheckedArray = csData as? NSArray
                {
                    let arrayData = CheckedArray
                    for i in 0..<arrayData.count
                    {
                        let dict = CheckedArray[i] as! NSDictionary
                        let Status = String(describing: dict["Status"]!)
                        let Message = dict["Message"] as? String ?? ""
                        altSting = Message
                        if(Status == "1")
                        {
                            let dict = arrayData[i] as! NSDictionary
                            var MutalDict : NSMutableDictionary = dict.mutableCopy() as! NSMutableDictionary
                            
                            MutalDict["ID"] = String(describing: i)
                            DetailTextArray.add(MutalDict)
                            MainDetailTextArray.add(MutalDict)
                        }else{
                            
                            if(appDelegate.isPasswordBind == "0"){
                                AlertMessage(strAlert: Message)
                            }
                            
                            
                        }
                    }
                    
                    DetailTextArray =  MainDetailTextArray
                    
                    Childrens.saveSchoolNoticeBoardDetail(DetailTextArray as! [Any] , String(staffId))
                    
                    utilObj.printLogKey(printKey: "DetailTextArray", printingValue: DetailTextArray)
                    
                   
                     NoticeBoardTableview.reloadData()
                    
                }
                else{
                    Util.showAlert("", msg: strSomething)
                }
            }
            if(strApiFrom == "CallSeeMoreDetailNoticeMessage")
            {
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
                            let dict = arrayData[i] as! NSDictionary
                            var MutalDict : NSMutableDictionary = dict.mutableCopy() as! NSMutableDictionary
                            
                            MutalDict["ID"] = String(describing: i)
                            DetailTextArray.add(MutalDict)
                        }else{
                            AlertMessage(strAlert: Message)
                            
                            
                            
                            
                        }
                    }
                    
                    
                    Childrens.saveSchoolNoticeBoardDetail(DetailTextArray as! [Any] , String(staffId))
                    
                    utilObj.printLogKey(printKey: "DetailTextArray", printingValue: DetailTextArray)
                 
                    NoticeBoardTableview.reloadData()
                    
                    
                }
                else{
                    Util.showAlert("", msg: strSomething)
                }
            }
            else if(strApiFrom == "UpdateReadStatus")
            {
                if((csData?.count)! > 0){
                    
                }
            }
        }
        else
        {
            Util.showAlert("", msg: strSomething)
        }
        
        hideLoading()
        
    }
    
    
    func AlertMessage(strAlert : String)
    {
        
        let alertController = UIAlertController(title: commonStringNames.Alert.translated(), message: strAlert, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: commonStringNames.OK.translated(), style: UIAlertAction.Style.default) {
            UIAlertAction in
            print("Okaction")
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func failedresponse(_ pagename: Error!) {
        hideLoading()
        Util.showAlert("", msg: strSomething)
        
    }
    
    func hideLoading() -> Void{
        hud.hide(true)
        // popupLoading.dismiss(true)
    }
    
    func showLoading() -> Void {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.animationType = MBProgressHUDAnimationFade
        hud.labelText = "Loading"
        
        
    }
    
    func CallDetailNoticeMessageApi() {
        showLoading()
        strApiFrom = "CallDetailNoticeMessage"
        
        let apiCall = API_call.init()
        apiCall.delegate = self;
        
        let baseUrlString = UserDefaults.standard.object(forKey:PARENTBASEURL) as? String
        var requestStringer = baseUrlString! + NOTICE_BOARD_MESSAGE
        
        
        let baseReportUrlString = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL) as? String
        
        if(appDelegate.isPasswordBind == "1"){
            requestStringer = baseReportUrlString! + NOTICE_BOARD_MESSAGE
        }
        
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let myDict:NSMutableDictionary = ["SchoolID" : instituteId]
        utilObj.printLogKey(printKey: "myDict", printingValue: myDict)
        let myString = Util.convertNSDictionary(toString: myDict)
        utilObj.printLogKey(printKey: "myString", printingValue: myString!)
        print("requestStringer1",requestStringer)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "CallDetailNoticeMessage")
    }
    
    
    func CallSeeMoreDetailNoticeMessageApi() {
        showLoading()
        strApiFrom = "CallSeeMoreDetailNoticeMessage"
        let apiCall = API_call.init()
        apiCall.delegate = self;
        
        let baseUrlString = UserDefaults.standard.object(forKey:PARENTBASEURL) as? String
        var requestStringer = baseUrlString! + NOTICE_BOARD_MESSAGE_SEEMORE
        
        let baseReportUrlString = UserDefaults.standard.object(forKey:NEWLINKREPORTBASEURL) as? String
        
        if(appDelegate.isPasswordBind == "1"){
            requestStringer = baseReportUrlString! + NOTICE_BOARD_MESSAGE_SEEMORE
        }
        let requestString = requestStringer.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let myDict:NSMutableDictionary = ["SchoolID" : instituteId]
        utilObj.printLogKey(printKey: "myDict", printingValue: myDict)
        let myString = Util.convertNSDictionary(toString: myDict)
        print("requestStringer2",requestStringer)
        utilObj.printLogKey(printKey: "myString", printingValue: myString!)
        
        apiCall.nsurlConnectionFunction(requestString, myString, "CallSeeMoreDetailNoticeMessage")
    }
    
    
    
    // MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if(DetailTextArray.count == 0){
            if(appDelegate.isPasswordBind != "0"){
                emptyView()
            }
            return 0
        }else{
            restoreView()
            if(!bIsSeeMore){
                return DetailTextArray.count + 1
            }else{
                return DetailTextArray.count
            }
        }
        
    }
    
    
    
    
    
    func emptyView(){
        let noview : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.NoticeBoardTableview.bounds.size.width, height: self.NoticeBoardTableview.bounds.size.height))
        
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y:  8, width: self.NoticeBoardTableview.bounds.size.width, height: 60))
        noDataLabel.text = altSting
        noDataLabel.textColor = .red
        noDataLabel.backgroundColor = UIColor(named: "NoDataColor")
        
        noDataLabel.numberOfLines = 0
        
        noDataLabel.textAlignment = NSTextAlignment.center
        noview.addSubview(noDataLabel)
        
        let button = UIButton(frame: CGRect(x: self.NoticeBoardTableview.bounds.size.width - 108, y: noDataLabel.frame.height + 30, width: 100, height: 32))
        button.setTitle(commonStringNames.SeeMore.translated(), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(utilObj.PARENT_NAV_BAR_COLOR, for: .normal)
        button.addTarget(self, action: #selector(self.seeMoreButtonTapped), for: .touchUpInside)
        noview.addSubview(button)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 3
        button.layer.borderColor = utilObj.PARENT_NAV_BAR_COLOR.cgColor
        
        self.NoticeBoardTableview.backgroundView = noview
    }
    func restoreView(){
        self.NoticeBoardTableview.backgroundView = nil
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row <= (DetailTextArray.count - 1)){
            
            if(SelectedIndex == indexPath)
            {
                if(SelectedStr == "Selected")
                {
                    if(UIDevice.current.userInterfaceIdiom == .pad)
                    {
                        return 388
                    }else{
                        return 345
                    }
                }else{
                    if(UIDevice.current.userInterfaceIdiom == .pad)
                    {
                        return 299
                    }else{
                        return 199
                    }
                    
                }
                
            }else
            {
                if(UIDevice.current.userInterfaceIdiom == .pad)
                {
                    return 299
                }else{
                    return 199
                }
            }
        }else{
            return 40
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(indexPath.row <= (DetailTextArray.count - 1)){
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "TextFileTableViewCell", for: indexPath) as! TextFileTableViewCell
            cell1.backgroundColor = UIColor.clear
            cell1.NewLbl.isHidden = true
            let dict = DetailTextArray[indexPath.row] as! NSDictionary
            cell1.TimeLbl.text = String(describing: dict["Day"]!)
            cell1.DateLbl.text = String(describing: dict["Date"]!)
            cell1.SubjectLbl.text = String(describing: dict["NoticeBoardTitle"]!)
            cell1.NoticeTextView.text = String(describing: dict["NoticeBoardContent"]!)
            let TextFieldChar : String = String(describing: dict["NoticeBoardContent"]!)
            
            cell1.NoticeTextView.tintColor = .systemGreen
            cell1.NoticeTextView.isEditable = false
            cell1.NoticeTextView.dataDetectorTypes = .all
            
            if(UIDevice.current.userInterfaceIdiom == .pad)
            {
                if(TextFieldChar.count > 200)
                {
                    cell1.ExtendArrow.isHidden = false
                    cell1.NoticeButton.tag = indexPath.row
                    
                    cell1.NoticeButton.addTarget(self, action: #selector(ExpandView(sender:)), for: .touchUpInside)
                    
                }else{
                    cell1.ExtendArrow.isHidden = true
                    cell1.ExtendArrow.image = UIImage(named: "GrayDownArrow")
                    cell1.NoticeButton.isUserInteractionEnabled = false
                }
                
            }else
            {
                if(TextFieldChar.count > 110)
                {
                    cell1.ExtendArrow.isHidden = false
                    cell1.NoticeButton.tag = indexPath.row
                    
                    cell1.NoticeButton.addTarget(self, action: #selector(ExpandView(sender:)), for: .touchUpInside)
                    
                }else{
                    cell1.ExtendArrow.isHidden = true
                    cell1.ExtendArrow.image = UIImage(named: "GrayDownArrow")
                    cell1.NoticeButton.isUserInteractionEnabled = false
                }
                
            }
            return cell1
        }
        
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeeMoreTVCell", for: indexPath) as! SeeMoreTVCell
            print("6")
            cell.SeeMoreBtn.addTarget(self, action: #selector(self.seeMoreButtonTapped), for: .touchUpInside)
            cell.backgroundColor = .clear
            return cell
            
        }
       
        
    }
    @objc func seeMoreButtonTapped(sender : UIButton) {
        //Write button action here
        bIsSeeMore = true
        self.NoticeBoardTableview.reloadData()
        CallSeeMoreDetailNoticeMessageApi()
        
    }
    
    @objc func ExpandView(sender: UIButton){
        let SenderButton = sender
        SelectedIndex = IndexPath(row: sender.tag, section: 0)
        let cell = NoticeBoardTableview.cellForRow(at: SelectedIndex) as! TextFileTableViewCell
        if(SenderButton.isSelected){
            SelectedStr = "Selected"
            SenderButton.isSelected = false
            cell.ExtendArrow.image = UIImage(named: "GrayUpArrow")
        }else{
            SelectedStr = "NotSelected"
            SenderButton.isSelected = true
            
            cell.ExtendArrow.image = UIImage(named: "GrayDownArrow")
            
        }
        NoticeBoardTableview.reloadData()
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0{
            DetailTextArray =  MainDetailTextArray
            self.NoticeBoardTableview.reloadData()
        }else{
            let resultPredicate = NSPredicate(format: "NoticeBoardContent CONTAINS [c] %@ OR NoticeBoardTitle CONTAINS [c] %@ ", searchText, searchText)
            let arrSearchResults = MainDetailTextArray.filter { resultPredicate.evaluate(with: $0) } as NSArray
            DetailTextArray = NSMutableArray(array: arrSearchResults)
            if(DetailTextArray.count > 0){
                self.NoticeBoardTableview.reloadData()
                print("DetailVoiceArray.count > 0")
            }else{
                print("noDataLabel.isHidden = false")
            }
            //            CallDetailSeeMoreEmergencyVocieApi()
            self.NoticeBoardTableview.reloadData()
        }
        
        
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        search_bar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        self.NoticeBoardTableview.reloadData()
        //        CallSeeMoreDetailNoticeMessageApi()
        
        search_bar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBar.resignFirstResponder()")
        
        searchBar.resignFirstResponder()
        print("searchBar.resignFirstResponder()")
        print(DetailTextArray.count)
        
        SelectedSectionArray.removeAllObjects()
        DetailTextArray = MainDetailTextArray
        self.NoticeBoardTableview.reloadData()
    }

}
