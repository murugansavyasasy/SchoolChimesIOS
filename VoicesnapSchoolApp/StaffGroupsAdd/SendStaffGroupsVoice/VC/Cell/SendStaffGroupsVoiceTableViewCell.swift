//
//  SendStaffGroupsVoiceTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 04/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class SendStaffGroupsVoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var groupCheckBoxView: StaffCheckBox!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
