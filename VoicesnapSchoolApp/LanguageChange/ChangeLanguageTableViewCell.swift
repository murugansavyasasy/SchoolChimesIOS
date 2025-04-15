//
//  ChangeLanguageTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 12/27/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class ChangeLanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var changeLang: UILabel!
    @IBOutlet weak var defalutLang: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var langIconImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
