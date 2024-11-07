//
//  LessonEditTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit

class LessonEditTableViewCell: UITableViewCell {

    @IBOutlet weak var textEdit: UITextField!
    
    @IBOutlet weak var keyNameLbl: UILabel!
    
    @IBOutlet weak var changeImg: UIImageView!
    
    @IBOutlet weak var clickView: UIView!
    @IBOutlet weak var keyValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
   
}
