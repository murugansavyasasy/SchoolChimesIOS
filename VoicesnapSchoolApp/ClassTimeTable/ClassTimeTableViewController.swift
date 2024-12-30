//
//  ClassTimeTableViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 27/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ObjectMapper

class ClassTimeTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var classLbl: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var actTimeLbl: UILabel!
    
    @IBOutlet weak var alerView: UIView!
    
    
    
    @IBOutlet weak var cv: UICollectionView!
    
    @IBOutlet weak var alertLbl: UILabel!
    
    
    
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var staLbl: UILabel!
    
    @IBOutlet weak var sunLbl: UILabel!
    
    @IBOutlet weak var friLbl: UILabel!
    @IBOutlet weak var thurLbl: UILabel!
    
    @IBOutlet weak var wedLbl: UILabel!
    
    @IBOutlet weak var tueLbl: UILabel!
    @IBOutlet weak var monLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var AdView: UIView!
    
    @IBOutlet weak var SunView: UIViewX!
    
    @IBOutlet weak var SatView: UIViewX!
    @IBOutlet weak var FriView: UIViewX!
    
    @IBOutlet weak var WedView: UIViewX!
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var ThurView: UIViewX!
    
    
    @IBOutlet weak var TueView: UIViewX!
    @IBOutlet weak var MonView: UIViewX!
    @IBOutlet weak var tv: UITableView!
    
    
    var getDaysPos : String = "1"
    
    let collectionviewRowIdentifier = "ClassTimeCollectionViewCell"
    let tableviewRowIdentifier = "ClassTimeTableViewCell"
    
    var daysArray : [String] = []
    
    var getTimeTableDatas : [ClassTimeTableData] = []
    weak var timer: Timer?
    var AdName : String  = ""
    var imageCount : Int  = 0
    var firstImage : Int  = 0
    var imgaeURl : String  = ""
    var SchoolId  = String()
    var StaffId  = String()
    var ChildId  = String()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var menuId : String!
    
    var getadID : Int!
    var categories : [Category] =
    [
        
        Category(id: "1", selected: true, title: "Mon",type: .MON ),
        Category(id: "2", selected: false, title: "Tue",type: .TUE),
        Category(id: "3", selected: false, title: "Wed", type: .WED),
        Category(id: "4", selected: false, title: "Thurs", type: .THUR),
        Category(id: "5", selected: false, title: "Fri" ,type: .FRI),
        Category(id: "6", selected: false, title: "Sat", type: .SAT),
        Category(id: "7", selected: false, title: "Sun",type: .SUN),
        
    ]
    
    var xOffset:CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actTimeLbl.text = commonStringNames.ClassTimetable.translated()
        monLbl.text = commonStringNames.Monday.translated()
        tueLbl.text = commonStringNames.Tuesday.translated()
        wedLbl.text = commonStringNames.Wednesday.translated()
        thurLbl.text = commonStringNames.Thursday.translated()
        friLbl.text = commonStringNames.Friday.translated()
        staLbl.text = commonStringNames.Saturday.translated()
        sunLbl.text = commonStringNames.Sunday.translated()
        
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        
        SchoolId = String(describing: appDelegate.SchoolDetailDictionary["SchoolID"]!)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        
        scrollView.contentSize = CGSize(width: 1700, height: scrollView.frame.height)
        
        tv.delegate = self
        tv.dataSource = self
        
        let tvRowNib = UINib(nibName: tableviewRowIdentifier, bundle: nil)
        tv.register(tvRowNib, forCellReuseIdentifier: tableviewRowIdentifier)
        getTimeTable()
        
        
        
        alerView.isHidden = true
        alertLbl.isHidden = true
        
        
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
                    
                    
                }
                
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        let imgTap = AdGesture (target: self, action: #selector(viewTapped))
        AdView.addGestureRecognizer(imgTap)
        
        
        
        
        
        
        
        
        let mondayGesture = UITapGestureRecognizer(target: self, action: #selector(MondaysChoose))
        MonView.addGestureRecognizer(mondayGesture)
        
        let tuesdayGesture = UITapGestureRecognizer(target: self, action: #selector(tuesdaysChoose))
        TueView.addGestureRecognizer(tuesdayGesture)
        let wednesdayGesture = UITapGestureRecognizer(target: self, action: #selector(wednesdaysChoose))
        WedView.addGestureRecognizer(wednesdayGesture)
        let thursdayGesture = UITapGestureRecognizer(target: self, action: #selector(thursdaysChoose))
        ThurView.addGestureRecognizer(thursdayGesture)
        let fridayGesture = UITapGestureRecognizer(target: self, action: #selector(fridaysChoose))
        FriView.addGestureRecognizer(fridayGesture)
        let saturdayGesture = UITapGestureRecognizer(target: self, action: #selector(saturdaysChoose))
        SatView.addGestureRecognizer(saturdayGesture)
        let sundayGesture = UITapGestureRecognizer(target: self, action: #selector(sundaysChoose))
        SunView.addGestureRecognizer(sundayGesture)
        //
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        
    }
    
    
    
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
    func stopTimer() {
        print("Stopped timer")
        timer?.invalidate()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    
    
    func startTimer() {
        
        if AdConstant.adDataList.count > 0 {
            
            let url : String =  AdConstant.adDataList[0].contentUrl!
            self.imgaeURl = AdConstant.adDataList[0].redirectUrl!
            self.AdName = AdConstant.adDataList[0].advertisementName!
            self.getadID = AdConstant.adDataList[0].id!
            self.imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
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
                
                self!.imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            }
        }else {
            AdView.isHidden = true
            adViewHeight.constant = 0
        }
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
    
    
    
    
    
    
    @IBAction func getTimeTable() {
        
        let classTimeTableModal = ClassTimeTableModal()
        var days =  "1"
        for i in daysArray {
            days = i
            
        }
        
        print("selected days",days)
        print("getDaysPos",getDaysPos)
        classTimeTableModal.SchoolId = Int(SchoolId)
        classTimeTableModal.ChildId = ChildId
        classTimeTableModal.DayId = days
        
        print("SchoolId",SchoolId)
        print("ChildId",ChildId)
        let classTimeTableModalStr = classTimeTableModal.toJSONString()
        
        ClassTimeTableRequest.call_request(param: classTimeTableModalStr!) {
            [self]   (res) in
            
            
            
            
            
            let classTimeTableRespose : ClassTimeTableRespose = Mapper<ClassTimeTableRespose>().map(JSONString: res)!
            
            
            if classTimeTableRespose.Status == 1 {
                
                getTimeTableDatas = classTimeTableRespose.data
                
                tv.dataSource = self
                tv.delegate = self
                tv.isHidden = false
                alerView.isHidden = true
                alertLbl.isHidden = true
                timeLbl.isHidden = false
                lineView.isHidden = false
                classLbl.isHidden = false
                tv.reloadData()
                
            }
            else {
                
                
                
                timeLbl.isHidden = true
                lineView.isHidden = true
                classLbl.isHidden = true
                alerView.isHidden = false
                alertLbl.isHidden = false
                alertLbl.text = classTimeTableRespose.Message
                tv.isHidden = true
                
                print(classTimeTableRespose.Message)
                
                
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 77)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTimeTableDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableviewRowIdentifier, for: indexPath) as! ClassTimeTableViewCell
        
        
        let getData  : ClassTimeTableData = getTimeTableDatas[indexPath.row]
        
        cell.NameLbl.text = getData.name
        cell.subNameLbl.text = getData.subjectName
        cell.durationLbl.text = getData.duration
        cell.fromTimeLbl.text = getData.fromTime
        cell.ToTimeLbl.text = getData.toTime
        
        
        
        
        
        return cell
    }
    
    
    
    
    
    @IBAction func MondaysChoose(){
        MonView.tag = 1
        if MonView.backgroundColor == .clear {
            MonView.backgroundColor = UIColor(named: "serach_color")
            //            monLbl.textColor = .white
            TueView.backgroundColor = .clear
            
            WedView.backgroundColor = .clear
            ThurView.backgroundColor = .clear
            FriView.backgroundColor = .clear
            SatView.backgroundColor = .clear
            SunView.backgroundColor = .clear
            staLbl.textColor = UIColor(named: "serach_color")
            tueLbl.textColor = UIColor(named: "serach_color")
            wedLbl.textColor = UIColor(named: "serach_color")
            thurLbl.textColor = UIColor(named: "serach_color")
            friLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = .white
            checkDays(day : "1")
        }
        else if MonView.backgroundColor == UIColor(named: "serach_color"){
            //            TueView.backgroundColor = UIColor(named: "serach_color")
            staLbl.textColor = UIColor(named: "serach_color")
            tueLbl.textColor = UIColor(named: "serach_color")
            wedLbl.textColor = UIColor(named: "serach_color")
            thurLbl.textColor = UIColor(named: "serach_color")
            friLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = .white
            
            checkDays(day : "1")
            
        }
        tv.reloadData()
        getTimeTable()
    }
    
    @IBAction  func tuesdaysChoose(){
        TueView.tag = 2
        if TueView.backgroundColor == .clear {
            TueView.backgroundColor = UIColor(named: "serach_color")
            MonView.backgroundColor = .clear
            tueLbl.textColor = .white
            WedView.backgroundColor = .clear
            ThurView.backgroundColor = .clear
            FriView.backgroundColor = .clear
            SatView.backgroundColor = .clear
            SunView.backgroundColor = .clear
            staLbl.textColor = UIColor(named: "serach_color")
            //            tueLbl.textColor = UIColor(named: "serach_color")
            wedLbl.textColor = UIColor(named: "serach_color")
            thurLbl.textColor = UIColor(named: "serach_color")
            friLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = UIColor(named: "serach_color")
            checkDays(day : "2")
            
        }
        else if TueView.backgroundColor == UIColor(named: "serach_color") {
            //
            tueLbl.textColor = .white
            
            checkDays(day : "2")
            
        }
        tv.reloadData()
        getTimeTable()
    }
    
    @IBAction  func wednesdaysChoose(){
        WedView.tag = 3
        if WedView.backgroundColor == .clear {
            WedView.backgroundColor = UIColor(named: "serach_color")
            //            wedLbl.textColor = .white
            wedLbl.textColor = .white
            staLbl.textColor = UIColor(named: "serach_color")
            tueLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = UIColor(named: "serach_color")
            thurLbl.textColor = UIColor(named: "serach_color")
            friLbl.textColor = UIColor(named: "serach_color")
            sunLbl.textColor = UIColor(named: "serach_color")
            
            MonView.backgroundColor = .clear
            TueView.backgroundColor = .clear
            ThurView.backgroundColor = .clear
            FriView.backgroundColor = .clear
            SatView.backgroundColor = .clear
            SunView.backgroundColor = .clear
            checkDays(day : "3")
            
        }
        else if WedView.backgroundColor == UIColor(named: "serach_color"){
            //            WedView.backgroundColor = .clear
            wedLbl.textColor = .white
            
            checkDays(day : "3")
            
        }
        tv.reloadData()
        getTimeTable()
    }
    
    @IBAction  func thursdaysChoose(){
        ThurView.tag = 4
        if ThurView.backgroundColor == .clear {
            ThurView.backgroundColor = UIColor(named: "serach_color")
            checkDays(day : "4")
            thurLbl.textColor = .white
            MonView.backgroundColor = .clear
            TueView.backgroundColor = .clear
            WedView.backgroundColor = .clear
            ThurView.backgroundColor =  UIColor(named: "serach_color")
            FriView.backgroundColor = .clear
            SatView.backgroundColor = .clear
            SunView.backgroundColor = .clear
            
            staLbl.textColor = UIColor(named: "serach_color")
            tueLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = UIColor(named: "serach_color")
            wedLbl.textColor = UIColor(named: "serach_color")
            friLbl.textColor = UIColor(named: "serach_color")
            sunLbl.textColor = UIColor(named: "serach_color")
            
            
        }
        else if ThurView.backgroundColor == UIColor(named: "serach_color") {
            
            checkDays(day : "4")
            
        }
        tv.reloadData()
        
        getTimeTable()
    }
    
    @IBAction  func fridaysChoose(){
        FriView.tag = 5
        if FriView.backgroundColor == .clear {
            FriView.backgroundColor = UIColor(named: "serach_color")
            checkDays(day : "5")
            friLbl.textColor = .white
            MonView.backgroundColor = .clear
            TueView.backgroundColor = .clear
            WedView.backgroundColor = .clear
            FriView.backgroundColor =  UIColor(named: "serach_color")
            ThurView.backgroundColor = .clear
            SatView.backgroundColor = .clear
            SunView.backgroundColor = .clear
            
            
            staLbl.textColor = UIColor(named: "serach_color")
            tueLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = UIColor(named: "serach_color")
            thurLbl.textColor = UIColor(named: "serach_color")
            wedLbl.textColor = UIColor(named: "serach_color")
            sunLbl.textColor = UIColor(named: "serach_color")
        }
        else if FriView.backgroundColor == UIColor(named: "serach_color") {
            
            checkDays(day : "5")
            
        }
        tv.reloadData()
        getTimeTable()
        
    }
    
    @IBAction  func saturdaysChoose(){
        SatView.tag = 6
        if SatView.backgroundColor == .clear {
            SatView.backgroundColor = UIColor(named: "serach_color")
            checkDays(day : "6")
            staLbl.textColor = .white
            MonView.backgroundColor = .clear
            TueView.backgroundColor = .clear
            WedView.backgroundColor = .clear
            SatView.backgroundColor =  UIColor(named: "serach_color")
            FriView.backgroundColor = .clear
            ThurView.backgroundColor = .clear
            SunView.backgroundColor = .clear
            
            
            wedLbl.textColor = UIColor(named: "serach_color")
            tueLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = UIColor(named: "serach_color")
            thurLbl.textColor = UIColor(named: "serach_color")
            friLbl.textColor = UIColor(named: "serach_color")
            sunLbl.textColor = UIColor(named: "serach_color")
            
        }
        else if SatView.backgroundColor == UIColor(named: "serach_color"){
            
            checkDays(day : "6")
            
        }
        tv.reloadData()
        getTimeTable()
    }
    
    
    
    func checkDays(day : String){
        
        let has_item = daysArray.contains(day)
        
        if has_item {
            let indexlist = daysArray.firstIndex(of: day)
            daysArray.remove(at : indexlist!)
           
        }
        else{
            daysArray.append(day)
        }
        
        
        
    }
    
    
    
    @IBAction  func sundaysChoose(){
        SunView.tag = 7
        if SunView.backgroundColor == .clear {
            SunView.backgroundColor = UIColor(named: "serach_color")
            checkDays(day : "7")
            sunLbl.textColor = .white
            MonView.backgroundColor = .clear
            TueView.backgroundColor = .clear
            WedView.backgroundColor = .clear
            SunView.backgroundColor =  UIColor(named: "serach_color")
            FriView.backgroundColor = .clear
            SatView.backgroundColor = .clear
            ThurView.backgroundColor = .clear
            
            
            
            staLbl.textColor = UIColor(named: "serach_color")
            tueLbl.textColor = UIColor(named: "serach_color")
            monLbl.textColor = UIColor(named: "serach_color")
            thurLbl.textColor = UIColor(named: "serach_color")
            friLbl.textColor = UIColor(named: "serach_color")
            wedLbl.textColor = UIColor(named: "serach_color")
            
        }
        else if SunView.backgroundColor == UIColor(named: "serach_color"){
            checkDays(day : "7")
            sunLbl.textColor = .white
            
            
        }
        getTimeTable()
    }
    
    
    
    
    @IBAction func okDismissBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
}


struct Category {
    
    enum ProductType {
        case MON, TUE, WED, THUR, FRI,SAT,SUN
    }
    
    var id : String!
    var selected : Bool!
    var title : String!
    
    var type : ProductType
    
}


