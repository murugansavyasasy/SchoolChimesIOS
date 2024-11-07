//
//  UpdateDetailViewController.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 15/11/23.
//  Copyright © 2023 Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper

class UpdateDetailViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var rotateView: UIViewX!
    @IBOutlet weak var preLbl: UILabel!
    
    @IBOutlet weak var nextLbl: UILabel!
    @IBOutlet weak var nextView: UIView!
    
    
    @IBOutlet weak var cancelView: UIViewX!
    
    @IBOutlet weak var previousView: UIView!
    
    
    @IBOutlet weak var skipView: UIView!
    
    @IBOutlet weak var cv: UICollectionView!
    var updateTime : Int!
    var  points = 0
    var index = 0
    var position : Int! = 0
    
    
    var skipType : Int!
    
    var saveIndexPos : String!
    var preposition = 1
    
    var changPos : Int! = 0
    let rowIdent = "UpdateDetailCollectionViewCell"
    
    var updateListShow : String = "1"
    var type1 : String!
    var StaffRole : String!
    var SchoolD : String!
    var MemberidTild : String!
    var  QuestionData : [UpdateDetailsData]? = []
    var type : String!
    var memeberArrayString = String()
    
    var idArray : NSMutableArray = NSMutableArray()
    
    var schoolArrayString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        print("type",type)
        
        
        print("UpdateDetailViewController1")
        StaffRole = userDefaults.string(forKey: DefaultsKeys.StaffRole)!
        
        updateDetailsApi()
        
        idArray.add(MemberidTild)
        print("memeberArrayString",memeberArrayString)
        
        print("UpdateDetailViewControllerStaffRole",StaffRole)
        print("schoolArrayString",schoolArrayString)
        
        
        previousView.isHidden = true
        
        cv.register(UINib(nibName: rowIdent, bundle: nil), forCellWithReuseIdentifier: rowIdent)
        
        
        let previousGesture = UITapGestureRecognizer(target: self, action: #selector(previousVC))
        previousView.addGestureRecognizer(previousGesture)
        
        let nextGesture = UITapGestureRecognizer(target: self, action: #selector(nextVC))
        nextView.addGestureRecognizer(nextGesture)
        
        
        
        
        
        let cancelGesture = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
        skipView.addGestureRecognizer(cancelGesture)
        
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        
        print("date",date)
        
    }
    
    
    @IBAction func cancelVc(){
        
        dismiss(animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        updateDetailsApi()
    }
    
    func updateDetailsApi(){
        
        
        
        if type == "School" {
            
            let modal = UpdateDetailsModal()
            
            
            modal.instituteid = schoolArrayString
            modal.staff_role = StaffRole
            modal.member_id = memeberArrayString
            
            let modal_str = modal.toJSONString()
            print("modal_str",modal_str)
            
            UpdateDetailRequest.call_request(param: modal_str!) {
                [self]
                (res) in
                
                let modal_response : [UpdateDetailsResponse] = Mapper<UpdateDetailsResponse>().mapArray(JSONString: res)!
                
                self.QuestionData = modal_response[0].dataList
                
                print("QuestionData",QuestionData?.count)
                if QuestionData?.count == 1 {
                    nextView.isHidden = true
                }else{
                    nextView.isHidden = false
                    
                }
                
                cv.dataSource = self
                cv.delegate = self
                cv.reloadData()
                
            }
            
        }else if type == "parent" {
            let modal = UpdateDetailsModal()
            
            
            modal.instituteid = schoolArrayString
            modal.staff_role = "parent"
            
            modal.member_id = memeberArrayString
            
            let modal_str = modal.toJSONString()
            print("modal_str",modal_str)
            
            UpdateDetailRequest.call_request(param: modal_str!) {
                [self]
                (res) in
                
                let modal_response : [UpdateDetailsResponse] = Mapper<UpdateDetailsResponse>().mapArray(JSONString: res)!
                
                self.QuestionData = modal_response[0].dataList
                
                print("QuestionData",QuestionData?.count)
                if QuestionData?.count == 1 {
                    nextView.isHidden = true
                }else{
                    nextView.isHidden = false
                    
                }
                
                cv.dataSource = self
                cv.delegate = self
                cv.reloadData()
                
            }
        }
    }
    
    @IBAction func nextVC() {
        
        let userDefaults = UserDefaults.standard
        //        86400
        userDefaults.set(86400, forKey: DefaultsKeys.updateTime)
        print("index changPos(index)",changPos)
        
        if skipType == 2 {
            
            
            if nextView.backgroundColor != .clear {
                print("12index",index)
                if index<(self.QuestionData?.count ?? 0) + 0{
                    index += 1
                    changPos += 1
                    print("index print(index)",index)
                    change_icon_style(pos:  index + position)
                    load_details(pos: index + position)
                    cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
                    
                }
                cv.reloadData()
                nextView.isUserInteractionEnabled = true
            }else{
                nextView.isUserInteractionEnabled = false
            }
            
            
            
            
        }else{
            
            
            if nextView.backgroundColor != .clear {
                print("12index",index)
                if index<(self.QuestionData?.count ?? 0) + 0{
                    index = 1
                    print("index print(index)",index)
                    print("index + changPos",index + position)
                    change_icon_style(pos:  index + changPos)
                    load_details(pos: index + changPos)
                    cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
                    
                    
                    print("NEXTPOS",index)
                    
                }
                cv.reloadData()
                nextView.isUserInteractionEnabled = true
            }else{
                nextView.isUserInteractionEnabled = false
            }
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    @IBAction func previousVC() {
        
        
        
        print("skipType11",skipType)
        
        if skipType == 2 {
            print("QuestionData?.count",QuestionData?.count)
            print("inn12345",index)
            
            if index<(self.QuestionData?.count ?? 0) - 0 {
                print("inn",index)
                index -= 1
                changPos -= 1
                print("index print(index)",index)
                print("index print(position)",position)
                change_icon_style(pos:  index + preposition )
                print("index + preposition",index + preposition )
                load_details(pos: index + preposition)
                
                
                
                if index + preposition == 1 {
                    previousView.isHidden = true
                    
                }else{
                    previousView.isHidden = false
                    
                    preLbl.text = "PREVIOUS"
                }
                
                
                
                
                cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
                
            }
            cv.reloadData()
        }else {
            
            
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(86400, forKey: DefaultsKeys.updateTime)
            if  preLbl.text == "PREVIOUS" {
                print(index)
                if index<(self.QuestionData?.count ?? 0) - 0 {
                    index -= 1
                    print("index print(index)",index)
                    
                    change_icon_style(pos:  index + changPos)
                    print("index + preposition",index + changPos)
                    load_details(pos: index + changPos)
                    cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
                    
                }
            }
            
        }
        
    }
    
    
    
    
    func change_icon_style(pos: Int){
        for i in 0..<QuestionData!.count{
            print("pos",pos)
            if pos == i{
                QuestionData![i].isSelect =  true
               
            }else{
                QuestionData![i].isSelect = false
                
            }
            
            
            
            
            
        }
        
        
        
        
        
        cv.reloadData()
    }
    
    
    func load_details(pos: Int){
        print("load_details(po",pos)
        
    
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(pos, forKey: DefaultsKeys.lastUpdateList)
        
        
        let getData : UpdateDetailsData = QuestionData![pos]
        
        
        
        print("get(pos",pos)
        
        if pos == 0 {
            previousView.isHidden = true
            
        }else{
            previousView.isHidden = false
            
            preLbl.text = "PREVIOUS"
        }
        
        
        if pos == QuestionData!.count-1 {
            
            
            nextView.isHidden = true
        }else{
            nextView.isHidden = false
        }
        
        
        
        
        cv.reloadData()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return QuestionData!.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowIdent , for: indexPath) as! UpdateDetailCollectionViewCell
        
        if skipType == 2 {
            
          
            
            print("changPos111",changPos)
            
          
            let aa : UpdateDetailsData = QuestionData![changPos]
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                cell.desc.text = aa.update_description
                cell.name.text = aa.update_name
            }
            
            
            print("aa.update_name",aa.update_name)
            print("aa.update_description",aa.update_description)
            
            cell.downloadImg.sd_setImage(with: URL(string: aa.downloadable_image), placeholderImage: UIImage(named: ""))
            
            if aa.redirect_link == ""  || aa.redirect_link == nil{
            }else{
                
                let redirectGes  = RedirectUrl(target: self, action: #selector(redirectUrl))
                redirectGes.redirect_url = aa.redirect_link
                redirectGes.heading_name = aa.update_name
                cell.redirectView.addGestureRecognizer(redirectGes)
            }
        }else {
            
            let userDefaults = UserDefaults.standard
            print("QuestionData!.count",QuestionData!.count)
            print("QuestionData!.count-1",QuestionData!.count - 1)
            
            var countMinus = QuestionData!.count - 1
            changPos  = userDefaults.integer(forKey: DefaultsKeys.lastUpdateList)
            userDefaults.set(countMinus, forKey: DefaultsKeys.updateListCount)
            
            if countMinus == changPos {
                nextView.isHidden = true
                preLbl.text = "PREVIOUS"
                previousView.isHidden = false
                print("NO DATA")
            }else{
                print("REMAINING DATA")
            }
            
            print("QuestionData?.count",QuestionData?.count)
            print("changPoschangPos",changPos)
            
            print("skipType",skipType)
            
            
            let aa : UpdateDetailsData = QuestionData![changPos]
            cell.name.text = aa.update_name
            cell.desc.text = aa.update_description
            
            print("aa.update_name111",aa.update_name)
            print("aa.update_description11",aa.update_description)
            
            cell.downloadImg.sd_setImage(with: URL(string: aa.downloadable_image), placeholderImage: UIImage(named: ""))
            
            if aa.redirect_link == ""  || aa.redirect_link == nil{
                print("EMpty")
            }else{
                print("aa.update_name",aa.update_name)
                let redirectGes  = RedirectUrl(target: self, action: #selector(redirectUrl))
                redirectGes.redirect_url = aa.redirect_link
                redirectGes.heading_name = aa.update_name
                cell.redirectView.addGestureRecognizer(redirectGes)
            }
        }
        return cell
       
    }
    
    
    
    
    
    @IBAction func redirectUrl( ges : RedirectUrl ) {
        let vc  = UpdateDetailWebviewLoadViewController(nibName: nil, bundle: nil)
        vc.redirectUrl = ges.redirect_url
        vc.heading = ges.heading_name
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // return CGSize(width:
        
        return CGSize(width: 320, height: 520)
        
    }
    
    
    
    
}


class RedirectUrl : UITapGestureRecognizer {
    var redirect_url : String!
    var heading_name : String!
}
