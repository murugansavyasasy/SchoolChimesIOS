//
//  LessonEditViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper
import DropDown


protocol ClassBVCDelegate: class {
    
    func updateValues(_ upd: String)
    func toastMessage(_ upd: String)
}

class LessonEditViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var updateView: UIView!
    
    
    var getEditData : [ParticularDataEditData] = []
    var fieldData : [ParticularEditFieldData] = []
    var updateKeyValue : [UpdateKeyValueArray] = []
    var getValueArr : [String] = []
    var getFieldArr : [Int] = []
    var myDataset: [Int : String] = [:]
    let drop_down = DropDown()
    let arrResult = NSMutableArray()
    var call_back: ((NSMutableArray) -> Void)?
    var dropdowngetValueArr : [String] = []
    
    let rowIdentifier = "LessonEditTableViewCell"
    
    var passParticularId : String!
    var display_time : String!
    var display_hours : String!
    var display_minutes : String!
    var url_time : String!
    var url_hours : String!
    var url_minutes : String!
    var display_date : String!
    var url_date : String!
    var fieldVal : String!
    var fieldValStaus : String!
    var dropDownIdDisable : Int!
    var calendarDisable : Int!
    var EditTextDisable : Int!
    var statusDisable : Int!
    var getPos : Int!
    var getsec : String!
    var staffId : String!
    var schoolId : String!
    
    
    
    weak var delegate: ClassBVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("passParticularId",passParticularId)
        tv.dataSource = self
        tv.delegate = self
        print("getPos",getPos)
        
        
        
        
        
        call_back?(arrResult)
        getEditDetails()
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        closeView.addGestureRecognizer(backGesture)
        
        
        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier:  rowIdentifier)
        
        
    }
    
    
    
    
    
    
    @IBAction func backVc() {
        
        
        
        dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getEditData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath)as! LessonEditTableViewCell
        
        let getdata : ParticularDataEditData  = getEditData[indexPath.row]
        cell.selectionStyle = .none
        cell.textEdit.delegate = self
        cell.keyNameLbl.text = getdata.name
        print("getdata.name",getdata.name)
        cell.keyValueLbl.text = getdata.value
        print("getdata.value",getdata.value)
        cell.textEdit.isHidden = true
        
        
        //        If isdisable = 1 then don't allow to edit the field
        //        If isdisable = 0 then allow to edit the field
        print("getdata.isdisable",getdata.isdisable)
        
        
        if getdata.field_type == "datepicker" {
            print("inside.isdisable",getdata.isdisable)
            if getdata.isdisable == 0 {
                let dateGesture = DropDownDatePicker(target: self, action: #selector(datePickerSelect))
                dateGesture.dateLbl = cell.keyValueLbl
                cell.textEdit.isHidden = true
                cell.clickView.addGestureRecognizer(dateGesture)
            }
        }
        
        if getdata.name == "Status" {
            if getdata.field_type == "dropdown" {
                if getdata.isdisable == 0 {
                    let dropDownGesture = DropDownDatePicker(target: self, action: #selector(pickerViewListDatas1))
                    dropDownGesture.fieldLbl = cell.keyValueLbl
                    dropDownGesture.fieldView = cell.clickView
                    dropDownGesture.pos = indexPath.row
                    cell.textEdit.isHidden = true
                    cell.clickView.addGestureRecognizer(dropDownGesture)
                }
            }
            
        }else  if getdata.field_type == "dropdown" {
            if getdata.isdisable == 0 {
                let dropDownGesture = DropDownDatePicker(target: self, action: #selector(pickerViewListDatas))
                dropDownGesture.fieldLbl = cell.keyValueLbl
                dropDownGesture.fieldView = cell.clickView
                dropDownGesture.pos = indexPath.row
                cell.textEdit.isHidden = true
                cell.clickView.addGestureRecognizer(dropDownGesture)
            }
        }
        
        
        
        getValueArr.append(getdata.value)
        getFieldArr.append(getdata.field_id)
        
        
        
        print("demoArrdemoArr",getValueArr)
        print("getFieldArr",getFieldArr)
        
        
        
        
        var editPos : Int! 
        if getdata.field_type == "text" {
            if getdata.isdisable == 0 {
                cell.changeImg.isHidden = true
                cell.textEdit.isHidden = false
                cell.keyValueLbl.isHidden = true
                cell.clickView.isUserInteractionEnabled = true
                print("CellFor",cell.textEdit.text)
                cell.textEdit.text = getdata.value
                EditTextDisable = 1
                
                editPos = indexPath.row
                print("editPos = indexPath.row",editPos)
                
                
                
            }else if getdata.isdisable == 1 {
                cell.changeImg.isHidden = true
                cell.textEdit.isHidden = false
                cell.keyValueLbl.isHidden = true
                cell.clickView.isUserInteractionEnabled = true
                print("CellFor",cell.textEdit.text)
                cell.textEdit.text = getdata.value
                EditTextDisable = 0
                cell.textEdit.isUserInteractionEnabled = false
                
                
                
            }
        }
        
        
        print("getedEditTextDisable",EditTextDisable)
        
        let updateGesture = DropDownDatePicker(target: self, action: #selector(getLessonUpdate))
        updateGesture.getFieldId = getdata.field_id
        updateGesture.getValue = getdata.value
        updateGesture.EditTex = cell.textEdit
        DropDownDatePicker.editGet = cell.textEdit
        if EditTextDisable == 1{
            updateGesture.pos = editPos
            print("1geteditPos",editPos)
        }
        updateGesture.getFieldIdDisable = getdata.isdisable
        updateView.addGestureRecognizer(updateGesture)
        
        
        return cell
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func getEditTextAction( ges : DropDownDatePicker) {
        
        
        EditTextDisable = 1
        
        
        
        if ges.getFieldIdDisable == 0 {
            //            getValueArr.remove(at: gest.pos)
            getValueArr.insert(ges.EditTex.text!, at : ges.pos)
            dropdowngetValueArr = getValueArr
            print("dropdowngetValueArrtext",getValueArr)
            print("dropdowngetValueArr12text",dropdowngetValueArr)
        }else{
            dropdowngetValueArr = getValueArr
        }
        
        
    }
    
    func getEditDetails() {
        
        let param : [String : String] =
        [
            "particular_id" : passParticularId,
            "request_type" : "allclass",
            "institute_id" : schoolId,
            "user_id" : staffId
            
        ]
        
        
        ParticularDataEditRequest.call_request(param: param)  {
            
            [self] (res) in
            
            let editRes : ParticularDataEditRsponse = Mapper<ParticularDataEditRsponse>().map(JSONString: res)!
            
            getEditData = editRes.particularEditData
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
            var editdata : [ParticularDataEditData] = []
            editdata = editRes.particularEditData
            
            
            for field in editdata {
                
                fieldData = field.field_data
                print("fieldfieldData",fieldData.count)
            }
            print("AfterLop",fieldData.count)
            for i in editdata[0].field_data {
                fieldVal = i.value
                
            }
            
            for i in editdata[1].field_data {
                fieldValStaus = i.value
            }
            
            
        }
        
        
    }
    
    @objc func datePickerSelect( ges : DropDownDatePicker) {
        
        calendarDisable = 1
        
        
        RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (today_date) in
            
            self?.display_date = today_date.dateString("dd-M-yyyy")
            self?.url_date = today_date.dateString("yyyy-M-dd")
            ges.dateLbl.text = self!.display_date
            ges.dateLbl.textColor = .black
            
            
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    
    
    @IBAction func getLessonUpdate(ges : DropDownDatePicker) {
        
        
        print("myDataset",myDataset)
        
        
        if statusDisable == 1 || dropDownIdDisable == 1 || calendarDisable == 1 || EditTextDisable == 1 {
            
            if   EditTextDisable == 1 {
                print(" 1ges.pos", ges.pos)
                getValueArr.insert(ges.EditTex.text!, at : ges.pos)
                dropdowngetValueArr = getValueArr
                
            }
            //            dropdowngetValueArr.insert(ges.EditTex.text!, at: 3)
            for (index, element) in getFieldArr.enumerated() {
                myDataset[element] = dropdowngetValueArr[index]
            }
            
            for (id,rowID) in myDataset {
                print("\(id) = \(rowID)")
                
                var val : String!
                var rowval : String!
                val = String(id)
                rowval = rowID
                
                let keyValueModal = UpdateKeyValueArray()
                keyValueModal.value = String(rowval)
                keyValueModal.field_id = Int(val)
                
                updateKeyValue.append(keyValueModal)
                
            }
            
        }else {
            for (index, element) in getFieldArr.enumerated() {
                myDataset[element] = getValueArr[index]
            }
            
            for (id,rowID) in myDataset {
                print("\(id) = \(rowID)")
                
                var val : String!
                var rowval : String!
                val = String(id)
                rowval = rowID
                
                
                
                let keyValueModal = UpdateKeyValueArray()
                keyValueModal.value = String(rowval)
                keyValueModal.field_id = Int(val)
                
                updateKeyValue.append(keyValueModal)
                //
                
            }
            
        }
        
        
        let updateModal = LessonUpdateModal()
        
        
        updateModal.particular_id = Int(passParticularId)
        updateModal.keyValueArr = updateKeyValue
        updateModal.user_id = Int(staffId)
        updateModal.institute_id = Int(schoolId)
        
        
        
        
        
        let updateModalStr = updateModal.toJSONString()
        
        
        print("updateModalStr",updateModalStr!)
        
        LessonPlanUpdateRequest.call_request(param: updateModalStr!) {
            
            [self] (res) in
            
            
            
            
            let lessonUpdateModalRe : LessonUpdateModalResponse = Mapper<LessonUpdateModalResponse>().map(JSONString : res)!
            
            if lessonUpdateModalRe.status == 1 {
                
                
                
                
                //
                
                
                DropDownDatePicker.toastShowMesg = lessonUpdateModalRe.message
                handleTap()
                dismiss(animated: true)
                
                
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }
        }
        
        
        
    }
    
    
    @objc func handleTap() {
        
        
        delegate?.updateValues(DropDownDatePicker.editGet.text!)
        delegate?.toastMessage(DropDownDatePicker.toastShowMesg)
        print("12345678")
        dismiss(animated: true)
    }
    
    @IBAction func pickerViewListDatas(gest : DropDownDatePicker) {
        
        
        var plant_names : [String] = []
        //        print("dropDownWork")
        dropDownIdDisable = 1
        
        
        
        let getdata : ParticularDataEditData  = getEditData[0]
        
        fieldData =  getdata.field_data
        fieldData.forEach { (field) in
            plant_names.append(field.value)
        }
        
        drop_down.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            gest.fieldLbl.text = item
            print(" gest.fieldLbl.text", gest.fieldLbl.text)
            
            
            if getdata.isdisable == 0 {
                getValueArr.remove(at: gest.pos)
                getValueArr.insert(item, at : gest.pos)
                dropdowngetValueArr = getValueArr
                print("dropdowngetValueArr",getValueArr)
                print("dropdowngetValueArr12",dropdowngetValueArr)
            }else{
                dropdowngetValueArr = getValueArr
            }
        }
        
        drop_down.dataSource = plant_names
        drop_down.anchorView = gest.fieldView
        drop_down.bottomOffset = CGPoint(x: 0, y:(drop_down.anchorView?.plainView.bounds.height)!)
        drop_down.show()
        
    }
    
    
    
    @IBAction func pickerViewListDatas1(gest : DropDownDatePicker) {
        
        
        var plant_names : [String] = []
        //        print("dropDownWork")
        
        statusDisable = 1
        
        let getdata : ParticularDataEditData  = getEditData[1]
        
        fieldData =  getdata.field_data
        fieldData.forEach { (field) in
            plant_names.append(field.value)
        }
        
        drop_down.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            gest.fieldLbl.text = item
            if getdata.isdisable == 0 {
                getValueArr.remove(at: gest.pos)
                getValueArr.insert(item, at : gest.pos)
                
                dropdowngetValueArr = getValueArr
                print("dropdowngetValueArr",getValueArr)
                print("dropdowngetValueArr12",dropdowngetValueArr)
            }else{
                dropdowngetValueArr = getValueArr
            }
        }
        
        drop_down.dataSource = plant_names
        drop_down.anchorView = gest.fieldView
        drop_down.bottomOffset = CGPoint(x: 0, y:(drop_down.anchorView?.plainView.bounds.height)!)
        drop_down.show()
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
    }
    
}



class DropDownDatePicker : UITapGestureRecognizer {
    
    var dateLbl : UILabel!
    var getValue : String!
    var getFieldId : Int!
    var fieldLbl : UILabel!
    var fieldView : UIView!
    var pos : Int!
    var EditTex : UITextField!
    static var editGet : UITextField!
    var getFieldIdDisable : Int!
    static  var toastShowMesg : String!
}




