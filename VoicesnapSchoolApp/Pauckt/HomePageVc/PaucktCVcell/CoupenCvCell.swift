//
//  CoupenCvCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 19/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import UIKit

class CoupenCvCell: UICollectionViewCell {

    @IBOutlet weak var brandImg: UIButton!
    @IBOutlet weak var groupImg: UIButton!
    @IBOutlet weak var containerView: UIView!
      @IBOutlet weak var backgroundImageView: UIImageView!
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var subtitleLabel: UILabel!
      @IBOutlet weak var discountLabel: UILabel!
      @IBOutlet weak var locationLabel: UILabel!
      @IBOutlet weak var durationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundImageView.layer.cornerRadius = 12
        brandImg.layer.cornerRadius = 12
        backgroundImageView.layer.masksToBounds = true
        brandImg.layer.masksToBounds = true
        groupImg.layer.masksToBounds = true
        groupImg.layer.cornerRadius = groupImg.frame.width/2
        // Allow multiline labels
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
    }

}
