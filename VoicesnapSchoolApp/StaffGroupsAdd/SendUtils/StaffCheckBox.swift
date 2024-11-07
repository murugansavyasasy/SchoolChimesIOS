//
//  StaffCheckBox.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 04/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation

import UIKit

class StaffCheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "CheckBoximage")! as! UIImage
    let uncheckedImage = UIImage(named: "UnChechBoxImage")! as! UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
//                print("CheckboxSelect1")
//
//                let userDefault = UserDefaults.standard
//                userDefault.set(1, forKey: DefaultsKeys.checkboxTypeSet)
                
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
//                let userDefault = UserDefaults.standard
//                userDefault.set(0, forKey: DefaultsKeys.checkboxTypeSet)
//                print("CheckboxSelect0")
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
