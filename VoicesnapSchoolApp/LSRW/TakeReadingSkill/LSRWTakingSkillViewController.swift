//
//  LSRWTakingSkillViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/20/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

import ObjectMapper
class LSRWTakingSkillViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    

    @IBOutlet weak var backView: UIView!
    
    
    
    
    @IBOutlet weak var tv: UITableView!
    var skillId : String!
    var attachData : [GetAttachmentForSkillData] = []
    let rowId = "TakeReadingSkillTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAllSkillByStudent()
        
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        
        
        tv.register(UINib(nibName: rowId, bundle: nil), forCellReuseIdentifier: rowId)

        // Do any additional setup after loading the view.
    }


    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        let vc = SubmitLsrwViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:   true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        attachData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowId, for: indexPath) as! TakeReadingSkillTableViewCell
        let getAttach : GetAttachmentForSkillData = attachData[indexPath.row]
        cell.typeLbl.text = ": " + getAttach.ActivityType
        cell.attachmentLbl.text = ": " + getAttach.Attachment
        
        let attachGes = AttachGesture(target: self, action: #selector(AttachmentRedirect))
        attachGes.attachment = getAttach.Attachment
        attachGes.getType = getAttach.ActivityType
        cell.viewAttac.addGestureRecognizer(attachGes)

        
        return cell
    }
    
    
    func viewAllSkillByStudent(){
        
        
        
        
        let getAttchStudentModal = GetAttachmentForSkillModal()
        getAttchStudentModal.StudentID = "10391374"
        getAttchStudentModal.SkillId = skillId
        
        
        var  getAttchStudentModalStr = getAttchStudentModal.toJSONString()
        
        
        GetAttachmentForSkillRequest.call_request(param: getAttchStudentModalStr!) {
            
            [self] (res) in
            
            let getAttachResp : GetAttachmentForSkillResponse = Mapper<GetAttachmentForSkillResponse>().map(JSONString: res)!
            
            if getAttachResp.Status == 1 {
                attachData = getAttachResp.getAttachData
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
            }
            
            
        }
        
    }
        
    @IBAction func AttachmentRedirect(ges : AttachGesture) {
            
            
            let vc = PreviewLsrwViewController(nibName: nil, bundle: nil)
        vc.attactText = ges.attachment
        vc.attactType = ges.getType
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


class AttachGesture : UITapGestureRecognizer {
    var getType : String!
    var attachment : String!
}
