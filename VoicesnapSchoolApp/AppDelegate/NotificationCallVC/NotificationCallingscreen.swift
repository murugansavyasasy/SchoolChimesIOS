//
//  NotificationCallingscreen.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 09/10/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class NotificationCallingscreen: UIViewController {
    
    @IBOutlet weak var acceptView: UIView!
    
    @IBOutlet weak var DeclineView: UIView!
    
    
    
    var urlss = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //        view = GradientView()
        
        
        
        
        
        
        let  accept = UITapGestureRecognizer(target: self , action: #selector(appectClcik))
        acceptView.addGestureRecognizer(accept)
        
        let  decline = UITapGestureRecognizer(target: self , action: #selector(DeclineClcik))
        DeclineView.addGestureRecognizer(decline)
    }
    
    @IBAction func appectClcik(){
        
        
        let vcc = NotificationcallVC(nibName: nil, bundle: nil)
        
        vcc.urlss = urlss
        vcc.modalPresentationStyle = .fullScreen
        
        present(vcc, animated: true)
        
        
        
    }
    
    
    @IBAction func DeclineClcik(){
        
        
//        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                exit(0)
        
    }
    
    
    
    class GradientView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            applyGradient()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            applyGradient()
        }
        
        private func applyGradient() {
            let gradientLayer = CAGradientLayer()
            
            // Set the frame to be the same as the view's bounds
            gradientLayer.frame = self.bounds
            
            // Define top, middle, and bottom colors
            gradientLayer.colors = [
                UIColor.red.cgColor,      // Top color
                UIColor.blue.cgColor,     // Middle color
                UIColor.green.cgColor     // Bottom color
            ]
            
            // Define the locations of the colors (0.0 = top, 1.0 = bottom)
            gradientLayer.locations = [0.0, 0.5, 1.0]
            
            // Set the gradient direction (top to bottom)
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // Top center
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)   // Bottom center
            
            // Add the gradient layer to the view
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
