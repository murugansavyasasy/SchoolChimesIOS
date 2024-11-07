//
//  UpdateDetailWebviewLoadViewController.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 15/11/23.
//  Copyright © 2023 Gayathri. All rights reserved.
//

import UIKit
import WebKit



class UpdateDetailWebviewLoadViewController: UIViewController {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var webViewLoad: WKWebView!
    
    var redirectUrl : String!
    var heading : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("redirectUrl",redirectUrl)
        print("heading",heading)
        
        if redirectUrl == ""  || redirectUrl == nil{
            print("empty")
        }else{
            
            titleLbl.text = heading
            
            let url = URL (string: redirectUrl )
            let requestObj = URLRequest(url: url!)
            webViewLoad.load(requestObj)
        }
        let cancelGesture = UITapGestureRecognizer(target: self, action: #selector(cancelVc))
        backView.addGestureRecognizer(cancelGesture)
        
        
    }
    
    
    @IBAction func cancelVc(){
        
        dismiss(animated: true)
    }
    
    
    
    
}
