//
//  QuizQuestionCollectionViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 22/02/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit





class QuizQuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var SNoLbl: UILabel!
    
    
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var optionC: UIButton!
    
    

    @IBOutlet weak var optionB: UIButton!
    
    @IBOutlet weak var optionA: UIButton!
    
    @IBOutlet weak var opDLbl: UILabel!
    
    @IBOutlet weak var opCLbl: UILabel!
    
    @IBOutlet weak var quesLbl: UILabel!
    
    
    @IBOutlet weak var opALbl: UILabel!
    
    
    @IBOutlet weak var opBLbl: UILabel!
    
    var answerStringArr    : [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var ifType : Int!
    
    
    private var correctAnswer: String?
    
    var setValues: GetQuestionData? {
        didSet {
            
            
            let aOption = setValues?.QuestionAnswer[0].replacingOccurrences(of: "1~", with: "")
                                    let bOption = setValues?.QuestionAnswer[1].replacingOccurrences(of: "2~", with: "")
                                    let cOption = setValues?.QuestionAnswer[2].replacingOccurrences(of: "3~", with: "")
                                    let dOption = setValues?.QuestionAnswer[3].replacingOccurrences(of: "4~", with: "")
           
            quesLbl.text = setValues?.Question
            opALbl.text =  aOption
            opBLbl.text = bOption
            opCLbl.text = cOption
            opDLbl.text = dOption
            
        }
    }
    

    
    var selectedOption: ((_ selectedAnswer: Bool) -> Void)?
    
  
    
    
    
    @IBAction func optionA(_ sender: UIButton) {
        
        
        var isCorrect = false
        
        if correctAnswer == setValues?.QuestionAnswer[0] {
            isCorrect = true
            ifType = 1
            answerStringArr.append("1")
        }
        
        
//        answerStringArr.append("1")
//        ifType = 1
        optionA.setImage(UIImage(named: "QuizRadio"), for: .normal)
        optionB.setImage(UIImage(named: "RadioNormal"), for: .normal)
        optionC.setImage(UIImage(named: "RadioNormal"), for: .normal)
        optionD.setImage(UIImage(named: "RadioNormal"), for: .normal)
        selectedOption?(isCorrect)
//        changeBorder(selectedOption: .optionA)
    }
    
   
}
