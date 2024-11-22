//
//  LsrwListShowViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/20/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import PhotosUI
import Alamofire
import ObjectMapper

enum UploadResult {
case success(String)
case failure(Error)
}

class LsrwListShowViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
  
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var tv: UITableView!
    var currentImageCount = 0
    var originalImagesArray = [UIImage]()
    var imageUrlArray = NSMutableArray()
    var  getImagePdfType : String!
    var convertedImagesUrlArray = NSMutableArray()
    var pdfData : Data? = nil
    
    var selectedImages: [UIImage] = []
    var authToken = "8d74d8bf6b5742d39971cc7d3ffbb51a"
    var videoEmbdUrl : String!
    var iframeLink : String!
    var videoSucessId = 0
  
    var imageStr : [String] = []
    var totalImageCount = 0
    var onImagesPicked: (([UIImage]) -> Void)?

    var onPdfPicked: ((Data) -> Void)?
    var onImagePicked: (([UIImage]) -> Void)?
    var viewSkillDatas : [ViewAllSkillByData] = []
    var clone_list : [ViewAllSkillByData] = []
    var rowIdentifier = "LsrwListShowTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        
        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier: rowIdentifier)
        
        
        viewAllSkillByStudent()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    

    
    
    


    // Delegate method to handle selected items

   
   
                   
          
 


    
    
    @IBAction func takeReadingSkill() {
        let vc = LSRWTakingSkillViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:   true)
    }

    
    
    
    
    
    func viewAllSkillByStudent(){
        
        
        
        
        let viewAllSkillByStudentModal = ViewAllSkillByStudentModal()
        viewAllSkillByStudentModal.StudentID = "10391374"
        viewAllSkillByStudentModal.SchoolID = "7050"
        
        
        var  viewAllSkillByStudentModalStr = viewAllSkillByStudentModal.toJSONString()
      
        
        ViewAllSkillByStudentRequest.call_request(param: viewAllSkillByStudentModalStr!) {
            
            [self] (res) in
            
            let viewAllSkillByStudentResp : ViewAllSkillByStudentResponse = Mapper<ViewAllSkillByStudentResponse>().map(JSONString: res)!
            
            if viewAllSkillByStudentResp.Status == 1 {
                viewSkillDatas = viewAllSkillByStudentResp.viewAllSkillByData
                clone_list  = viewAllSkillByStudentResp.viewAllSkillByData
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
            }
            
            
        }
        
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewSkillDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! LsrwListShowTableViewCell
        
        
        let skillData : ViewAllSkillByData = viewSkillDatas[indexPath.row]
        cell.descLbl.text = ": " + skillData.Description
        cell.sentByLbl.text = ": " + skillData.SentBy
        cell.subLbl.text = ": " + skillData.subject
        cell.titleLbl.text =  ": " + skillData.Title
        cell.submittedOnLbl.text = ": " + skillData.SubmittedOn
        
        if skillData.Issubmitted == "1" {
            cell.takingSkillView.isHidden = true
            cell.submittedOnLbl.isHidden = false
            cell.submittedHeadingLbl.isHidden = false
            
        }else{
            cell.takingSkillView.isHidden = false
            cell.typeLbl.text = skillData.ActivityType
            cell.submittedOnLbl.isHidden = true
            cell.submittedHeadingLbl.isHidden = true
//            cell.takingSkillBtn.setTitle(skillData.ActivityType, for: .normal)
        }
        
        
        let attachGes = LsrwListShowGesture(target: self, action: #selector(AttachmentRedirect))
        attachGes.getSkillId = String(skillData.SkillId)
        cell.takingSkillView.addGestureRecognizer(attachGes)

        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    @IBAction func AttachmentRedirect(ges : LsrwListShowGesture) {
        
        
        let vc = LSRWTakingSkillViewController(nibName: nil, bundle: nil)
        vc.skillId = ges.getSkillId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filtered_list : [ViewAllSkillByData] = Mapper<ViewAllSkillByData>().mapArray(JSONString: clone_list.toJSONString()!)!
        
        if !searchText.isEmpty{
            viewSkillDatas = filtered_list.filter { $0.Description.lowercased().contains(searchText.lowercased()) ||
                $0.Title.lowercased().contains(searchText.lowercased()) ||
                $0.subject.lowercased().contains(searchText.lowercased()) ||
                $0.SubmittedOn.lowercased().contains(searchText.lowercased())
            }
            
            
        }else{
            viewSkillDatas = filtered_list
            print("pendingOrder")
        }
        
        if viewSkillDatas.count > 0{
            print ("searchListPendigCount",viewSkillDatas.count)
            
        }else{
            
        }
        
        tv.reloadData()
        //        }
    }
    
}


class LsrwListShowGesture : UITapGestureRecognizer {
    var getSkillId : String!
}
