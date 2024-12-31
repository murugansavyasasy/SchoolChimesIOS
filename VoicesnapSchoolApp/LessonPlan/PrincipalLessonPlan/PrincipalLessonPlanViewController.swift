//
//  PrincipalLessonPlanViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper


class PrincipalLessonPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, TableviewDelegate {
    func viewLesson(_ upd: String) {
        print("viewupd",upd)
    }
    
    @IBOutlet weak var actLsnPlnLbl: UILabel!
    
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var search_bar: UISearchBar!
    
    @IBOutlet weak var allClassBtn: UIButton!
    
    @IBOutlet weak var emptyLbl: UILabel!
    
    @IBOutlet weak var classHandleBtn: UIButton!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var tv: UITableView!
    
    
    
    var allcls : Int!
    var getLessonPlanData : [GetLessonPlanStaffReportResponseData] = []
    var  clone_list : [GetLessonPlanStaffReportResponseData] = []
    
    let rowIdentifier = "StaffLessonTableViewCell"
    
    var StaffId : String!
    var SchoolId : String!
    var schoolType : String!
    
    var SchoolDetailDict:NSDictionary = [String:Any]() as NSDictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv.dataSource = self
        tv.delegate = self
        search_bar.placeholder = commonStringNames.Search.translated()
        classHandleBtn.setTitle(commonStringNames.ClassesYouHandle.translated(), for: .normal)
        actLsnPlnLbl.text = commonStringNames.LessonPlan.translated()
        allClassBtn.setTitle(commonStringNames.AllClasses.translated(), for: .normal)
        search_bar.delegate = self
        search_bar.placeholder = commonStringNames.Search.translated()
        viewEmpty.alpha = 0
        emptyLbl.alpha = 0
        allClassBtn.layer.borderColor = UIColor.red.cgColor
        allClassBtn.layer.borderWidth = 1
        classHandleBtn.layer.borderColor = UIColor.gray.cgColor
        classHandleBtn.layer.borderWidth = 1
        
        allClassBtn.layer.cornerRadius = 4.0
        allcls = 1
        
        let userDefaults = UserDefaults.standard
        
        
        if schoolType == "1" {
            
            SchoolId = String(describing: SchoolDetailDict["SchoolID"]!)
            StaffId = String(describing: SchoolDetailDict["StaffID"]!)
        }else{
            SchoolId = userDefaults.string(forKey: DefaultsKeys.SchoolD)!
            StaffId = userDefaults.string(forKey: DefaultsKeys.StaffID)
        }
        
        
        var  staffDisplayRole = userDefaults.string(forKey: DefaultsKeys.staffDisplayRole)
        print("staffDisplayRole",staffDisplayRole)
        
        
        print("LessonPlanStaffId",StaffId)
        print("LessonPlanSchoolId",SchoolId)
        getLessonDetails()
        
        let BackGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        viewBack.addGestureRecognizer(BackGesture)
        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier: rowIdentifier)
        
        
    }
    
    
    
    @IBAction func backVc() {
        
        dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getLessonPlanData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier,for:  indexPath)as! StaffLessonTableViewCell
        
        
        let planData : GetLessonPlanStaffReportResponseData = getLessonPlanData[indexPath.row]
        
        cell.selectionStyle = .none
        
        
        cell.classNameLbl.text = planData.className + "-" + planData.sectionName
        
        cell.staffNameLbl.text = planData.staffName
        cell.subjectNameLbl.text = planData.subjectName
        cell.totalItemLbl.text = "100" + "%"
        cell.completedItemLbl.text = String(planData.itemsCompleted)
        
        var prValue : Int = planData.percentage_value
        cell.linProgressView.progressValue = CGFloat(prValue)
        cell.linProgressView.barColor = UIColor(named: "LessonGreen")!
        
        var a : Int!
        var c : Int!
        a = 3
        c = a * prValue
        print("cValue", c)
        
        cell.percentageValueShow.frame = CGRect(x:c + 25 ,y:+37,width:70,height:15)
        print("barColorForValue",cell.linProgressView.barColorValue)
        let viewTapGesture = LessonPlanValues(target: self, action: #selector(ViewClick))
        viewTapGesture.secId = String(planData.section_subject_id)
        cell.OverAllview.addGestureRecognizer(viewTapGesture)
        
        if planData.percentage_value  == 0 {
            cell.percentageValueShow.isHidden = true
        }else{
            cell.percentageValueShow.isHidden = false
            cell.percentageValueShow.text = String(planData.percentage_value) + "%"
        }
        
        
        
        if planData.itemsCompleted  == "0 / 0" {
            cell.OverAllview.isHidden = true
        }else{
            cell.OverAllview.isHidden = false
            //                tv.rowHeight = 330
        }
        
        
        return cell
        
        
    }
    
    
    @IBAction func ViewClick(ges : LessonPlanValues) {
        
        //
        let vc = StaffLessonPlanViewViewController(nibName: nil, bundle: nil)
        vc.SecID = ges.secId
        vc.actionHandle = allcls
        vc.StaffId = StaffId
        vc.SchoolId = SchoolId
        vc.delegate = self
        let defaults = UserDefaults.standard
        defaults.set(ges.secId, forKey: DefaultsKeys.LessonSecId)
        defaults.set(SchoolId, forKey: DefaultsKeys.LessonSchoolId)
        defaults.set(StaffId, forKey: DefaultsKeys.LessonStafflId)
        print("Goto StaffLessonPlanViewViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    func getLessonDetails() {
        
        let param : [String : String] =
        [
            
            "request_type" : "allclass",
            "institute_id" : SchoolId,
            "user_id" : StaffId
            
        ]
        
        print("LessonParam",param)
        
        getLessonPlanStaffReportRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let lessonPlan : getLessonPlanStaffReportResponse = Mapper<getLessonPlanStaffReportResponse>().map(JSONString: res)!
            
            if lessonPlan.status == 1 {
                tv.isHidden = false
                getLessonPlanData = lessonPlan.getLessonPlanStaffReportData
                clone_list = lessonPlan.getLessonPlanStaffReportData
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }else{
                tv.isHidden = true
                let alert = UIAlertController(title: "Alert", message: lessonPlan.message, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
            
        }
        
    }
    
    
    
    func getLessonClassesHandle() {
        
        let param : [String : String] =
        [
            
            "request_type" : "myclass",
            "institute_id" : SchoolId,
            "user_id" : StaffId
            
        ]
        
        print("LessonParam",param)
        
        getLessonPlanStaffReportRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let lessonPlan : getLessonPlanStaffReportResponse = Mapper<getLessonPlanStaffReportResponse>().map(JSONString: res)!
            
            if lessonPlan.status == 1 {
                tv.isHidden = false
                getLessonPlanData = lessonPlan.getLessonPlanStaffReportData
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }else{
                let alert = UIAlertController(title: "Alert", message: lessonPlan.message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion:{
                    //
                    
                    
                    
                    
                    alert.view.superview?.isUserInteractionEnabled = true
                    alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
                })
            }
            tv.isHidden = true
            //
            
        }
        
    }
    
    
    
    
    
    
    
    
    @IBAction func alertControllerBackgroundTapped()
    {
        dismiss(animated: true)
    }
    
    
    
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let planData : GetLessonPlanStaffReportResponseData = getLessonPlanData[indexPath.row]
        if planData.itemsCompleted == "0 / 0" {
            return 290
        }
        return 330
    }
    
    
    
    
    @IBAction func classHandleAction(_ sender: Any) {
        
        classHandleBtn.layer.borderColor = UIColor.red.cgColor
        classHandleBtn.layer.borderWidth = 1
        allClassBtn.layer.borderColor = UIColor.gray.cgColor
        allClassBtn.layer.borderWidth = 1
        
        
        classHandleBtn.layer.cornerRadius = 4.0
        getLessonClassesHandle()
    }
    
    
    
    @IBAction func allClassAction(_ sender: Any) {
        
        allClassBtn.layer.borderColor = UIColor.red.cgColor
        allClassBtn.layer.borderWidth = 1
        
        allcls = 1
        
        allClassBtn.layer.cornerRadius = 4.0
        classHandleBtn.layer.borderColor = UIColor.gray.cgColor
        classHandleBtn.layer.borderWidth = 1
        getLessonDetails()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filtered_list : [GetLessonPlanStaffReportResponseData] = Mapper<GetLessonPlanStaffReportResponseData>().mapArray(JSONString: clone_list.toJSONString()!)!
        
        if !searchText.isEmpty{
            getLessonPlanData = filtered_list.filter {
                
                $0.className.lowercased().contains(searchText.lowercased()) || $0.staffName.lowercased().contains(searchText.lowercased()) || $0.subjectName.lowercased().contains(searchText.lowercased()) ||  $0.sectionName.lowercased().contains(searchText.lowercased())
            }
            
        }else{
            getLessonPlanData = filtered_list
            print("pendingOrder")
        }
        
        if getLessonPlanData.count > 0{
            print ("searchListPendigCount",getLessonPlanData.count)
            viewEmpty.alpha = 0
            emptyLbl.alpha = 0
            tv.alpha = 1
        }else{
            emptyLbl.text = "no records found"
            viewEmpty.alpha = 1
            emptyLbl.alpha = 1
            tv.alpha = 0
        }
        
        tv.reloadData()
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        search_bar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search_bar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBar.resignFirstResponder()")
        
        searchBar.resignFirstResponder()
        print("searchBar.resignFirstResponder()")
        print(getLessonPlanData.count)
        tv.alpha = 1
        getLessonDetails()
        self.tv.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getLessonDetails()
        print("viewWillAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
    }
    
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransition")
    }
    
    
}
