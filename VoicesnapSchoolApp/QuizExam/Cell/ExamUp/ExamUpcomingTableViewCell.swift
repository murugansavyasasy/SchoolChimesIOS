//
//  ExamUpcomingTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 01/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class ExamUpcomingTableViewCell: UITableViewCell {

    
    
    
    @IBOutlet weak var getQuesView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var startLbl: UILabel!
    @IBOutlet weak var endTimeLbl: UILabel!
    @IBOutlet weak var examDateLbl: UILabel!
    @IBOutlet weak var sentByLbl: UILabel!
    @IBOutlet weak var timeQuesReadLbl: UILabel!
    @IBOutlet weak var totalQuesLbl: UILabel!
    
    @IBOutlet weak var rightAnsLbl: UILabel!
    
    @IBOutlet weak var wrongAnsLbl: UILabel!
    
    @IBOutlet weak var totalMArkLbl: UILabel!
    
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
