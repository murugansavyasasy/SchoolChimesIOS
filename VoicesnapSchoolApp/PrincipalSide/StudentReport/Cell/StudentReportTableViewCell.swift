//
//  StudentReportTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/03/23.
//  Copyright © 2Gayathri. All rights reserved.
//

import UIKit

class StudentReportTableViewCell: UITableViewCell {

    
    @IBOutlet weak var classTeacherLbl: UILabel!
    
    
    @IBOutlet weak var fatherNameLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    
    @IBOutlet weak var smsView: UIView!
    
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var studentNameLbl: UILabel!
    
    @IBOutlet weak var admissionLbl: UILabel!
    
    
    @IBOutlet weak var classsNameLbl: UILabel!
    
    @IBOutlet weak var sectionNameLbl: UILabel!
    
    
    @IBOutlet weak var callView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
