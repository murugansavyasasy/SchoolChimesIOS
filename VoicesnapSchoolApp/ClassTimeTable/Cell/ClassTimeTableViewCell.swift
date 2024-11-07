//
//  ClassTimeTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 27/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class ClassTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var fromTimeLbl: UILabel!
    
    @IBOutlet weak var ToTimeLbl: UILabel!
    @IBOutlet weak var subNameLbl: UILabel!
    
    @IBOutlet weak var NameLbl: UILabel!
    
    @IBOutlet weak var durationLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
