//
//  QuizCompletedTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 14/02/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class QuizCompletedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var getQuesView: UIView!
    @IBOutlet weak var wrongAnsLbl: UILabel!
    
    
    @IBOutlet weak var totalMarkLbl: UILabel!
    
    
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var rightAnsLbl: UILabel!
    @IBOutlet weak var sentByLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var totalQuesLbl: UILabel!
    
    
    @IBOutlet weak var subLbl: UILabel!
    
    
    @IBOutlet weak var levelLbl: UILabel!
    
    
    
    @IBOutlet weak var submissonLbl: UILabel!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
