//
//  QuizViewTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 02/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class QuizViewTableViewCell: UITableViewCell {

    @IBOutlet weak var opABtn: UIButton!
    
    @IBOutlet weak var sNoLbl: UILabel!
    @IBOutlet weak var qusLbl: UILabel!
    
    @IBOutlet weak var optDLbl: UILabel!
    
    @IBOutlet weak var correctAnsLbl: UILabel!
    
    @IBOutlet weak var optALbl: UILabel!
    
    
    @IBOutlet weak var opDBtn: UIButton!
    
    @IBOutlet weak var opCBtn: UIButton!
    @IBOutlet weak var optBLbl: UILabel!
    
    @IBOutlet weak var opBBtn: UIButton!
    
    @IBOutlet weak var optCLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
