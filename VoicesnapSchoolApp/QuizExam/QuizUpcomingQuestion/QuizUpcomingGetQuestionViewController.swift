//
//  QuizUpcomingGetQuestionViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 13/02/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper

enum SelectedOption {
    case optionA
    case optionB
    
}
class QuizUpcomingGetQuestionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var optionDView: UIView!
    
    @IBOutlet weak var optionCView: UIView!
    
    
    @IBOutlet weak var optionAView: UIView!
    
    
    
    @IBOutlet weak var optionBView: UIView!
    
    
    @IBOutlet weak var optionAImg: UIImageView!
    
    
    
    @IBOutlet weak var optionDImg: UIImageView!
    @IBOutlet weak var optionCImg: UIImageView!
    
    
    
    @IBOutlet weak var optionBImg: UIImageView!
    
    
    
    @IBOutlet weak var snoLbl: UILabel!
    
    
    @IBOutlet weak var nextImg: UILabel!
    
    
    @IBOutlet weak var nextView: UIViewX!
    @IBOutlet weak var previousView: UIViewX!
    
    
    
    @IBOutlet weak var previousImg: UIImageView!
    
    @IBOutlet weak var submitLbl: UILabel!
    @IBOutlet weak var submitView: UIViewX!
    
    @IBOutlet weak var opBLbl: UILabel!
    
    @IBOutlet weak var opALbl: UILabel!
    
    @IBOutlet weak var opDLbl: UILabel!
    
    
    @IBOutlet weak var opCLbl: UILabel!
    
    
    
    @IBOutlet weak var nextImageview: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var cv: UICollectionView!
    
    var currrentPosition : Int!
    @IBOutlet weak var quesLbl: UILabel!
    
    
    
    
    @IBOutlet weak var arrSizeLbl: UILabel!
    
    
    var optionClickColor : UIColor!
    var optionPos : Int! = 0
    
    var viewSele : Int!
    
    var conc : String! = ""
    var intArray : [Int] = []
    
    var AnsStr :  [String]! = []
    
    let tv_row_identifier = "NumberTableViewCell"
    var  QuestionData : [GetQuestionData]? = []
    let rowIdentifier = "GetQuestionNumberCollectionViewCell"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var ChildId  = String()
    
    var quizId : Int!
    
    var  points = 0
    var index = 0
    
    var answerSelected : Bool!
    var isCorrectAnswer = false
    
    var correctAnswer: String?
    var position : Int! = 0
    
    var preposition = 1
    
    var submitType : Int = 0
    
    var selectedOption: ((_ selectedAnswer: Bool) -> Void)?
    
    var aaaa  : String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextImageview.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/1))
        
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        
        
        GetGuestion()
        self.cv.delegate = self
        self.cv.dataSource = self
        self.cv.reloadData()
        
        snoLbl.text = "Q.1"
        
        nextView.backgroundColor = .blue
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        cv.register(rowNib, forCellWithReuseIdentifier: rowIdentifier)
        
        
        let previousGesture = UITapGestureRecognizer(target: self, action: #selector(previousVC))
        previousView.addGestureRecognizer(previousGesture)
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        if submitType == 1 {
            let submitGesture = UITapGestureRecognizer(target: self, action: #selector(submitVC))
            submitView.addGestureRecognizer(submitGesture)
        }
        
        
        
        if nextView.backgroundColor != .clear {
            nextView.isUserInteractionEnabled = true
        }else{
            nextView.isUserInteractionEnabled = false
        }
        
        let selectA = IndexGesture(target: self, action: #selector(SelectAOption))
        selectA.indexId = 0
        optionAView.addGestureRecognizer(selectA)
        
        
        
        let selectB = IndexGesture(target: self, action: #selector(SelectBOption))
        selectB.indexId = 0
        optionBView.addGestureRecognizer(selectB)
        
        
        let selectC = IndexGesture(target: self, action: #selector(SelectCOption))
        selectC.indexId = 0
        optionCView.addGestureRecognizer(selectC)
        
        
        let selectD = IndexGesture(target: self, action: #selector(SelectDOption))
        selectD.indexId = 0
        optionDView.addGestureRecognizer(selectD)
        
        if nextView.backgroundColor != .clear {
            nextView.isUserInteractionEnabled = true
            let nextGesture = UITapGestureRecognizer(target: self, action: #selector(nextVC))
            //        nextGesture.indexId = indexPath.item
            nextView.addGestureRecognizer(nextGesture)
        }else{
            nextView.isUserInteractionEnabled = false
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if nextView.backgroundColor != .clear {
            nextView.isUserInteractionEnabled = true
        }else{
            nextView.isUserInteractionEnabled = false
        }
        if submitType != 1 {
            let submitGesture = UITapGestureRecognizer(target: self, action: #selector(submitVC))
            submitView.addGestureRecognizer(submitGesture)
            
        }
    }
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if nextView.backgroundColor != .clear {
            nextView.isUserInteractionEnabled = true
        }else{
            nextView.isUserInteractionEnabled = false
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        if nextView.backgroundColor != .clear {
            nextView.isUserInteractionEnabled = true
        }else{
            nextView.isUserInteractionEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if nextView.backgroundColor != .clear {
            nextView.isUserInteractionEnabled = true
        }else{
            nextView.isUserInteractionEnabled = false
        }
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
        
        
        
        selectedOption = { [weak self] isCorrect in
            self?.answerSelected = true
            self?.isCorrectAnswer = isCorrect
        }
        
        
        
        
        cell.numberLbl.text = String(indexPath.row + 1)
        
        
        
        return cell
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80  , height: 58)
        
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
                
                
                
                QuestionData![0].isSelect = true
                
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowIdentifier, for: indexPath) as! GetQuestionNumberCollectionViewCell
        
        
        
        
        
        
        let selectA = IndexGesture(target: self, action: #selector(SelectAOption))
        selectA.indexId = indexPath.item
        optionAView.addGestureRecognizer(selectA)
        
        
        
        let selectB = IndexGesture(target: self, action: #selector(SelectBOption))
        selectB.indexId = indexPath.item
        optionBView.addGestureRecognizer(selectB)
        print("indexPath.item",indexPath.item)
        
        
        let selectC = IndexGesture(target: self, action: #selector(SelectCOption))
        selectC.indexId = indexPath.item
        optionCView.addGestureRecognizer(selectC)
        print("indexPath.item",indexPath.item)
        
        
        
        let selectD = IndexGesture(target: self, action: #selector(SelectDOption))
        selectD.indexId = indexPath.item
        optionDView.addGestureRecognizer(selectD)
        print("indexPath.item",indexPath.item)
        
        
        
        
        
        
        change_icon_style(pos: indexPath.item )
        
        optionPos = indexPath.item
        load_details(pos: indexPath.item)
        
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
        
        aaaa = String(getData.QestionID!) + "~1"
        
        print("aaaa",aaaa!)
        print("conc",conc!)
        
        print("didselectConcc",conc)
        
        //        conc = ""
        print("String(getData.QestionID!) + ~1",String(getData.QestionID!) + "~1")
        
        if aaaa.contains(conc){
            if String(conc) ==  String(getData.QestionID!) + "~1" {
                print("String(getData.QestionID!) + ~1",String(getData.QestionID!) + "~1")
                optionAImg.image = UIImage(named: "QuizRadio")
                optionAImg.tintColor = UIColor(named: "checkColor")
            }else{
                print("condition not working",String(getData.QestionID!) + "~1")
                optionAImg.image = UIImage(named: "RadioNormal")
            }
        }
        
        if String(conc) ==  String(getData.QestionID!) + "~2" {
            optionBImg.image = UIImage(named: "QuizRadio")
            optionBImg.tintColor = UIColor(named: "checkColor")
        }else{
            print("condition not working",String(getData.QestionID!) + "~2")
            optionBImg.image = UIImage(named: "RadioNormal")
        }
        
        
        if String(conc) ==  String(getData.QestionID!) + "~3" {
            optionCImg.image = UIImage(named: "QuizRadio")
            optionCImg.tintColor = UIColor(named: "checkColor")
        }
        
        else{
            
            print("condition not working",String(getData.QestionID!) + "~3")
            optionCImg.image = UIImage(named: "RadioNormal")
        }
        
        
        if String(conc) ==  String(getData.QestionID!) + "~4" {
            optionDImg.image = UIImage(named: "QuizRadio")
            optionDImg.tintColor = UIColor(named: "checkColor")
        }else{
            
            print("condition not working",String(getData.QestionID!) + "~4")
            optionDImg.image = UIImage(named: "RadioNormal")
        }
        
        
        
        cv.reloadData()
        
    }
    
    
    
    
    @IBAction func nextVC() {
        
        
        if nextView.backgroundColor != .clear {
            print("12index",index)
            if index<(self.QuestionData?.count ?? 0) + 0{
                index += 1
                print("index print(index)",index)
                change_icon_style(pos:  index + position)
                load_details(pos: index + position)
                cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
                
            }
            cv.reloadData()
            nextView.isUserInteractionEnabled = true
        }else{
            nextView.isUserInteractionEnabled = false
        }
        
        
        
        
        
        
        
        
        
    }
    
    @IBAction func previousVC() {
        
        
        print(index)
        if index<(self.QuestionData?.count ?? 0) - 0 {
            index -= 1
            print("index print(index)",index)
            change_icon_style(pos:  index + preposition)
            print("index + preposition",index + preposition)
            load_details(pos: index + preposition)
            cv.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
            
        }
        
        
        
        
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
    
    
    
    
    
    
    @IBAction func SelectAOption(ges : IndexGesture) {
        
        
        let getData : GetQuestionData = QuestionData![ges.indexId]
        print("optionPos",ges.indexId)
        var aOption = getData.QuestionAnswer[0]
        print("aOption",aOption)
        
        print("getData.Question",getData.QestionID!)
        let b = aOption.removeFirst()
        print("b",b)
        
        let c = String(b)
        
        
        
        conc = String(getData.QestionID) + "~" + c
        print("conc",conc)
        
        
        
        viewSele = 1
        
        
        var isCorrect = false
        
        
        selectedOption?(isCorrect)
        
        optionAImg.image = UIImage(named: "QuizRadio")
        optionAImg.tintColor = UIColor(named: "checkColor")
        optionBImg.image = UIImage(named: "RadioNormal")
        optionCImg.image = UIImage(named: "RadioNormal")
        optionDImg.image = UIImage(named: "RadioNormal")
        
        submitType = 1
        submitLbl.textColor = .white
        submitView.backgroundColor =  UIColor(named: "serach_color")
        
        
        
    }
    
    
    @IBAction func SelectBOption(ges : IndexGesture) {
        
        
        let getData : GetQuestionData = QuestionData![ges.indexId]
        print("optionPos",ges.indexId)
        var aOption = getData.QuestionAnswer[1]
        print("aOption",aOption)
        
        print("getData.Question",getData.QestionID)
        let b = aOption.removeFirst()
        print("b",b)
        let c = String(b)
        conc = String(getData.QestionID) + "~" + c
        print("conc",conc)
        
        
        optionBImg.image = UIImage(named: "QuizRadio")
        optionBImg.tintColor = UIColor(named: "checkColor")
        optionAImg.image = UIImage(named: "RadioNormal")
        optionCImg.image = UIImage(named: "RadioNormal")
        optionDImg.image = UIImage(named: "RadioNormal")
        viewSele = 2
        submitType = 1
        var isCorrect = true
        
        
        selectedOption?(isCorrect)
        submitLbl.textColor = .white
        submitView.backgroundColor =  UIColor(named: "serach_color")
    }
    
    
    @IBAction func SelectCOption(ges : IndexGesture) {
        
        
        let getData : GetQuestionData = QuestionData![ges.indexId]
        print("optionPos",ges.indexId)
        var aOption = getData.QuestionAnswer[2]
        print("aOption",aOption)
        
        
        
        print("getData.Question",getData.QestionID)
        let b = aOption.removeFirst()
        print("b",b)
        let c = String(b)
        conc = String(getData.QestionID) + "~" + c
        optionClickColor = .blue
        print("conc",conc)
        viewSele = 3
        
        optionCImg.image = UIImage(named: "QuizRadio")
        optionCImg.tintColor = UIColor(named: "checkColor")
        optionBImg.image = UIImage(named: "RadioNormal")
        optionAImg.image = UIImage(named: "RadioNormal")
        optionDImg.image = UIImage(named: "RadioNormal")
        
        submitType = 1
        var isCorrect = true
        
        
        selectedOption?(isCorrect)
        submitLbl.textColor = .white
        submitView.backgroundColor =  UIColor(named: "serach_color")
        
    }
    
    
    @IBAction func SelectDOption(ges : IndexGesture) {
        
        
        let getData : GetQuestionData = QuestionData![ges.indexId]
        print("optionPos",ges.indexId)
        var aOption = getData.QuestionAnswer[3]
        print("aOption",aOption)
        print("getData.Question",getData.QestionID!)
        let b = aOption.removeFirst()
        print("b",b)
        let c = String(b)
        
        
        var tildd = "~"
        conc = String(getData.QestionID) + tildd + c
        print("conc",conc)
        
        var isCorrect = true
        
        
        selectedOption?(isCorrect)
        
        
        viewSele = 4
        
        optionDImg.image = UIImage(named: "QuizRadio")
        optionDImg.tintColor = UIColor(named: "checkColor")
        optionBImg.image = UIImage(named: "RadioNormal")
        optionCImg.image = UIImage(named: "RadioNormal")
        optionAImg.image = UIImage(named: "RadioNormal")
        
        
        submitType = 1
        
        submitLbl.textColor = .white
        submitView.backgroundColor =  UIColor(named: "serach_color")
        
    }
    
    
    func load_details(pos: Int){
        print("load_details(po",pos)
        
        
        
        
        
        if(AnsStr.contains(conc)){
            if let index = AnsStr.firstIndex(of: conc) {
                
                AnsStr.remove(at: index)
                AnsStr.append(conc)
                
                //
            } else {
            }
        }
        else{
            AnsStr.append(conc)
            
        }
        
        
        let getData : GetQuestionData = QuestionData![pos]
        
        
        
        print("GetConc",conc!)
        print("getData.QestionID + ~1", String(getData.QestionID!) + "~1")
        
        
        aaaa = String(getData.QestionID!) + "~1"
        
        print("aaaa",aaaa!)
        print("conc",conc!)
        
        
        
        
        if aaaa.contains(conc) {
            if String(conc) ==  String(getData.QestionID!) + "~1" {
                print("String(getData.QestionID!) + ~1",String(getData.QestionID!) + "~1")
                optionAImg.image = UIImage(named: "QuizRadio")
                optionAImg.tintColor = UIColor(named: "checkColor")
            }else{
                print("condition not working",String(getData.QestionID!) + "~1")
                optionAImg.image = UIImage(named: "RadioNormal")
            }
        }
        
        
        
        
        
        
        if String(conc) ==  String(getData.QestionID!) + "~2" {
            optionBImg.image = UIImage(named: "QuizRadio")
            optionBImg.tintColor = UIColor(named: "checkColor")
        }else{
            print("condition not working",String(getData.QestionID!) + "~2")
            optionBImg.image = UIImage(named: "RadioNormal")
        }
        
        
        
        
        if String(conc) ==  String(getData.QestionID!) + "~3" {
            optionCImg.image = UIImage(named: "QuizRadio")
            optionCImg.tintColor = UIColor(named: "checkColor")
        }
        else{
            print("condition not working",String(getData.QestionID!) + "~3")
            optionCImg.image = UIImage(named: "RadioNormal")
        }
        
        
        
        
        if String(conc) ==  String(getData.QestionID!) + "~4" {
            optionDImg.image = UIImage(named: "QuizRadio")
            optionDImg.tintColor = UIColor(named: "checkColor")
        }else{
            
            print("condition not working",String(getData.QestionID!) + "~4")
            optionDImg.image = UIImage(named: "RadioNormal")
        }
        
        
        
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
        print("getData.QestionID1",getData.QestionID)
        
        
        //        optionAImg.tintColor = .lightGray
        //        optionBImg.tintColor = .lightGray
        //        optionCImg.tintColor = .lightGray
        //        optionDImg.tintColor = .lightGray
        
        
        
        
        
        
        
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
        
        
        
        
        cv.reloadData()
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tv_row_identifier, for: indexPath) as! NumberTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
    
    @IBAction func submitVC() {
        
        if(AnsStr.contains(conc)){
            if let index = AnsStr.firstIndex(of: conc) {
                AnsStr.remove(at: index)
                AnsStr.append(conc)
            } else {
                
                
            }
        }
        else{
            AnsStr.append(conc)
            
        }
        
        print("AnsStr.append(conc)",AnsStr)
        
        
        let nameString = AnsStr.joined(separator: ",")
        print("questionSubmit.Answer",nameString)
        
        
        
        let questionSubmit = GetQuestionSubmitModal()
        
        
        
        
        questionSubmit.QuizId = quizId
        questionSubmit.StudentID = ChildId
        questionSubmit.Answer =   "[" + nameString + "]"
        
        print("quizId",quizId!)
        print("ChildId",ChildId)
        
        
        let questionSubmitStr = questionSubmit.toJSONString()
        
        
        print("questionSubmitStr",questionSubmitStr!)
        
        
        //
    }
    
    
    
}



struct SCategory {
    
    enum ProductType {
        case DX, DXV, DXC, DGE, DC,DA,LL,ALT,ES,OT
    }
    
    var id : String!
    var selected : Bool!
    var title : String!
    var icon : String!
    var bg_name : String!
    var description : String!
    var pdf : String!
    var type : ProductType
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}



class IndexGesture : UITapGestureRecognizer{
    var indexId : Int!
    var indexPathId : IndexPath!
    var bgView : UIView!
    
    
}




