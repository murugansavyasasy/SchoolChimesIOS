//
//  StaffLessonPlanViewViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 09/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper
import DropDown
import LinearProgressBar


protocol TableviewDelegate: class {
    
    func viewLesson(_ upd: String)
}


class StaffLessonPlanViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,ClassBVCDelegate {
    
    
    
    
    weak var delegate: TableviewDelegate?
    
    
    
    func toastMessage(_ upd: String) {
        toasShow = upd
        let userDefaults = UserDefaults.standard
        UserDefaults.standard.set(SecID, forKey: DefaultsKeys.getSecId)
        print("toasShow",toasShow)
        allAction()
        
        view.makeToast(toasShow)
        
        //        }
        
    }
    
    
    
    var updateName: String!
    
    func updateValues(_ upd: String) {
        updateName = upd
        //        view.makeToast(updateName)
        print("up1",updateName)
    }
    
    
    
    
    
    
    
    @IBOutlet weak var tv2: UITableView!
    
    
    @IBOutlet weak var dropDownLbl: UILabel!
    
    @IBOutlet weak var dropDownView: UIView!
    
    
    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var search_bar: UISearchBar!
    
    @IBOutlet weak var completedView: UIViewX!
    @IBOutlet weak var inProgressView: UIViewX!
    
    @IBOutlet weak var allView: UIViewX!
    
    
    @IBOutlet weak var yetToStartView: UIViewX!
    
    var ViewLessonPlanViewData : [ViewLessonPlanForAppData] = []
    var clone_list : [ViewLessonPlanDataArray] = []
    var clickType : String!
    
    var ViewLessonPlanData : [ViewLessonPlanDataArray] = []
    var StaffId : String!
    var SchoolId : String!
    var SecID : String!
    var particularId : String!
    var indexPathss : Int!
    var indexPat : [Int] = []
    var indexPathsections : Int!
    
    let drop_down = DropDown()
    var rowIdentifier = "StaffViewTableViewCell"
    var rowIdentifierTwo = "StaffViewTableViewCell"
    var setPos : Int!
    var demoInt : Int!
    var valuePassArr = NSMutableArray()
    
    
    var  staffDisplayRole : String!
    var actionHandle : Int!
    
    var  toasShow : String!
    
    var onceUpdate : Int!
    
    
    var staffSelectView : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let userDefaults = UserDefaults.standard
        //        var secid = userDefaults.string(forKey: DefaultsKeys.getSecId)!
        UserDefaults.standard.set(SecID, forKey: DefaultsKeys.getSecId) //setObject
        //       
        
        staffDisplayRole = userDefaults.string(forKey: DefaultsKeys.staffDisplayRole)
        print("staffDisplayRole",staffDisplayRole)
        
        
        print("LessonPlanStaffId",StaffId)
        print("LessonPlanSchoolId",SchoolId)
        print("DidloadSecID",SecID)
        print("getvaluePassArr",valuePassArr)
        
        
        
        
        
        dropDownLbl.text = "ALL"
        allAction()
        
        tv.delegate = self
        tv.dataSource = self
        
        search_bar.delegate = self
        search_bar.placeholder = commonStringNames.Search.translated()
        if demoInt == 1 {
            
        }else{
            viewLessonPlan()
            
        }
        
        
        let BackGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(BackGesture)
        
        
        
        
        let dropDownGesture = UITapGestureRecognizer(target: self, action: #selector(dropdown))
        dropDownView.addGestureRecognizer(dropDownGesture)
        
        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier: rowIdentifier)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backVc() {
        
        dismiss(animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("11111")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        allAction()
        viewLessonPlan()
        tv.dataSource = self
        //        tv.reloadData()
        
        
        print("122333")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("34")
        //
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("343214")
        allAction()
        viewLessonPlan()
        tv.dataSource = self
        //        allAction()
    }
    
    
    override func viewWillLayoutSubviews() {
        print("343214")
    }
    
    
    override func viewDidLayoutSubviews() {
        print("343214")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("343214")
    }
    
    @IBAction func dropdown() {
        
        var plant_names : [String] = []
        
        var fieldData = [ "ALL","YET TO START","IN PROGRESS","COMPLETED"]
        
        
        fieldData.forEach { (field) in
            plant_names.append(field)
        }
        
        drop_down.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            dropDownLbl.text = item
            print(" gest.fieldLbl.text", dropDownLbl.text)
            
            
            if item == "ALL" {
                allAction()
            }else if item == "YET TO START" {
                yetToStartAction()
            }else if item == "IN PROGRESS" {
                inProgressAction()
            }else if item == "COMPLETED" {
                CompletedAction()
            }
            
            
            
        }
        
        drop_down.dataSource = plant_names
        drop_down.anchorView = dropDownView
        drop_down.bottomOffset = CGPoint(x: 0, y:(drop_down.anchorView?.plainView.bounds.height)!)
        drop_down.show()
        
    }
    
    
    
    @IBAction func allAction() {
        
        
        var arrem : [ViewLessonPlanDataArray] = []
        
        let param : [String : String] =
        [
            
            "section_subject_id" : SecID,
            "institute_id" : SchoolId,
            "user_id" : StaffId,
            "status_filter" : "0"
            
        ]
        
        print("param",param)
        
        ViewLessonPlanForAppRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let lessonPlan : ViewLessonPlanForAppResponse = Mapper<ViewLessonPlanForAppResponse>().map(JSONString: res)!
            
            if lessonPlan.status == 1 {
                viewEmpty.alpha = 0
                emptyLbl.alpha = 0
            }else{
                viewEmpty.alpha = 1
                emptyLbl.alpha = 1
            }
            
            ViewLessonPlanViewData = lessonPlan.viewLessonPlanForAppData
            
            print("arremViewLessonPlanViewData",ViewLessonPlanViewData)
            
            for lessonArr in  ViewLessonPlanViewData {
                ViewLessonPlanData = lessonArr.data_array
                arrem = lessonArr.data_array
                //            arrem.append(lessonArr.data_array)
            }
            
            print("arrem",arrem)
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
            
            print("ALLACTIONWork")
        }
        
    }
    
    
    @IBAction func yetToStartAction() {
        
        let param : [String : String] =
        [
            
            "section_subject_id" : SecID,
            "institute_id" : SchoolId,
            "user_id" : StaffId,
            "status_filter" : "1"
            
        ]
        
        print("param",param)
        
        ViewLessonPlanForAppRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let lessonPlan : ViewLessonPlanForAppResponse = Mapper<ViewLessonPlanForAppResponse>().map(JSONString: res)!
            
            
            
            ViewLessonPlanViewData = lessonPlan.viewLessonPlanForAppData
            
            
            if lessonPlan.status == 1 {
                viewEmpty.alpha = 0
                emptyLbl.alpha = 0
            }else{
                viewEmpty.alpha = 1
                emptyLbl.alpha = 1
            }
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
        }
        
    }
    
    
    
    @IBAction func CompletedAction() {
        
        let param : [String : String] =
        [
            
            "section_subject_id" : SecID,
            "institute_id" : SchoolId,
            "user_id" : StaffId,
            "status_filter" : "3"
            
        ]
        
        print("param",param)
        
        ViewLessonPlanForAppRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let lessonPlan : ViewLessonPlanForAppResponse = Mapper<ViewLessonPlanForAppResponse>().map(JSONString: res)!
            
            
            
            ViewLessonPlanViewData = lessonPlan.viewLessonPlanForAppData
            
            if lessonPlan.status == 1 {
                viewEmpty.alpha = 0
                emptyLbl.alpha = 0
            }else{
                viewEmpty.alpha = 1
                emptyLbl.alpha = 1
            }
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
        }
        
    }
    
    
    @IBAction func inProgressAction() {
        
        let param : [String : String] =
        [
            
            "section_subject_id" : SecID,
            "institute_id" : SchoolId,
            "user_id" : StaffId,
            "status_filter" : "2"
            
        ]
        
        print("param",param)
        
        ViewLessonPlanForAppRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let lessonPlan : ViewLessonPlanForAppResponse = Mapper<ViewLessonPlanForAppResponse>().map(JSONString: res)!
            
            
            
            ViewLessonPlanViewData = lessonPlan.viewLessonPlanForAppData
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
            
            if lessonPlan.status == 1 {
                viewEmpty.alpha = 0
                emptyLbl.alpha = 0
            }else{
                viewEmpty.alpha = 1
                emptyLbl.alpha = 1
            }
            
        }
    }
    
    
    func viewLessonPlan() {
        
        //        section_subject_id=80009&institute_id=5512&user_id= 10035655&status_filter=1
        let param : [String : String] =
        [
            
            "section_subject_id" : SecID,
            "institute_id" : SchoolId,
            "user_id" : StaffId,
            "status_filter" : "0"
            
        ]
        
        print("param",param)
        
        ViewLessonPlanForAppRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let lessonPlan : ViewLessonPlanForAppResponse = Mapper<ViewLessonPlanForAppResponse>().map(JSONString: res)!
            
            if lessonPlan.status == 1 {
                
                ViewLessonPlanViewData = lessonPlan.viewLessonPlanForAppData
                
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                viewEmpty.alpha = 0
                emptyLbl.alpha = 0
                
            }else{
                viewEmpty.alpha = 1
                emptyLbl.alpha = 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        print("COUNT",ViewLessonPlanViewData.count)
        return ViewLessonPlanViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier,for: indexPath) as! StaffViewTableViewCell
        
        //        delegate = self
        //        var param1 = allAction()
        
        delegate?.viewLesson("param1")
        cell.selectionStyle = .none
        
        
        cell.getVal = valuePassArr
        cell.demo = demoInt
        print("demoInt",demoInt)
        /*Yet to start  (status_filter - 1)
         In Progress  (status_filter - 2)
         Completed  (status_filter - 3)*/
        
        //        lessoncacel
        
        print("actionHandle",actionHandle)
        print("staffDisplayRole",staffDisplayRole)
        if staffDisplayRole == "Principal" {
            if actionHandle == 1 { // dynamic set 0 panni irukan
                
                
                
                cell.deleteView.isHidden = true
                cell.inProgressView.isUserInteractionEnabled = false
                cell.yetToStartView.isUserInteractionEnabled = false
                cell.completedView.isUserInteractionEnabled = false
                
            }
        }
        
        
        //
        let viewData : ViewLessonPlanForAppData = ViewLessonPlanViewData[indexPath.row]
        
        //        ViewLessonPlanData = viewData.data_array
        clone_list = viewData.data_array
        
        cell.demolesson = ViewLessonPlanData
        ViewLessonPlanData = viewData.data_array
        
        print("actionHaviewData.data_arrayndle",viewData.data_array)
        
        //        let height: CGFloat = 500
        //        let width: CGFloat = 180
        
        let colors:[UIColor] = [.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan,.red,.yellow,.orange,.black,.purple,.blue,.brown,.cyan]
        
        
        
        
        
        
        cell.ViewLessonPlanData = viewData.data_array
        
        
        
        print("CellviewData.data_array.count", viewData.status)
        
        //
        
        if viewData.status == 1{
            cell.yetToStartImg.image = UIImage(named: "StartGreen")
            cell.YettostartLbl.textColor = UIColor(named: "PlayGreen")
            
            cell.completedImg.image = UIImage(named: "completeGray")
            cell.InProgressLbl.textColor = .lightGray
            cell.YettostartLbl.textColor = UIColor(named: "PlayGreen")
            cell.inprogressLineView.backgroundColor = .lightGray
            cell.completedLineView.backgroundColor = .lightGray
            cell.CompletedLbl.textColor = .lightGray
            cell.inprogressImg.image = UIImage(named: "progrssGray")
            
        }else if viewData.status == 2{
            cell.yetToStartImg.image = UIImage(named: "StartGreen")
            cell.InProgressLbl.textColor = UIColor(named: "PlayGreen")
            cell.YettostartLbl.textColor = UIColor(named: "PlayGreen")
            cell.inprogressLineView.backgroundColor = UIColor(named: "PlayGreen")
            cell.inprogressImg.image = UIImage(named: "ProgressGreen")
            cell.CompletedLbl.textColor = .lightGray
            cell.completedLineView.backgroundColor = .lightGray
            cell.completedImg.image = UIImage(named: "completeGray")
            
            
        }else if viewData.status == 3{
            cell.yetToStartImg.image = UIImage(named: "StartGreen")
            cell.YettostartLbl.textColor = UIColor(named: "PlayGreen")
            cell.InProgressLbl.textColor = UIColor(named: "PlayGreen")
            cell.CompletedLbl.textColor = UIColor(named: "PlayGreen")
            cell.inprogressLineView.backgroundColor = UIColor(named: "PlayGreen")
            cell.inprogressImg.image = UIImage(named: "ProgressGreen")
            cell.completedLineView.backgroundColor = UIColor(named: "PlayGreen")
            cell.completedImg.image = UIImage(named: "CompleteGreen")
        }
        
        
        
        
        //        if cell.inProgressView.tag == 1 {
        //            clickType = ""
        let ClickViewTapGesture = DeleteLessonPlanValues(target: self, action: #selector(OnClickAction))
        ClickViewTapGesture.particularId =  viewData.particular_id
        ClickViewTapGesture.clickTyp = "In Progress"
        //
        cell.inProgressView.addGestureRecognizer(ClickViewTapGesture)
        
        //        if cell.completedView.tag == 2 {
        
        let completedViewTapGesture = DeleteLessonPlanValues(target: self, action: #selector(OnClickAction))
        completedViewTapGesture.particularId =  viewData.particular_id
        completedViewTapGesture.clickTyp = "Completed"
        ClickViewTapGesture.completedLineView =  cell.completedLineView
        ClickViewTapGesture.completedImg = cell.completedImg
        ClickViewTapGesture.inProgressView =  cell.inprogressLineView
        ClickViewTapGesture.inprogressImg = cell.inprogressImg
        cell.completedView.addGestureRecognizer(completedViewTapGesture)
        
        
        
        let yetToStartViewTapGesture = DeleteLessonPlanValues(target: self, action: #selector(OnClickAction))
        yetToStartViewTapGesture.particularId =  viewData.particular_id
        yetToStartViewTapGesture.clickTyp = "Yet to start"
        //
        cell.yetToStartView.addGestureRecognizer(yetToStartViewTapGesture)
        
        
        
        
        let viewTapGesture = DeleteLessonPlanValues(target: self, action: #selector(DeleteClick))
        viewTapGesture.setPosition = indexPath.row
        viewTapGesture.particularId =  viewData.particular_id
        cell.deleteView.addGestureRecognizer(viewTapGesture)
        
        
        
        let EditTapGesture = DeleteLessonPlanValues(target: self, action: #selector(EditVc))
        EditTapGesture.particularId =  viewData.particular_id
        EditTapGesture.setPosition =  indexPath.row
        cell.editView.addGestureRecognizer(EditTapGesture)
        
        return cell
        
    }
    
    
    
    @IBAction func EditVc(ges : DeleteLessonPlanValues) {
        let vc =  LessonEditViewController(nibName: nil, bundle: nil)
        vc.passParticularId = String(ges.particularId)
        vc.getPos = ges.setPosition
        vc.staffId = StaffId
        vc.schoolId = SchoolId
        vc.getsec = SecID
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    
    
    
    @IBAction func DeleteClick(ges : DeleteLessonPlanValues ) {
        
        
        
        _ = SweetAlert().showAlert(commonStringNames.Alert.translated(), subTitle: "Are you sure want to delete?", style: .none, buttonTitle: commonStringNames.Cancel.translated(), buttonColor: .gray,otherButtonTitle: commonStringNames.OK.translated(),otherButtonColor: .gray){ [self]
            (okClick) in
            if okClick{
                
                print("Cancel")
                
                
                
            }else{
                
                
                
                let lessonplandelete = LessonPlanDeleteModal()
                
                
                lessonplandelete.particular_id = String(ges.particularId)
                print("particularId",ges.particularId)
                
                lessonplandelete.userId =  SchoolId
                print("DeleteClickStaffId",StaffId)
                
                
                
                let lessonPlanDeleteStr = lessonplandelete.toJSONString()
                
                
                print("lessonPlanDeleteStr",lessonPlanDeleteStr!)
                
                LessonPlanDeleteRequest.call_request(param: lessonPlanDeleteStr!) {
                    
                    [self] (res) in
                    
                    let lessonPlanDeleteResponse : StudentReportResponse = Mapper<StudentReportResponse>().map(JSONString : res)!
                    
                    if lessonPlanDeleteResponse.status == 1 {
                        
                        ViewLessonPlanViewData.remove(at: ges.setPosition)
                        //                viewLessonPlan()
                        tv.dataSource = self
                        tv.delegate = self
                        tv.reloadData()
                    }
                    
                }
            }
            
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathss = indexPath.row
        indexPathsections = indexPath.section
        
        indexPat.append(indexPath.row)
        
    }
    
    
    @IBAction func OnClickAction(ges : DeleteLessonPlanValues ) {
        
        
        let onClickModal = OnClickModal()
        
        
        onClickModal.particular_id = String(ges.particularId)
        print("particularId",ges.particularId)
        
        onClickModal.user_id =  StaffId
        print("DeleteClickStaffId",StaffId)
        
        onClickModal.institute_id = SchoolId
        print("particularId",particularId)
        
        print("clickTypeclickType",ges.clickTyp)
        if ges.clickTyp == "Yet to start" {
            
            onClickModal.value = "Yet to start"
            
        }else if ges.clickTyp == "In Progress" {
            
            onClickModal.value = "In Progress"
            
        }
        else if ges.clickTyp == "Completed" {
            
            onClickModal.value = "Completed"
            
        }
        
        
        let onClickModalStr = onClickModal.toJSONString()
        
        
        print("onClickModalStr",onClickModalStr!)
        
        OnClickRequest.call_request(param: onClickModalStr!) {
            
            [self] (res) in
            
            
            
            
            let onclickRes : OnClickResponse = Mapper<OnClickResponse>().map(JSONString : res)!
            if ges.clickTyp == "Yet to start"{
                print("clickType56",ges.clickTyp)
                if onclickRes.status == 1 {
                    
                    print("clickType12",ges.clickTyp)
                    
                    viewLessonPlan()
                    
                    //
                    tv.reloadData()
                    tv.dataSource = self
                    tv.delegate = self
                    //
                    //                    tv.reloadData()
                }
                
                
            }else  if  ges.clickTyp == "In Progress" {
                
                print("clickType34",ges.clickTyp)
                if onclickRes.status == 1 {
                    
                    print("clickType12",ges.clickTyp)
                    viewLessonPlan()
                    tv.reloadData()
                    
                    //
                    tv.dataSource = self
                    tv.delegate = self
                    
                    
                }
            }else if ges.clickTyp == "Completed"{
                print("clickType56",ges.clickTyp)
                if onclickRes.status == 1 {
                    
                    print("clickType12",ges.clickTyp)
                    
                    viewLessonPlan()
                    
                    
                    tv.reloadData()
                    
                    tv.dataSource = self
                    tv.delegate = self
                    
                    
                }
            }
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let viewData : ViewLessonPlanForAppData = ViewLessonPlanViewData[indexPath.row]
        var a = viewData.data_array.count
        let b = a * 30
        var c = b  + 350
        print("heightForRowAt",c)
        return CGFloat(c)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filtered_list : [ViewLessonPlanDataArray] = Mapper<ViewLessonPlanDataArray>().mapArray(JSONString: clone_list.toJSONString()!)!
        
        if !searchText.isEmpty{
            ViewLessonPlanData = filtered_list.filter {
                
                $0.value.lowercased().contains(searchText.lowercased())
            }
            
        }else{
            ViewLessonPlanData = filtered_list
            print("pendingOrder")
        }
        
        if ViewLessonPlanData.count > 0{
            print ("searchListPendigCount",ViewLessonPlanData.count)
            viewEmpty.alpha = 0
            emptyLbl.alpha = 0
            //                tv.isHidden = false
            tv.alpha = 1
        }else{
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
        print(ViewLessonPlanData.count)
        tv.alpha = 1
        viewLessonPlan()
        self.tv.reloadData()
    }
    
    
}


class DeleteLessonPlanValues : UITapGestureRecognizer {
    var  clickTyp : String!
    var  particularId : Int!
    var  inprogressImg : UIImageView!
    var  completedLineView : UIView!
    var  completedImg : UIImageView!
    var setPosition : Int!
    var  completedView : UIView!
    var  inProgressView : UIView!
    var  yetStartView : UIView!
    
}
