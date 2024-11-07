//
//  ExamCompletedTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 01/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class ExamCompletedTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    
    @IBOutlet weak var subjectLbl: UILabel!
    
    
    @IBOutlet weak var submissionLbl: UILabel!
    
    
    @IBOutlet weak var quesViewLbl: UILabel!
    @IBOutlet weak var getQuesView: UIView!
    
    @IBOutlet weak var examDateLbl: UILabel!
    
    
    @IBOutlet weak var sentLbl: UILabel!
    
    @IBOutlet weak var totlaQuesLbl: UILabel!
    
    
    @IBOutlet weak var descLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
