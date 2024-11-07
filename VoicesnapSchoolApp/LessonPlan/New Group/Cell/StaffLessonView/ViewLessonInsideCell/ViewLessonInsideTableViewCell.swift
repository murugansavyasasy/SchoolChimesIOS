//
//  ViewLessonInsideTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 10/05/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class ViewLessonInsideTableViewCell: UITableViewCell {

    
    @IBOutlet weak var valueLbl: UILabel!
    
    @IBOutlet weak var keyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueLbl.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
    
    
}
