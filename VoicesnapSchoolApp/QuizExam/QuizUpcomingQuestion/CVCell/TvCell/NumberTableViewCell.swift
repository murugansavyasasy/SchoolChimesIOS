//
//  NumberTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 22/02/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper

class NumberTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    var  QuestionData : [GetQuestionData]? = []
    var ChildId  = String()
    var quizId : Int!
    
    let num_row_identifier = "GetQuestionNumberCollectionViewCell"
    @IBOutlet weak var cv: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let defaults = UserDefaults.standard
        quizId = defaults.integer(forKey: DefaultsKeys.QuizID)
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        GetGuestion()
        self.cv.delegate = self
        self.cv.dataSource = self
        self.cv.reloadData()
        
        
        
        
        let numrowNib = UINib(nibName: num_row_identifier, bundle: nil)
        cv.register(numrowNib, forCellWithReuseIdentifier: num_row_identifier)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuestionData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: num_row_identifier, for: indexPath) as! GetQuestionNumberCollectionViewCell
        
        cell.numberLbl.text = String(indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0 {
//            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//        }else{
            return CGSize(width: 100  , height: 60)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: num_row_identifier, for: indexPath) as! GetQuestionNumberCollectionViewCell
        let getData : GetQuestionData = QuestionData![indexPath.row]
        if getData.isSelect  == true {
                   cell.numberView.backgroundColor = .blue
                   cell.numberLbl.textColor = .white
       
               }else{
                   cell.numberView.backgroundColor = UIColor(named: "NoDataColor")
                   cell.numberLbl.textColor = .black
       
               }
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
//
                                
                let aOption = QuestionData![0].QuestionAnswer[0].replacingOccurrences(of: "1~", with: "")
                                        let bOption = QuestionData![0].QuestionAnswer[1].replacingOccurrences(of: "2~", with: "")
                                        let cOption = QuestionData![0].QuestionAnswer[2].replacingOccurrences(of: "3~", with: "")
                                        let dOption = QuestionData![0].QuestionAnswer[3].replacingOccurrences(of: "4~", with: "")
                                
                cv.delegate = self
                cv.dataSource = self
                cv.reloadData()
            }
            
            
        }
        
        
        
        
        
    }
    
    
}
