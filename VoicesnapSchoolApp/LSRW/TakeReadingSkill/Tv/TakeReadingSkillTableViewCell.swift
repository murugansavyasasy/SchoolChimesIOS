//
//  TakeReadingSkillTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/21/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class TakeReadingSkillTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var attachHeadLbl: UILabel!
    
    @IBOutlet weak var viewAttachmentLbl: UILabel!
    
    @IBOutlet weak var typeHeadLbl: UILabel!
    
    @IBOutlet weak var viewAttac: UIView!
    
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var attachmentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        attachHeadLbl.text = commonStringNames.Attachment.translated()
        typeHeadLbl.text = commonStringNames.type.translated()
        viewAttachmentLbl.text = commonStringNames.ViewAttachment.translated()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
