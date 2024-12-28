//
//  LsrwListShowTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/20/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class LsrwListShowTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var sentHeadLBl: UILabel!
    @IBOutlet weak var submitHeadLbl: UILabel!
    
    
    @IBOutlet weak var subHeadLbl: UILabel!
    
    @IBOutlet weak var descHeadLbl: UILabel!
    @IBOutlet weak var titHeadLbl: UILabel!
    
    
    
    
    @IBOutlet weak var newLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var takingSkillHeight: NSLayoutConstraint!
    @IBOutlet weak var submittedHeadingLbl: UILabel!
    @IBOutlet weak var takingSkillView: UIView!
    @IBOutlet weak var takingSkillBtn: UIButton!
    @IBOutlet weak var sentByLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var submittedOnLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titHeadLbl.text = commonStringNames.Title.translated()
        descHeadLbl.text = commonStringNames.Description.translated()
        subHeadLbl.text = commonStringNames.Subject.translated()
        submitHeadLbl.text = commonStringNames.SubmittedOn.translated()
        sentHeadLBl.text = commonStringNames.SentBy.translated()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
