//
//  QuizExamMenuViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 01/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ObjectMapper


class QuizExamMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var noRecordsLbl: UILabel!
    
    
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var search_bar: UISearchBar!
    
    
    @IBOutlet weak var segment_control: UISegmentedControl!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var adView: UIView!
    
    
    var sendStatusType : Int = 1
    var menuId : String!
    var imageCount : Int  = 0
    var firstImage : Int  = 0
    var imgaeURl : String  = ""
    weak var timer: Timer?
    var AdName : String  = ""
    
    var SchoolId  = String()
    var StaffId  = String()
    var ChildId  = String()
    var quizGetData : [QuizData] = []
    
    var clone_list : [QuizData] = []
    
    var getadID : Int!
    let rowIdentifier = "QuizUpcomingTableViewCell"
    
    let completedRowIdentifier = "QuizCompletedTableViewCell"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SchoolId = String(describing: appDelegate.SchoolDetailDictionary["SchoolID"]!)
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        
        noRecordsLbl.isHidden = true
        
        tv.dataSource = self
        tv.delegate = self
        
        search_bar.delegate = self
        
        
        getTimeTable()
        
        async {
            do {
                //                let posts = try await fetchData()
                //                print(posts)
                
                //                await AdConstant.AdRes(memId: ChildIDString, memType: "student", menu_id: AdConstant.getMenuId as String, school_id: SchoolId)
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
                    
                    
                    
                    //            var adDataList : [MenuData] = []
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
                    
                    
                    
                    //
                }
                
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        let imgTap = AdGesture (target: self, action: #selector(viewTapped))
        adView.addGestureRecognizer(imgTap)
        
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
        
        let compltedRowNib = UINib(nibName: completedRowIdentifier, bundle: nil)
        tv.register(compltedRowNib, forCellReuseIdentifier: completedRowIdentifier)
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
    }
    
    
    
    
    func stopTimer() {
        print("Stopped timer")
        timer?.invalidate()
    }
    @IBAction func backVc() {
        dismiss(animated: true)
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
            adView.isHidden = false
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
            adView.isHidden = true
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizGetData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if segment_control.selectedSegmentIndex == 0 {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! QuizUpcomingTableViewCell
            
            let quiz : QuizData = quizGetData[indexPath.row]
            
            cell.levelLbl.text = String(quiz.Level)
            cell.titleLbl.text = quiz.Title
            cell.subjectLbl.text = quiz.Subject
            cell.numberLbl.text = String(quiz.TotalNumberOfQuestions)
            cell.sentByLbl.text = quiz.SentBy
            cell.totalQuestionLbl.text = String(quiz.TotalNumberOfQuestions)
            cell.totalMarkLbl.text = quiz.totalMark
            cell.descLbl.text = quiz.Description
            
            
            //            if segment_control.selectedSegmentIndex == 0 {
            cell.getQuesLbl.text = "Get Question"
            
            let quizViewGesture = ViewReportGesture(target: self, action: #selector(GetQuestionView))
            quizViewGesture.id = String(quiz.QuizId)
            cell.getQuesView.addGestureRecognizer(quizViewGesture)
            
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: completedRowIdentifier, for: indexPath) as! QuizCompletedTableViewCell
            
            let quiz : QuizData = quizGetData[indexPath.row]
            
            cell.levelLbl.text = String(quiz.Level)
            cell.titleLbl.text = quiz.Title
            cell.subLbl.text = quiz.Subject
            cell.sentByLbl.text = quiz.SentBy
            cell.sentByLbl.text = quiz.SentBy
            cell.totalQuesLbl.text = String(quiz.TotalNumberOfQuestions)
            cell.totalMarkLbl.text = quiz.totalMark
            cell.descLbl.text = quiz.Description
            
            
            
            let quizViewGesture = ViewReportGesture(target: self, action: #selector(GotoQuizView))
            quizViewGesture.id = String(quiz.QuizId)
            cell.getQuesView.addGestureRecognizer(quizViewGesture)
            //                cell.getQuesLbl.text = "View"
            return cell
            
        }
    }
    
    //
    @IBAction func GotoQuizView( ges : ViewReportGesture) {
        
        
        
        let vc = QuizViewReportViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.quizId = ges.id
        present(vc, animated: true)
    }
    
    @IBAction func GetQuestionView(ges : ViewReportGesture) {
        
        
        
        let vc = QuizUpcomingGetQuestionViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.quizId = Int(ges.id)
        let defaults = UserDefaults.standard
        defaults.set(ges.id, forKey: DefaultsKeys.QuizID)
        present(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if segment_control.selectedSegmentIndex == 0 {
            return 360
        }else{
            return 390
        }
        
        
        
        
        
    }
    
    @IBAction func getTimeTable() {
        
        let quizModal = QuizModal()
        
        quizModal.SchoolID = SchoolId
        
        //        segment_control.selectedSegmentIndex == 0 {
        quizModal.StatusType = sendStatusType
        //        }
        
        quizModal.StudentID = ChildId
        print("sendStatusType",sendStatusType)
        print("SchoolId",SchoolId)
        print("ChildId",ChildId)
        let quizModalStr = quizModal.toJSONString()
        
        QuizRequest.call_request(param: quizModalStr!) {
            [self]   (res) in
            
            
            
            
            
            let quizRespose : QuizRespose = Mapper<QuizRespose>().map(JSONString: res)!
            
            
            if quizRespose.Status == 1 {
                
                quizGetData = quizRespose.data
                clone_list = quizRespose.data
                tv.dataSource = self
                tv.delegate = self
                tv.isHidden = false
                
                tv.reloadData()
                
            }
            else {
                //                tv.reloadData()
                _ = SweetAlert().showAlert("Alert", subTitle: quizRespose.Message, style: .none, buttonTitle: "OK")
                //                      (isOkClick) in
                //                     if isOkClick {
                //                         dismiss(animated: true)
                //                     }
                //                 }
                
                
                tv.isHidden = true
                
                //
                
            }
        }
    }
    
    
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        if segment_control.selectedSegmentIndex == 0 {
            sendStatusType = 1
            getTimeTable()
        }
        else {
            sendStatusType = 2
            getTimeTable()
        }
        
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        if selectSegment.selectedSegmentIndex == 0{
        let filtered_list : [QuizData] = Mapper<QuizData>().mapArray(JSONString: clone_list.toJSONString()!)!
        
        if !searchText.isEmpty{
            quizGetData = filtered_list.filter { $0.Title.lowercased().contains(searchText.lowercased()) ||
                $0.Subject.lowercased().contains(searchText.lowercased())
            }
            
            
        }else{
            quizGetData = filtered_list
            print("pendingOrder")
        }
        
        if quizGetData.count > 0{
            print ("searchListPendigCount",quizGetData.count)
            noRecordsLbl.isHidden = true
        }else{
            noRecordsLbl.isHidden = false
        }
        
        tv.reloadData()
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        search_bar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search_bar.endEditing(true)
    }
    
    
}


class ViewReportGesture : UITapGestureRecognizer {
    
    
    var id : String!
}
