//
//  ManagementVideoTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 10/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class ManagementVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var newLblHight: NSLayoutConstraint!
    @IBOutlet weak var newLbl: UILabel!
    @IBOutlet weak var CreatedByLbl: UILabel!
    @IBOutlet weak var CreatedOnLbl: UILabel!
    
    @IBOutlet weak var DescriptionLbl: UILabel!
    
    @IBOutlet weak var TitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
