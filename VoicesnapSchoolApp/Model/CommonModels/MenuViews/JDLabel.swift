//
//  JDLabel.swift
//  iOSUIMenuController
//
//  Created by Anupam Chugh on 11/08/18.
//  Copyright © 2018 JournalDev. All rights reserved.
//


import UIKit


class JDLabel : UILabel {
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("required init")
        sharedInit()
        showLabelMenu()
    }
    
    func showLabelMenu()
    {
        menuController = UIMenuController.shared
        menuController?.isMenuVisible = true
        menuController?.arrowDirection = UIMenuController.ArrowDirection.down
        
        menuController?.setTargetRect(CGRect.zero, in: self)
        
        let menuItem_1: UIMenuItem = UIMenuItem(title: "Menu 1", action: #selector(JDLabel.onMenu1(sender:)))
        let menuItem_2: UIMenuItem = UIMenuItem(title: "Menu 2", action: #selector(JDLabel.onMenu2(sender:)))
        let menuItem_3: UIMenuItem = UIMenuItem(title: "Menu 3", action: #selector(JDLabel.onMenu3(sender:)))
        
        let myMenuItems: [UIMenuItem] = [menuItem_1, menuItem_2, menuItem_3]
        menuController?.menuItems = myMenuItems
    }
    
    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(
            target: self,
            action: #selector(firstResponder(sender:))
        ))
    }
    
    @objc func firstResponder(sender: Any?) {
        becomeFirstResponder()
        menuController?.setTargetRect(bounds, in: self)
        menuController?.setMenuVisible(true, animated: true)
        menuController?.update()
    }
    
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }
    
    @objc public func onMenu1(sender: UIMenuItem) {
        print("onMenu1 label")
    }
    
    @objc public func onMenu2(sender: UIMenuItem) {
        print("onMenu2 label")
    }
    
    @objc public func onMenu3(sender: UIMenuItem) {
        print("onMenu3 label")
        
        let menuItem4: UIMenuItem = UIMenuItem(title: "Menu 4", action: #selector(onMenu4(sender:)))
        let myIndex = menuController?.menuItems?.firstIndex(where: {$0.title == "Menu 3"})
        menuController?.menuItems?.remove(at: myIndex!)
        menuController?.menuItems?.insert(menuItem4, at:  myIndex!)
        
        menuController?.update()
        
    }
    
    @objc public func onMenu4(sender: UIMenuItem) {
        let menuItem3: UIMenuItem = UIMenuItem(title: "Menu 3", action: #selector(onMenu3(sender:)))
        let myIndex = menuController?.menuItems?.firstIndex(where: {$0.title == "Menu 4"})
        menuController?.menuItems?.remove(at: myIndex!)
        menuController?.menuItems?.insert(menuItem3, at:  myIndex!)
        menuController?.update()
        print("onMenu4 label")
    }
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)){
            return true
        }
        
        if [#selector(onMenu1(sender:)), #selector(onMenu2(sender:)),#selector(onMenu3(sender:)),#selector(onMenu4(sender:))].contains(action) {
            return true
        } else {
            return false
        }
        
    }
    
}
