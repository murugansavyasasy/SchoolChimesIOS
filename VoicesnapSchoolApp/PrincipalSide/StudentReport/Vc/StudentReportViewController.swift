//
//  StudentReportViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/03/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper


class StudentReportViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var getAllStudHeadLbl: UILabel!
    @IBOutlet weak var selSecHeadLbl: UILabel!
    @IBOutlet weak var selStdHeadLbl: UILabel!
    @IBOutlet weak var actStudRepLbl: UILabel!
    
    @IBOutlet weak var alertLbl: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var selSecLbl: UILabel!
    @IBOutlet weak var getAllStudentTop: NSLayoutConstraint!
    @IBOutlet weak var selectStandardFullView: UIView!
    @IBOutlet weak var standardLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var selectSectionFullView: UIView!
    @IBOutlet weak var secFullView: UIView!
    @IBOutlet weak var getAllSectionView: UIView!
    @IBOutlet weak var PopupChooseStandardPickerView: UIView!
    @IBOutlet weak var pickerLbl: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var getAllStudentView: UIView!
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var backView: UIView!
    var schoolType : String!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var studentReportData : [StudentData] = []
    var clone_list : [StudentData] = []
    var GetStandardList : [GetAllStandardsAndGroupsList] = []
    var getSection : [SectionNameDataList] = []
    
    let rowIdentifier = "StudentReportTableViewCell"
    
    var SchoolDetailDict:NSDictionary = [String:Any]() as NSDictionary
    var StaffId : String!
    var SchoolId  = String()
    var popupChooseStandard : KLCPopup  = KLCPopup()
    var getClassID : Int!
    var getCountryId : String!
    var getSectionID : String = ""
    var standardGetType : String!
    var secStdType : String!
    var intialstandardType : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
        //        let userDefaults = UserDefaults.standard
        
        alertView.isHidden = true
        alertLbl.isHidden = true
        actStudRepLbl.text = commonStringNames.StudentReport.translated()
        selStdHeadLbl.text = commonStringNames.SelectStandard.translated()
        selSecHeadLbl.text = commonStringNames.studentReportSection
            .translated()
        selStdHeadLbl.text = commonStringNames.studentReportStandard.translated()
        
        
        
        intialstandardType = "1"
        getAllStudentTop.constant = -60
        
        pickerView.delegate = self
        pickerView.dataSource = self
        let userDefaults = UserDefaults.standard
        
        //        SchoolId = userDefaults.string(forKey: DefaultsKeys.SchoolD)!
        if schoolType == "1" {
            
            SchoolId = String(describing: SchoolDetailDict["SchoolID"]!)
            StaffId = String(describing: SchoolDetailDict["StaffID"]!)
        }else{
            SchoolId = userDefaults.string(forKey: DefaultsKeys.SchoolD)!
            StaffId = userDefaults.string(forKey: DefaultsKeys.StaffID)
        }
        print("DefaultsKeys.StaffID",StaffId)
        pickerView.isHidden = true
        PopupChooseStandardPickerView.isHidden = true
        pickerLbl.isUserInteractionEnabled = true
        secFullView.isHidden = true
        selSecLbl.isHidden = true
        getCountryId =  UserDefaults.standard.object(forKey: COUNTRY_ID) as! String
        print("getCountryIdvi",getCountryId)
        print("StaffIdvi",StaffId)
        
        
        //        self.performSegue(withIdentifier: "MainToSchoolSelectionSegue", sender: self)
        
        search_bar.delegate = self
        
        getDataList ()
        getStandardList ()
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVC))
        backView.addGestureRecognizer(backGesture)
        
        let dropDownGesture = UITapGestureRecognizer(target: self, action: #selector(pickerViewListDatas))
        viewDropDown.addGestureRecognizer(dropDownGesture)
        
        
        
        let lblGesture = UITapGestureRecognizer(target: self, action: #selector(LblGestStandard))
        lblGesture.numberOfTapsRequired = 1
        pickerLbl.addGestureRecognizer(lblGesture)
        
        let getStudentListGesture = UITapGestureRecognizer(target: self, action: #selector(getDataListEmptySend))
        getAllStudentView.addGestureRecognizer(getStudentListGesture)
        
        
        let getSectionListGesture = UITapGestureRecognizer(target: self, action: #selector(pickerViewListSection))
        getAllSectionView.addGestureRecognizer(getSectionListGesture)
        
        
        
        let getAllStudentListGesture = UITapGestureRecognizer(target: self, action: #selector(pickerViewListDatas))
        selectStandardFullView.addGestureRecognizer(getAllStudentListGesture)
        
        
        let getAllSectionListGesture = UITapGestureRecognizer(target: self, action: #selector(pickerViewListSection))
        secFullView.addGestureRecognizer(getAllSectionListGesture)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidePick))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    
    
    
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        pickerView.isHidden = true
        pickerLbl.isHidden = true
        PopupChooseStandardPickerView.isHidden = true
    }
    
    
    @IBAction func okAction(_ sender: UIButton) {
        
        
        getDataList ()
        pickerView.isHidden = true
        pickerLbl.isHidden = true
        PopupChooseStandardPickerView.isHidden = true
    }
    @IBAction func hidePick() {
        
        
        pickerView.isHidden = true
        PopupChooseStandardPickerView.isHidden = true
        pickerLbl.isHidden = true
        
    }
    @IBAction func LblGestStandard() {
        
        
        print("123")
        
        
        pickerView.isHidden = true
        pickerLbl.isHidden = true
        PopupChooseStandardPickerView.isHidden = true
        
        
        
    }
    
    @IBAction func pickerViewListSection() {
        
        pickerView.tag = 1
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerLbl.isHidden = false
        pickerView.isHidden = false
        PopupChooseStandardPickerView.isHidden = false
        
        alertView.isHidden = true
        alertLbl.isHidden = true
        
        
    }
    
    
    @IBAction func pickerViewListDatas() {
        pickerView.tag = 0
        pickerView.delegate = self
        pickerView.dataSource = self
        getStandardList ()
        pickerLbl.isHidden = false
        getAllStudentTop.constant = 15
        PopupChooseStandardPickerView.isHidden = false
        pickerView.isHidden = false
        
        alertView.isHidden = true
        alertLbl.isHidden = true
        print(pickerLbl.text)
        
        
        
        
        
        if pickerLbl.text != "Select Standard" {
            secFullView.isHidden = false
            selSecLbl.isHidden = false
            
        }else{
            secFullView.isHidden = true
            selSecLbl.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataList ()
    }
    @IBAction func backVC() {
        dismiss(animated: true)
    }
    
    
    
    @IBAction func getDataListEmptySend () {
        
        
        if (standardLbl.text!.count != 0) &&  (sectionLbl.text!.count != 0) {
            pickerView.backgroundColor = .clear
            PopupChooseStandardPickerView.isHidden = true
            pickerView.isHidden = true
        }
        let studentReportModal = StudentReportModal()
        
        
        studentReportModal.institute_id = SchoolId
        print("standardGetType",standardGetType)
        
        studentReportModal.class_id = ""
        studentReportModal.section_id = ""
        
        
        let studentReportModalStr = studentReportModal.toJSONString()
        
        
        print("studentReportModalStr",studentReportModalStr!)
        
        StudentReportRequest.call_request(param: studentReportModalStr!) {
            
            [self] (res) in
            
            
            
            
            let studentReportResponse : StudentReportResponse = Mapper<StudentReportResponse>().map(JSONString : res)!
            
            if studentReportResponse.status == 1 {
                
                
                
                
                studentReportData = studentReportResponse.studentData
                clone_list = studentReportResponse.studentData
                tv.dataSource = self
                tv.delegate = self
                tv.isHidden = false
                tv.reloadData()
                alertView.isHidden = true
                alertLbl.isHidden = true
                
            }else {
                
                //
                tv.isHidden = true
            }
            
        }
        
        
    }
    
    
    
    
    @IBAction func getDataList () {
        
        
        if (standardLbl.text!.count != 0) &&  (sectionLbl.text!.count != 0) {
            pickerView.backgroundColor = .clear
            PopupChooseStandardPickerView.isHidden = true
            pickerView.isHidden = true
        }
        let studentReportModal = StudentReportModal()
        
        
        studentReportModal.institute_id = SchoolId
        print("standardGetType",standardGetType)
        if  standardGetType == "1" {
            studentReportModal.class_id = String(getClassID)
            studentReportModal.section_id =  String(getSectionID)
        }else{
            studentReportModal.class_id = ""
            studentReportModal.section_id = ""
        }
        
        let studentReportModalStr = studentReportModal.toJSONString()
        
        
        print("studentReportModalStr",studentReportModalStr!)
        
        StudentReportRequest.call_request(param: studentReportModalStr!) {
            
            [self] (res) in
            
            
            
            
            let studentReportResponse : StudentReportResponse = Mapper<StudentReportResponse>().map(JSONString : res)!
            
            if studentReportResponse.status == 1 {
                
                
                studentReportData = studentReportResponse.studentData
                clone_list = studentReportResponse.studentData
                tv.isHidden = false
                tv.dataSource = self
                tv.delegate = self
                alertView.isHidden = true
                alertLbl.isHidden = true
                tv.reloadData()
            }else {
                
                //
                alertLbl.text = studentReportResponse.message
                alertView.isHidden = false
                alertLbl.isHidden = false
                tv.isHidden = true
            }
            
        }
        
        
    }
    
    
    
    
    func getStandardList () {
        
        let GetAllStandardsAndGroupsModal = GetAllStandardsAndGroupsModal()
        
        GetAllStandardsAndGroupsModal.SchoolId = Int(SchoolId)
        GetAllStandardsAndGroupsModal.CountryID = Int(getCountryId)
        GetAllStandardsAndGroupsModal.StaffID = Int(StaffId)
        
        print("GetAllStandardsAndGroupsModal.CountryID",getCountryId)
        print("GetAllStandardsAndGroupsModal.StaffID",StaffId)
        print("GetAllStandardsAndGroupsModal.SchoolId",SchoolId)
        
        let GetAllStandardsAndGroupsModalStr = GetAllStandardsAndGroupsModal.toJSONString()
        
        
        print("GetAllStandardsAndGroupsModalStr",GetAllStandardsAndGroupsModalStr!)
        
        GetAllStandardsAndGroupsRequest.call_request(param: GetAllStandardsAndGroupsModalStr!) {
            
            [self] (res) in
            
            
            let GetAllStandardsAndGroupsResponse : [GetAllStandardsAndGroupsList] = Mapper<GetAllStandardsAndGroupsList>().mapArray(JSONString : res)!
            
            GetStandardList = GetAllStandardsAndGroupsResponse
            
            for i in GetStandardList {
                
                
            }
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
        }
        
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
        if pickerView.tag == 0 {
            
            print("GetStandardList.count",GetStandardList.count)
            return GetStandardList.count
            
            
        }else {
            print("GetgetSection.countt",getSection.count)
            return getSection.count
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView.tag == 0 {
            
            let stad : GetAllStandardsAndGroupsList = GetStandardList[row]
            print("stad.Standard",stad.Standard)
            print("stad.Standard",stad.StandardId)
            stad.StandardId
            pickerLbl.text = "Select Standard"
            
            getSection = stad.SectionNameData
            standardLbl.text = stad.Standard
            return stad.Standard
            
        }else {
            let sec : SectionNameDataList = getSection[row]
            pickerLbl.text = "Select Section "
            print("didSelectstad.getSection.count",sec.SectionName)
            sectionLbl.text = sec.SectionName
            return sec.SectionName
        }
        
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView.tag == 0 {
            pickerLbl.text = "Select Standard"
            let stad : GetAllStandardsAndGroupsList = GetStandardList[row]
            standardLbl.text = stad.Standard
            
            
            standardGetType = "1"
            getClassID = stad.StandardId
            print("didSelectstad.getClassID",stad.StandardId)
            print("didSelectstad.Standard",stad.Standard)
            
            
        }else  {
            let sec : SectionNameDataList = getSection[row]
            secStdType = "1"
            sectionLbl.text = sec.SectionName
            getSectionID = String(sec.SectionId)
            print("didSelectstad.getSection.count",sec.SectionName)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentReportData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! StudentReportTableViewCell
        
        
        
        let studentReport : StudentData = studentReportData[indexPath.row]
        cell.studentNameLbl.text = studentReport.studentName
        cell.classsNameLbl.text = studentReport.className
        cell.sectionNameLbl.text = studentReport.sectionName
        cell.admissionLbl.text = studentReport.admissionNo
        cell.genderLbl.text = studentReport.gender
        cell.dobLbl.text = studentReport.dob
        cell.mobileNoLbl.text = studentReport.primaryMobile
        cell.classTeacherLbl.text = studentReport.classTeacher
        cell.fatherNameLbl.text = studentReport.fatherName
        
        let call_gesture = CallGesture(target: self, action: #selector(call_url))
        call_gesture.Number = studentReport.primaryMobile
        print("studentReport.primaryMobile",studentReport.primaryMobile)
        cell.callView.addGestureRecognizer(call_gesture)
        
        let sms_gesture = CallGesture(target: self, action: #selector(sms))
        sms_gesture.Number = studentReport.primaryMobile
        cell.smsView.addGestureRecognizer(sms_gesture)
        
        return cell
    }
    
    @IBAction func call_url ( gest : CallGesture){
        
        
        guard let number = URL(string: "tel://" + gest.Number) else { return }
        UIApplication.shared.open(number)
        print("phoneNumber",gest.Number!)
        
        
    }
    
    
    
    @IBAction func sms(gest : CallGesture) {
        let mPhoneNumber = gest.Number
        let mMessage = "%20";
        print("smsphoneNumber",mPhoneNumber)
        if let url = URL(string: "sms://" + mPhoneNumber! + "&body="+mMessage) {
            UIApplication.shared.open(url)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filtered_list : [StudentData] = Mapper<StudentData>().mapArray(JSONString: clone_list.toJSONString()!)!
        
        if !searchText.isEmpty{
            studentReportData = filtered_list.filter { $0.studentName.lowercased().contains(searchText.lowercased()) ||
                $0.className.lowercased().contains(searchText.lowercased()) ||
                $0.sectionName.lowercased().contains(searchText.lowercased()) ||
                $0.admissionNo.lowercased().contains(searchText.lowercased()) ||
                $0.primaryMobile.lowercased().contains(searchText.lowercased())
            }
            
            
        }else{
            studentReportData = filtered_list
            print("pendingOrder")
        }
        
        if studentReportData.count > 0{
            print ("searchListPendigCount",studentReportData.count)
            
        }else{
            
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}


class CallGesture : UITapGestureRecognizer {
    var Number : String!
}




