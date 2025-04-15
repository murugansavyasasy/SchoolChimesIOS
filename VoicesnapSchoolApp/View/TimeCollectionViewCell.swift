//
//  TimeCollectionViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 13/08/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var timeHoleView: UIViewX!
    var BookedSlotId : String?
    var indexpath  = 1
    var selectedIndexPath: IndexPath?
    var disabledIndices: [IndexPath] = [] // Store disabled slots
    
    var isSlotBooked: Bool = false
    var disabelID = 0
    
    override var isSelected: Bool {
        didSet {
            //             Change the appearance of the cell when it's selected
            
            if indexpath == 1{
                
            }else{
                if isSelected {
                    
                    self.timeHoleView.backgroundColor = .systemOrange
                    //
                } 
                else {
                    
                    self.timeHoleView.backgroundColor = UIColor(named: "NoDataColor")
                    
                }
            }
        }
        
    }
    
    
    

    func indexPath() -> IndexPath? {
            guard let collectionView = self.superview as? UICollectionView else { return nil }
            return collectionView.indexPath(for: self)
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.timeHoleView.backgroundColor = UIColor(named: "NoDataColor")
    }
}
