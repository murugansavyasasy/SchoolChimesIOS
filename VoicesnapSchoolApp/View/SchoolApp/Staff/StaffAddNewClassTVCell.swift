//
//  StaffAddNewClassTVCell.swift
//  VoicesnapSchoolApp
//
//  Created by Shenll-Mac-04 on 18/01/18.
//  Copyright © 2018 Shenll-Mac-04. All rights reserved.
//

import UIKit

class StaffAddNewClassTVCell: UITableViewCell {
    @IBOutlet weak var SchoolNameLbl: UILabel!
    @IBOutlet weak var SelectionImage: UIImageView!
    @IBOutlet weak var BorderImage: UIImageView!
     @IBOutlet weak var SubjectView: UIView!
    @IBOutlet weak var getSubjectButton: UIButton!
    @IBOutlet weak var GetSubjectView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // getSubjectButton.isHidden = true
       // getSubjectButton.setTitle("get subject", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
