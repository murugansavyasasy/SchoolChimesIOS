//
//  ExamUpcomingViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 24/02/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper

class ExamUpcomingViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var quesLbl: UILabel!
    @IBOutlet weak var snoLbl: UILabel!
    @IBOutlet weak var opALbl: UILabel!
    
    @IBOutlet weak var opBLbl: UILabel!
    
    @IBOutlet weak var opABtn: UIButton!
    
    @IBOutlet weak var opCLbl: UILabel!
    
    @IBOutlet weak var opDBtn: UIButton!
    
    @IBOutlet weak var opCBtn: UIButton!
    
    @IBOutlet weak var opDLbl: UILabel!
    
    @IBOutlet weak var opBBtn: UIButton!
    
    
    @IBOutlet weak var submitLbl: UILabel!
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var cv: UICollectionView!
    
    @IBOutlet weak var startTimeLbl: UILabel!
    
    
    
    @IBOutlet weak var EndTimeLbl: UILabel!
    
    @IBOutlet weak var nextViewImg: UIImageView!
    
    @IBOutlet weak var submitView: UIViewX!
    @IBOutlet weak var nextView: UIViewX!
    
    @IBOutlet weak var previousView: UIViewX!
    
    @IBOutlet weak var timerLbl: UILabel!
    let rowIdentifier = "GetQuestionNumberCollectionViewCell"
    
    var ChildId  = String()
    
    var quizId : Int!
    
    var  points = 0
    var index = 0
    
    var answerSelected = false
    var isCorrectAnswer = false
    
    var position : Int! = 1
    
    var strtTime : String!
    var endTime : String!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var counter = 0
    var timer = Timer()
    
    var submitType : Int = 0
    var  QuestionData : [GetQuestionData]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        self.cv.delegate = self
        self.cv.dataSource = self
        self.cv.reloadData()
        snoLbl.text = "Q.1"
        
        startTimeLbl.text = ":\(strtTime!)"
        EndTimeLbl.text = ":\(endTime!)"
        
        
        GetGuestion()
        self.nextViewImg.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/1))
        
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        cv.register(rowNib, forCellWithReuseIdentifier: rowIdentifier)
        
        let previousGesture = UITapGestureRecognizer(target: self, action: #selector(previousVC))
        previousView.addGestureRecognizer(previousGesture)
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        
    }
    
    @IBAction func timerAction() {
        counter += 1
        timerLbl.text = "\(counter)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if submitType != 1 {
            let submitGesture = UITapGestureRecognizer(target: self, action: #selector(submitVC))
            submitView.addGestureRecognizer(submitGesture)
            
        }
    }
    
    
    
    
    
    @IBAction func opABtnAction(_ sender: Any) {
        
        opABtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
        
        
        
        let getData : GetQuestionData = QuestionData![0]
        
        let aOption = getData.QuestionAnswer[0]
        print("aOption",aOption)
        
        submitType = 1
        opABtn.tintColor = UIColor(named: "checkColor")
        opBBtn.tintColor = .lightGray
        opCBtn.tintColor = .lightGray
        opDBtn.tintColor = .lightGray
        submitLbl.textColor = .white
        submitView.backgroundColor =  UIColor(named: "serach_color")
        
        opBBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opCBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opDBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
    }
    
    
    
    
    
    @IBAction func opBBtnAction(_ sender: Any) {
        
        submitType = 1
        opBBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
        submitView.backgroundColor =  UIColor(named: "serach_color")
        submitLbl.textColor = .white
        
        opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opCBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opDBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        
        
        opBBtn.tintColor = UIColor(named: "checkColor")
        opABtn.tintColor = .lightGray
        opCBtn.tintColor = .lightGray
        opDBtn.tintColor = .lightGray
        
        
    }
    
    
    
    
    
    @IBAction func opCBtnAction(_ sender: Any) {
        
        submitType = 1
        opCBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
        submitView.backgroundColor =  UIColor(named: "serach_color")
        submitLbl.textColor = .white
        
        opBBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opDBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        
        opCBtn.tintColor = UIColor(named: "checkColor")
        opABtn.tintColor = .lightGray
        opBBtn.tintColor = .lightGray
        opDBtn.tintColor = .lightGray
    }
    
    
    
    @IBAction func opDBtnAction(_ sender: Any) {
        
        submitType = 1
        opDBtn.setImage(UIImage(named: "QuizRadio"), for: .normal)
        submitLbl.textColor = .white
        submitView.backgroundColor =  UIColor(named: "serach_color")
        
        opBBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opCBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        
        
        opDBtn.tintColor = UIColor(named: "checkColor")
        opABtn.tintColor = .lightGray
        opCBtn.tintColor = .lightGray
        opBBtn.tintColor = .lightGray
    }
    
    
    
    
    
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
    
    @IBAction func previousVC() {
        
        
        print(index)
        if index<(self.QuestionData?.count ?? 0) - 1 {
            index -= 1
            change_icon_style(pos:  index + position)
            load_details(pos: index + position)
            cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
            
        }
    }
    
    @IBAction func nextVC() {
        answerSelected = false
        if isCorrectAnswer {
            points += 1
        }
        
        print("index",index)
        if index<(self.QuestionData?.count ?? 0) + 1 {
            index += 1
            cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
            change_icon_style(pos:  index + position)
            load_details(pos: index + position)
        }
        cv.reloadData()
        
    }
    
    
    func change_icon_style(pos: Int){
        for i in 0..<QuestionData!.count{
            print("pos",pos)
            if pos == i{
                QuestionData![i].isSelect =  true
                cv.reloadData()
            }else{
                QuestionData![i].isSelect = false
                cv.reloadData()
            }
        }
        
        cv.reloadData()
    }
    
    
    
    func load_details(pos: Int){
        print("load_details(po",pos)
        
        print(QuestionData!.count)
        let getData : GetQuestionData = QuestionData![pos]
        
        let aOption = getData.QuestionAnswer[0].replacingOccurrences(of: "1~", with: "")
        let bOption = getData.QuestionAnswer[1].replacingOccurrences(of: "2~", with: "")
        let cOption = getData.QuestionAnswer[2].replacingOccurrences(of: "3~", with: "")
        let dOption = getData.QuestionAnswer[3].replacingOccurrences(of: "4~", with: "")
        
        
        snoLbl.text = "Q.\(pos + 1)"
        opALbl.text = aOption
        opBLbl.text = bOption
        opCLbl.text = cOption
        opDLbl.text = dOption
        quesLbl.text = getData.Question
        
        
        
        opBBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opCBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        opDBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
        
        
        opABtn.tintColor = .lightGray
        opCBtn.tintColor = .lightGray
        opDBtn.tintColor = .lightGray
        opBBtn.tintColor = .lightGray
        
        if pos == 0 {
            previousView.backgroundColor = .lightGray
        }else{
            previousView.backgroundColor = .blue
        }
        
        
        
        if pos == QuestionData!.count-1 {
            nextView.backgroundColor = .lightGray
        }else{
            nextView.backgroundColor = .blue
        }
        
        
        if pos == QuestionData?.count{
            
            
            if opABtn.isSelected {
                opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opABtn.tintColor = .blue
            }
        }
        
        
        
        
        
        
        
        
        if opABtn.isSelected {
            opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
            opABtn.tintColor = .blue
        }
        
        
        
        
        
        
        
        
        if pos == QuestionData?.count {
            if opABtn.isSelected {
                opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opABtn.tintColor = .blue
            }else if opBBtn.isSelected {
                opBBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opBBtn.tintColor = .blue
            }else if opCBtn.isSelected {
                opCBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opCBtn.tintColor = .blue
            }else if opDBtn.isSelected {
                opDBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opDBtn.tintColor = .blue
            }
        }else{
            if opABtn.isSelected {
                opABtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opABtn.tintColor = .lightGray
            }else if opBBtn.isSelected {
                opBBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opBBtn.tintColor = .lightGray
            }else if opCBtn.isSelected {
                opCBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opCBtn.tintColor = .lightGray
            }else if opDBtn.isSelected {
                opDBtn.setImage(UIImage(named: "RadioNormal"), for: .normal)
                opDBtn.tintColor = .lightGray
            }
        }
        
        
        
        
        cv.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return  QuestionData!.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowIdentifier, for: indexPath) as! GetQuestionNumberCollectionViewCell
        
        
        let getData : GetQuestionData = (QuestionData?[indexPath.item])!
        
        
        if getData.isSelect  == true {
            cell.numberView.backgroundColor = .blue
            cell.numberLbl.textColor = .white
            
        }else{
            cell.numberView.backgroundColor = UIColor(named: "NoDataColor")
            cell.numberLbl.textColor = .black
            
        }
        ////        load_details(pos: getData.Question)
        cell.numberLbl.text = String(indexPath.row + 1)
        
        
        
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60  , height: 58)
        
    }
    
    
    
    func GetGuestion() {
        
        
        let quesModal = QuizGetQuestionModal()
        quesModal.StudentID = ChildId
        quesModal.QuizId =  quizId
        print("ChildId",ChildId)
        print("quizId",quizId!)
        
        let quesModalStr = quesModal.toJSONString()
        
        print("quesModalStr",quesModalStr)
        QuizGetQuestionRequest.call_request(param: quesModalStr!) {
            [self]  (res) in
            
            
            let quizGetGuestionResponse : QuizGetQuestionResponse = Mapper<QuizGetQuestionResponse>().map(JSONString: res)!
            
            
            
            if quizGetGuestionResponse.Status == 1 {
                
                
                
                QuestionData = quizGetGuestionResponse.QuestionData
                quesLbl.text =  QuestionData![0].Question
                
                
                
                
                let aOption = QuestionData![0].QuestionAnswer[0].replacingOccurrences(of: "1~", with: "")
                let bOption = QuestionData![0].QuestionAnswer[1].replacingOccurrences(of: "2~", with: "")
                let cOption = QuestionData![0].QuestionAnswer[2].replacingOccurrences(of: "3~", with: "")
                let dOption = QuestionData![0].QuestionAnswer[3].replacingOccurrences(of: "4~", with: "")
                opALbl.text = aOption
                opBLbl.text = bOption
                opCLbl.text = cOption
                opDLbl.text = dOption
                cv.delegate = self
                cv.dataSource = self
                cv.reloadData()
            }
            
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func submitVC() {
        
        
        
        
        let questionSubmit = GetQuestionSubmitModal()
        
        
        
        var ans : String!
        
        
        questionSubmit.QuizId = quizId
        questionSubmit.StudentID = ChildId
        //        questionSubmit.Answer =  ans
        
        print("quizId",quizId!)
        print("ChildId",ChildId)
        print("AnsStr",ans)
        
        
        let questionSubmitStr = questionSubmit.toJSONString()
        
        
        print("questionSubmitStr",questionSubmitStr)
        QuizQuestionSubmitRequest.call_request(param: questionSubmitStr!) {
            
            [self] (res) in
            
            
            
            
            let questionSubmitRespose : QuestionSubmitResponse = Mapper<QuestionSubmitResponse>().map(JSONString : res)!
            
            if questionSubmitRespose.Status == 1 {
                
            }else {
                
                _ = SweetAlert().showAlert("", subTitle: "questionSubmitRespose.Message", style: .none, buttonTitle: "Ok", buttonColor: .gray)
            }
            //
        }
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowIdentifier, for: indexPath) as! GetQuestionNumberCollectionViewCell
        
        
        change_icon_style(pos: indexPath.item )
        
        load_details(pos: indexPath.item)
        
        position = indexPath.item + 1
        let nextGesture = UITapGestureRecognizer(target: self, action: #selector(nextVC))
        //        nextGesture.indexId = indexPath.item
        nextView.addGestureRecognizer(nextGesture)
        print("indexPath.item",indexPath.item)
        
        let getData : GetQuestionData = QuestionData![indexPath.item]
        
        
        if getData.isSelect  == true {
            cell.numberView.backgroundColor = .blue
            cell.numberLbl.textColor = .white
            
        }else{
            cell.numberView.backgroundColor = UIColor(named: "NoDataColor")
            cell.numberLbl.textColor = .black
            
        }
        
        
        
        
        cv.reloadData()
        
    }
    
    
    
    
    
}
