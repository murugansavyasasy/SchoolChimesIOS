//
//  FeeDetailReceiptTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 27/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import UIKit

class FeeDetailReceiptTableViewCell: UITableViewCell {
    @IBOutlet weak var receiptNumberDefLbl: UILabel!
    
    @IBOutlet weak var ViewReceipt: UILabel!
    @IBOutlet weak var receiptAmountLbl: UILabel!
    @IBOutlet weak var receiptDateDefLbl: UILabel!
    @IBOutlet weak var InvoiceNumberLbl: UILabel!
    
    @IBOutlet weak var InvoiceDateLbl: UILabel!
    
    @IBOutlet weak var viewInvoice: UIView!
    @IBOutlet weak var InvoiceAmountLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        receiptNumberDefLbl.text = commonStringNames.ReceiptNumber.translated()
        receiptDateDefLbl.text = commonStringNames.ReceiptDate.translated()
        receiptAmountLbl.text = commonStringNames.ReceiptAmount.translated()
        ViewReceipt.text = commonStringNames.ViewReceipt.translated()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
