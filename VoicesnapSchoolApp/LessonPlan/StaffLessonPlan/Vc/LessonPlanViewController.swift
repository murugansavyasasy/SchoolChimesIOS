//
//  LessonPlanViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 09/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper
import LinearProgressBar

class LessonPlanViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, TableviewDelegate,UISearchBarDelegate {
    func viewLesson(_ upd: String) {
        print("_____",upd)
    }
    
    @IBOutlet weak var emptyLbl: UILabel!
    
    @IBOutlet weak var viewEmpty: UIView!
    
    @IBOutlet weak var search_bar: UISearchBar!
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var backView: UIView!
    
    var getLessonPlanData : [GetLessonPlanStaffReportResponseData] = []
    var  clone_list : [GetLessonPlanStaffReportResponseData] = []
    
    let rowIdentifier = "StaffLessonTableViewCell"
    
    var StaffId : String!
    var SchoolId : String!
    
    
    var schoolType : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tv.dataSource = self
        tv.delegate = self
        
        
        viewEmpty.alpha = 0
        emptyLbl.alpha = 0
        
        search_bar.delegate = self
        
        
        
        
        if schoolType == "MultipleSchool" {
            
            print("LessonPlanStaffId",StaffId)
            print("LessonPlanSchoolId",SchoolId)
            
        }else{
            let userDefaults = UserDefaults.standard
            StaffId = userDefaults.string(forKey: DefaultsKeys.StaffID)
            SchoolId = userDefaults.string(forKey: DefaultsKeys.SchoolD)!
        }
        print("LessonPlanStaffId",StaffId)
        print("LessonPlanSchoolId",SchoolId)
        getLessonDetails()
        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier: rowIdentifier)
        
        
        
        print("LIVE_DOMAIN",LIVE_DOMAIN)
        let BackGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(BackGesture)
        
        
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getLessonPlanData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier,for:  indexPath)as! StaffLessonTableViewCell
        
        
        let planData : GetLessonPlanStaffReportResponseData = getLessonPlanData[indexPath.row]
        cell.selectionStyle = .none
        
        cell.subjectNameLbl.text = planData.subjectName
        cell.classNameLbl.text = planData.className + "-" + planData.sectionName
        
        cell.staffNameLbl.text = planData.staffName
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
        
        cell.percentageValueShow.frame = CGRect(x:c + 25 ,y:+37,width:70,height:15)//        CGRect(x:cell.linProgressView.progressValue + 124,y:cell.linProgressView.progressValue - 40,width:70,height:15)
        
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
        }
        
        
        
        
        return cell
        
        
        
        
    }
    
    
    
    
    
    
    @IBAction func ViewClick(ges : LessonPlanValues) {
        let vc = StaffLessonPlanViewViewController(nibName: nil, bundle: nil)
        vc.SecID = ges.secId
        vc.delegate = self
        vc.staffSelectView = 1
        vc.StaffId = StaffId
        vc.SchoolId = SchoolId
        //        let user
        //        vc.particularId = ges.particularId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func backVc() {
        
        dismiss(animated: true)
    }
    
    func getLessonDetails() {
        
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
            
            
            if lessonPlan.status ==  1 {
                
                
                getLessonPlanData = lessonPlan.getLessonPlanStaffReportData
                clone_list =  lessonPlan.getLessonPlanStaffReportData
                viewEmpty.alpha = 0
                emptyLbl.alpha = 0
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
            }else{
                viewEmpty.alpha = 1
                emptyLbl.alpha = 1
                emptyLbl.text = lessonPlan.message
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let planData : GetLessonPlanStaffReportResponseData = getLessonPlanData[indexPath.row]
        if planData.itemsCompleted == "0 / 0" {
            return 290
        }
        return 330
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
            //                tv.isHidden = false
            tv.alpha = 1
        }else{
            emptyLbl.text = "no records found"
            viewEmpty.alpha = 1
            emptyLbl.alpha = 1
            tv.alpha = 0
        }
        
        tv.reloadData()
        //        }
        
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
    
    
    
    
}


class LessonPlanValues : UITapGestureRecognizer {
    var  secId : String = ""
    var  particularId : String = ""
    
}
