//
//  ManagementVideoViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 10/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ObjectMapper

class ManagementVideoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tv: UITableView!
    
    let rowIdentifier = "ManagementVideoTableViewCell"
    var msgFromList : [MessageFromManagentVideoResponse] = []
    var SchoolID : String!
    var memberID : String!
    var countryCode : String!
    var chilId : String!
    var strSenderType : String!
    var videoSelectedDict = [String: Any]() as NSDictionary

    var bIsArchive = Bool()
    var getDate : String!
    var getArchive : String!
    var getMsgFromMgnt : Int! = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(back))
        backView.addGestureRecognizer(backGesture)
        print("getMsgFromMgntgetMsgFromMgnt",getMsgFromMgnt)
        if getMsgFromMgnt == 1 {
            let defaults = UserDefaults.standard
            print("SchoolId11",chilId)

        }else{
            let defaults = UserDefaults.standard
            chilId = defaults.string(forKey:DefaultsKeys.chilId)
            getDate = defaults.string(forKey:DefaultsKeys.selectDate)
        }

        bIsArchive = videoSelectedDict["is_Archive"] as? Bool ?? false

        print("chilId1233334",chilId)
        print("DefaultsKeys.selectDate",getDate)
        print("getArchive",getArchive)
        
        getFiles() 
        tv.dataSource = self
        tv.delegate = self
        
        let rowNib  = UINib(nibName: rowIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFiles()
    }
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgFromList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! ManagementVideoTableViewCell
        
        let messgae : MessageFromManagentVideoResponse = msgFromList[indexPath.row]
        cell.CreatedOnLbl.text = messgae.Date
        cell.DescriptionLbl.text = messgae.Description
        cell.TitleLbl.text = messgae.Subject
        cell.CreatedByLbl.text = messgae.Time
        cell.selectionStyle = .none

        
//        let videoTapgesture = UITapGestureRecognizer(target: self, action: #selector(VideoClick))
//        cell.OverAllview.addGestureRecognizer(videoTapgesture)
//        
        
        print("bIsArchive",bIsArchive)
        print("messgaes_Archive",messgae.is_Archive)
        if messgae.AppReadStatus == "1" {
            cell.newLblHight.constant = 0
        }else{
            cell.newLblHight.constant = 16
        }
        
        if(strSenderType == "FromStaff")
        {
            var desc  = messgae.Description

                        if desc != "" && desc != nil {
            
                            cell.DescriptionLbl.text = desc

                            print("desc",desc)
                            cell.DescriptionLbl.isHidden = false

                        }else{
                            cell.DescriptionLbl.isHidden = true
                            print("desEmptyc",desc)
            
            
                        }

        }

        return cell
    }
    
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Working")
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! ManagementVideoTableViewCell
        
        
        let messgae : MessageFromManagentVideoResponse = msgFromList[indexPath.row]
        
        if messgae.Status == "1" {
            let vc = ManagementVimeoViewController(nibName: nil, bundle: nil)
            vc.Id = messgae.ID
            cell.newLblHight.constant = 0
            
            vc.strVideoUrl = messgae.URL
            vc.videoId = messgae.VimeoId
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }else{
            self.view.makeToast(messgae.URL, duration: 1.5)
            
        }
        
        
        
    }
    
    
    
    
//    @objc func VideoClick () {
//        let messgae : MessageFromManagentVideoResponse = msgFromList[indexPath.row]
//        
//        if messgae.Status == "1" {
//            let vc = ManagementVimeoViewController(nibName: nil, bundle: nil)
//            vc.Id = messgae.ID
//            cell.newLblHight.constant = 0
//            
//            vc.strVideoUrl = messgae.URL
//            vc.videoId = messgae.VimeoId
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        }else{
//            self.view.makeToast(messgae.URL, duration: 1.5)
//            
//        }
//    }
    
    func getFiles()  {
        let msgFromModal = MessageFromManagentVideoModal()
        print("SchoolId",SchoolID)
        print("chilId",chilId)
        print("countryCode",countryCode)
        
        msgFromModal.SchoolId = SchoolID
        msgFromModal.MemberId = chilId
        msgFromModal.videoType = "VIDEO"
        msgFromModal.CircularDate = getDate
//        msgFromModal.CountryID = countryCode
        
        let msgFromModalStr = msgFromModal.toJSONString()
        print("msgFromModalStr",msgFromModalStr)
        print("getArchive",getArchive)
        if getArchive == "1" {
            MessageFromManagentVideoRequestGetFilesStaff_Archive.call_request(param: msgFromModalStr!) {
                [self]   (res) in
                
                
                
                
                
                let msgFromResponse : [MessageFromManagentVideoResponse] = Mapper<MessageFromManagentVideoResponse>().mapArray(JSONString: res)!
                
                msgFromList = msgFromResponse
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }
        }else{
            MessageFromManagentVideoRequestGetFilesStaff.call_request(param: msgFromModalStr!) {
                [self]   (res) in
                
                
                
                
                
                let msgFromResponse : [MessageFromManagentVideoResponse] = Mapper<MessageFromManagentVideoResponse>().mapArray(JSONString: res)!
                
                msgFromList = msgFromResponse
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }
        }
    }
    
    
    
    
}
