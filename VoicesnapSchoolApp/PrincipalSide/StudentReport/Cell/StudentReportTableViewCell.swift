//
//  StudentReportTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/03/23.
//  Copyright © 2Gayathri. All rights reserved.
//

import UIKit

class StudentReportTableViewCell: UITableViewCell {

    @IBOutlet weak var fathernameLbl: UILabel!
    @IBOutlet weak var classteacherNametitLbl: UILabel!
    
    @IBOutlet weak var StudentnameTitLbl: UILabel!
    
    @IBOutlet weak var classnameTitlbl: UILabel!
    
    @IBOutlet weak var SectionTitLbl: UILabel!
    
    @IBOutlet weak var MobileNoTitLbl: UILabel!
    @IBOutlet weak var classTeacherLbl: UILabel!
    
    @IBOutlet weak var DobTitLbl: UILabel!
    @IBOutlet weak var GenderTitLbl: UILabel!
    @IBOutlet weak var AdmissionNoTitLbl: UILabel!
    @IBOutlet weak var fatherNameLbl: UILabel!
    @IBOutlet weak var mobileNoLbl: UILabel!
    
    @IBOutlet weak var smsView: UIView!
    
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var studentNameLbl: UILabel!
    
    @IBOutlet weak var admissionLbl: UILabel!
    
    
    @IBOutlet weak var classsNameLbl: UILabel!
    
    @IBOutlet weak var sectionNameLbl: UILabel!
    
    @IBOutlet weak var callLbl: UILabel!
    
    @IBOutlet weak var SendSmsLbl: UILabel!
    @IBOutlet weak var callView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        StudentnameTitLbl.text = commonStringNames.StudentName.translated()
        classnameTitlbl.text = commonStringNames.ClassName.translated()
        SectionTitLbl.text = commonStringNames.SectionName.translated()
        AdmissionNoTitLbl.text = commonStringNames.AdmissionNo.translated()
        DobTitLbl.text = commonStringNames.DOB.translated()
        GenderTitLbl.text = commonStringNames.Gender.translated()
        MobileNoTitLbl.text = commonStringNames.MobileNo.translated()
        classnameTitlbl.text = commonStringNames.ClassTeacherName.translated()
        fathernameLbl.text = commonStringNames.FatherName.translated()
        callLbl.text = commonStringNames.Call.translated()
        SendSmsLbl.text = commonStringNames.SendSMS.translated()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
