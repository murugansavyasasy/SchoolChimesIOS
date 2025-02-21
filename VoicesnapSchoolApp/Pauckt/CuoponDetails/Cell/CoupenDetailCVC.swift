//
//  CoupenDetailCVC.swift
//  rewardDesign
//
//  Created by admin on 19/02/25.
//

import UIKit

class CoupenDetailCVC: UICollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outerView.layer.cornerRadius = 20
    }

}
