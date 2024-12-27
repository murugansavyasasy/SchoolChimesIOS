//
//  CertificatesTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit

class CertificatesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var stsTitLbl: UILabel!
    
    @IBOutlet weak var reaTitleLbl: UILabel!
    
    @IBOutlet weak var creaOnLbl: UILabel!
    @IBOutlet weak var cerTypeLBl: UILabel!
    
    
    
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var conductTypeLbl: UILabel!
    @IBOutlet weak var pdfView: UIView!
    @IBOutlet weak var createdOnLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
