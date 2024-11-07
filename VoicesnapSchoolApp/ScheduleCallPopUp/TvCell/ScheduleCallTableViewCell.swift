//
//  ScheduleCallTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 23/04/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class ScheduleCallTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLbl: UILabel!
    
    
    @IBOutlet weak var deleteView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
