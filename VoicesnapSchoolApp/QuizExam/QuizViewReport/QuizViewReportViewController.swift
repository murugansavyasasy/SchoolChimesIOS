//
//  QuizViewReportViewController.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 01/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit
import ObjectMapper

class QuizViewReportViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var rightAnswerLbl: UILabel!
    
    
    @IBOutlet weak var notAnsLbl: UILabel!
    
    @IBOutlet weak var wrongAnsLbl: UILabel!
    
    
    @IBOutlet weak var tv: UITableView!
    
    
    var quizId : String!
    
    //    QuizViewTableViewCell
    
    let rowIdentifier = "QuizViewTableViewCell"
    
    var getQuizArray  : [QuizArrayData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tv.dataSource = self
        tv.delegate = self
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        
        
        
        QuizView()
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        viewBack.addGestureRecognizer(backGesture)
        
        
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getQuizArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! QuizViewTableViewCell
        
        let quizArray : QuizArrayData = getQuizArray[indexPath.row]
        
        cell.selectionStyle = .none
        
        
        let aOption = quizArray.aOption.replacingOccurrences(of: "1~", with: "")
        let bOption = quizArray.bOption.replacingOccurrences(of: "2~", with: "")
        let cOption = quizArray.cOption.replacingOccurrences(of: "3~", with: "")
        let dOption = quizArray.dOption.replacingOccurrences(of: "4~", with: "")
        
        
        
        cell.qusLbl.text = quizArray.question
        cell.optALbl.text = aOption
        cell.optBLbl.text = bOption
        cell.optCLbl.text = cOption
        cell.optDLbl.text = dOption
        cell.correctAnsLbl.text = quizArray.correctAnswer
        
        
        
        
        let OptionA = quizArray.aOption.removeFirst()
        let aop = OptionA
        
        
        let OptionB = quizArray.bOption.removeFirst()
        let bop = OptionB
        
        
        let OptionC = quizArray.cOption.removeFirst()
        let cop = OptionC
        
        
        let OptionD = quizArray.dOption.removeFirst()
        let dop = OptionD
        
        
        
        if quizArray.answer == quizArray.studentAnswer {
            if quizArray.studentAnswer == String(aop) {
                cell.opABtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
                cell.opABtn.tintColor = UIColor(named: "serach_color")
            }else if quizArray.studentAnswer == String(bop) {
                cell.opBBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
                cell.opBBtn.tintColor = UIColor(named: "serach_color")
            }else if quizArray.studentAnswer == String(cop) {
                cell.opCBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
                cell.opCBtn.tintColor = UIColor(named: "serach_color")
            }else if quizArray.studentAnswer == String(dop) {
                cell.opDBtn.tintColor = UIColor(named: "serach_color")
                cell.opDBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
            }
        }else{
            if quizArray.studentAnswer == String(aop) {
                cell.opABtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
                
                let image = UIImage(named: "QuizRadio")?.withRenderingMode(.alwaysTemplate)
                cell.opABtn.setImage(image, for: .normal)
                cell.opABtn.tintColor = UIColor.red
            }else if quizArray.studentAnswer == String(bop) {
                cell.opBBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
                cell.opBBtn.tintColor = .red
            }else if quizArray.studentAnswer == String(cop) {
                cell.opCBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
                cell.opCBtn.tintColor = .red
            }else if quizArray.studentAnswer == String(dop) {
                cell.opDBtn.tintColor = .red
                cell.opDBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
            }
        }
        
        
        
        cell.sNoLbl.text =  "\(indexPath.row + 1)."
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
        
    }
    
    
    @IBAction func QuizView() {
        
        let quizViewModal = QuizViewModal()
        
        quizViewModal.StudentID = "7656366"
        quizViewModal.QuizId = quizId
        
        
        
        let quizViewModalStr = quizViewModal.toJSONString()
        
        QuizViewRequest.call_request(param: quizViewModalStr!) {
            [self]   (res) in
            
            
            
            
            
            let quizViewRespose : QuizViewResponse = Mapper<QuizViewResponse>().map(JSONString: res)!
            
            
            if quizViewRespose.status == 1 {
                
                
                
                
                
                rightAnswerLbl.text = quizViewRespose.data.rightAnswer
                wrongAnsLbl.text = quizViewRespose.data.wrongAnswer
                notAnsLbl.text = quizViewRespose.data.unAnswer
                
                getQuizArray = quizViewRespose.data.quizArray
                //                 }
                
                tv.isHidden = false
                tv.dataSource = self
                tv.delegate = self
                
                tv.reloadData()
                
            }
            else {
                //                tv.reloadData()
                _ = SweetAlert().showAlert("Alert", subTitle: quizViewRespose.message, style: .none, buttonTitle: "OK")
                //
                
                
                tv.isHidden = true
                
                //
                
            }
        }
    }
    
    
    
    
}



