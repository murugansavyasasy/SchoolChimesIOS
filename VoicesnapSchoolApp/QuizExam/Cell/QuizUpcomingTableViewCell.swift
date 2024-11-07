//
//  QuizUpcomingTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 31/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class QuizUpcomingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var getQuesLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var totalMarkLbl: UILabel!
    
    @IBOutlet weak var totalQuestionLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    
    
    @IBOutlet weak var getQuesView: UIView!
    
    @IBOutlet weak var levelLbl: UILabel!
    
    
    @IBOutlet weak var sentByLbl: UILabel!
    
    @IBOutlet weak var numberLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
