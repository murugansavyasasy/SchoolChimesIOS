//
//  UpdateDetailCollectionViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 14/11/23.
//  Copyright © 2023 Gayathri. All rights reserved.
//

import UIKit
import WebKit

class UpdateDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var downloadImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var webVieww: WKWebView!
    
    
    @IBOutlet weak var redirectView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
