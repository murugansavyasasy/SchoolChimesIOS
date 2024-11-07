//
//  StaffLessonTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 09/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import LinearProgressBar


class StaffLessonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var OverAllview: UIView!
    @IBOutlet weak var staffNameLbl: UILabel!
    
    
    @IBOutlet weak var completedItemLbl: UILabel!
    @IBOutlet weak var classNameLbl: UILabel!
    
    
    @IBOutlet weak var totalItemLbl: UILabel!
    
    
    
    @IBOutlet weak var percentageValueShow: UILabel!
    @IBOutlet weak var linProgressView: LinearProgressBar!
    @IBOutlet weak var subjectNameLbl: UILabel!
    
    @IBOutlet weak var itemCompleterdPercentageLbl: UILabel!
    
    @IBOutlet weak var percentageValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        linProgressView.translatesAutoresizingMaskIntoConstraints = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
