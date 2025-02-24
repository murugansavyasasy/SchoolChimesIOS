//
//  CustomTabVC.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import UIKit

class CustomTabVC: UIViewController {

    // Child View Controllers
    let homeVC = HomePaucktVC()
    let searchVC = CooponViewVC()
    let profileVC = CooponViewVC()

    @IBOutlet weak var containerView: UIView!
    // Custom Tab Bar
    let customTabBar = UIStackView()
    
    @IBOutlet weak var tabView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.layer.cornerRadius = 35
        tabView.layer.shadowColor = UIColor.black.cgColor
        tabView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabView.layer.shadowRadius = 5
        tabView.layer.shadowOpacity = 0.3
        switchToTab(index: 0) // Default to first tab
    }
   
    @IBAction func changeIndex(_ sender: UIButton) {
        switchToTab(index: sender.tag)
    }
    
    
    private func switchToTab(index: Int) {
        let selectedVC: UIViewController
        switch index {
        case 0: selectedVC = homeVC
        case 1: selectedVC = searchVC
        case 2: selectedVC = profileVC
        default: return
        }
        
        for subview in containerView.subviews {
            subview.removeFromSuperview()
        }
        
        addChild(selectedVC)
        selectedVC.view.frame = containerView.bounds
        containerView.addSubview(selectedVC.view)
        selectedVC.didMove(toParent: self)
        
        // Update button colors
        for (i, button) in customTabBar.arrangedSubviews.enumerated() {
            (button as? UIButton)?.tintColor = (i == index) ? .blue : .gray
        }
    }
}
