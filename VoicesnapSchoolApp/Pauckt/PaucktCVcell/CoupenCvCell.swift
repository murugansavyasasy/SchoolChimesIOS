//
//  CoupenCvCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 19/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import UIKit

class CoupenCvCell: UICollectionViewCell {

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
        backgroundImageView.layer.masksToBounds = true

//           Optional: Shadow for the outer cell
//          self.layer.shadowColor = UIColor.black.cgColor
//          self.layer.shadowOpacity = 0.1
//          self.layer.shadowOffset = CGSize(width: 0, height: 2)
//          self.layer.shadowRadius = 6
//          self.layer.masksToBounds = false

        // Allow multiline labels
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
    }

}
