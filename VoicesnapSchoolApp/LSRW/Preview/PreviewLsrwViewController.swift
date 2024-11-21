//
//  PreviewLsrwViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/21/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class PreviewLsrwViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var playView: UIView!
    
    @IBOutlet weak var plyImg: UIImageView!
    
    @IBOutlet weak var voiceHoleView: UIView!
    
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgView: UIView!
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var textView: UIView!
    
    
    @IBOutlet weak var backView: UIView!
    var attactType : String!
    var attactText : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("attactType",attactType)
        if attactType == "TEXT" {
            textView.isHidden = false
            textLbl.isHidden = false
            textLbl.text = attactText
            
            
            
            voiceHoleView.isHidden = true
            imgView.isHidden = true
//            textView.isHidden = false
//            textLbl.isHidden = false
            
            
            
        }else   if attactType == "IMAGE" {
            imgView.isHidden = false
//            img.isHidden = false
            
            
            voiceHoleView.isHidden = true
            textView.isHidden = true
            
        }else   if attactType == "PDF" {
            
//            imgView.isHidden = false
//            img.isHidden = false
            
            
            voiceHoleView.isHidden = true
            textView.isHidden = true
            
            
        }else   if attactType == "VOICE" {
            voiceHoleView.isHidden = false
//            sli.isHidden = false
            
            
            imgView.isHidden = true
            textView.isHidden = true
            
            
        }
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        // Do any additional setup after loading the view.
    }


    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
}
