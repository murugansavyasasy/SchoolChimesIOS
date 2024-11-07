//
//  ExamViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 01/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ObjectMapper

class ExamViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var segment_control: UISegmentedControl!
    
    @IBOutlet weak var tv: UITableView!
    
    
    var examGetData : [ExamData] = []
    var examCompletedGetData : [ExamData] = []
    var examExpireGetData : [ExamData] = []
    
    
    var sendStatusType : Int = 1
    //    ExamExpiredTableViewCell
    
    let rowIdentifier = "ExamUpcomingTableViewCell"
    
    let examCompleteRowIdentifier = "ExamCompletedTableViewCell"
    
    let examExpiredRowIdentifier =  "ExamExpiredTableViewCell"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var SchoolId  = String()
    var StaffId  = String()
    var ChildId  = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        SchoolId = String(describing: appDelegate.SchoolDetailDictionary["SchoolID"]!)
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        
        // Do any additional setup after loading the view.
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        tv.dataSource = self
        tv.delegate = self
        
        
        getExamList()
        
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
        
        
        
        let examCompleteRowNib = UINib(nibName: examCompleteRowIdentifier, bundle: nil)
        tv.register(examCompleteRowNib, forCellReuseIdentifier: examCompleteRowIdentifier)
        
        let examExpireRowNib = UINib(nibName: examExpiredRowIdentifier, bundle: nil)
        tv.register(examExpireRowNib, forCellReuseIdentifier: examExpiredRowIdentifier)
    }
    
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segment_control.selectedSegmentIndex == 0 {
            
            return examGetData.count
        }
        else if segment_control.selectedSegmentIndex == 1 {
            
            return examCompletedGetData.count
        }  else if segment_control.selectedSegmentIndex == 2 {
            
            return examExpireGetData.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segment_control.selectedSegmentIndex == 0 {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! ExamUpcomingTableViewCell
            
            let exam : ExamData = examGetData[indexPath.row]
            
            cell.startLbl.text = exam.ExamStartTime
            cell.titleLbl.text = exam.Title
            cell.subjectLbl.text = exam.Subject
            cell.endTimeLbl.text = exam.ExamEndTime
            cell.sentByLbl.text = exam.SentBy
            cell.examDateLbl.text = exam.ExamDate
            cell.totalQuesLbl.text = String(exam.TotalNumberOfQuestions)
            cell.timeQuesReadLbl.text = exam.TimeForQuestionReading
            cell.totalMArkLbl.text = exam.totalMark
            cell.descLbl.text = exam.Description
            cell.rightAnsLbl.text = exam.RightAnswer
            cell.wrongAnsLbl.text = exam.WrongAnswer
            
            let startExamGesture  = ExamQuizViewReportGesture(target: self, action: #selector(StartExam))
            startExamGesture.id = String(exam.QuizId)
            startExamGesture.start = exam.ExamStartTime
            startExamGesture.end = exam.ExamEndTime
            cell.getQuesView.addGestureRecognizer(startExamGesture)
            return cell
            
        }
        
        else if segment_control.selectedSegmentIndex == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: examCompleteRowIdentifier, for: indexPath) as! ExamCompletedTableViewCell
            
            let exam : ExamData = examCompletedGetData[indexPath.row]
            
            cell.titleLbl.text = exam.Title
            cell.subjectLbl.text = exam.Subject
            cell.submissionLbl.text = exam.SubmittedOn
            cell.sentLbl.text = exam.SentBy
            cell.examDateLbl.text = exam.ExamDate
            cell.totlaQuesLbl.text = String(exam.TotalNumberOfQuestions)
            cell.descLbl.text = exam.Description
            
            cell.quesViewLbl.text = "View"
            
            let quizViewGesture = ExamQuizViewReportGesture(target: self, action: #selector(getQuizViewReport))
            quizViewGesture.id = String(exam.QuizId)
            cell.getQuesView.addGestureRecognizer(quizViewGesture)
            return cell
            
        }else {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: examExpiredRowIdentifier, for: indexPath) as! ExamExpiredTableViewCell
            let exam : ExamData = examExpireGetData[indexPath.row]
            
            cell.titleLbl.text = exam.Title
            cell.subjectLbl.text = exam.Subject
            cell.sentByLbl.text = exam.SentBy
            cell.examDateLbl.text = exam.ExamDate
            cell.totalQuesLbl.text = String(exam.TotalNumberOfQuestions)
            cell.totalMarkLbl.text = exam.totalMark
            cell.descLbl.text = exam.Description
            cell.rightAnsLbl.text = exam.RightAnswer
            cell.wrongAnsLbl.text = exam.WrongAnswer
            
            return cell
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if segment_control.selectedSegmentIndex == 0 {
            return 480
        }
        else  if segment_control.selectedSegmentIndex == 1 {
            return 290
        }
        else  if segment_control.selectedSegmentIndex == 2 {
            return 320
        }else{
            return 100
        }
        
    }
    
    
    
    
    
    
    
    
    @IBAction func getQuizViewReport (ges : ExamQuizViewReportGesture) {
        let vc = QuizViewReportViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.quizId = ges.id
        present(vc, animated: true)
    }
    
    @IBAction func getExamList() {
        
        let examModal = QuizModal()
        
        examModal.SchoolID = SchoolId
        examModal.StatusType = sendStatusType
        examModal.StudentID = ChildId
        print("SchoolId",SchoolId)
        print("sendStatusType",sendStatusType)
        print("ChildId",ChildId)
        
        
        let examModalStr = examModal.toJSONString()
        
        ExamRequest.call_request(param: examModalStr!) {
            [self]   (res) in
            
            
            
            
            
            let examRespose : ExamRespose = Mapper<ExamRespose>().map(JSONString: res)!
            
            
            if examRespose.Status == 1 {
                
                examGetData = examRespose.data
                examCompletedGetData = examRespose.data
                examExpireGetData = examRespose.data
                tv.dataSource = self
                tv.delegate = self
                tv.isHidden = false
                
                tv.reloadData()
                
            }
            else {
                //                tv.reloadData()
                _ = SweetAlert().showAlert("Alert", subTitle: examRespose.Message, style: .none, buttonTitle: "OK")
                
                
                
                tv.isHidden = true
                
                //
                
            }
        }
    }
    
    
    
    @IBAction func StartExam(ges : ExamQuizViewReportGesture) {
        let vc = ExamUpcomingViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.quizId = Int(ges.id)
        vc.strtTime = ges.start
        vc.endTime = ges.end
        let defaults = UserDefaults.standard
        defaults.set(ges.id, forKey: DefaultsKeys.QuizID)
        present(vc, animated: true)
    }
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        if segment_control.selectedSegmentIndex == 0 {
            sendStatusType = 1
            getExamList()
        }
        else if segment_control.selectedSegmentIndex == 1{
            sendStatusType = 2
            getExamList()
        }else{
            
            sendStatusType = 3
            getExamList()
        }
    }
    
    
}



class ExamQuizViewReportGesture : UITapGestureRecognizer {
    
    
    var id : String!
    var start : String!
    var end : String!
}
