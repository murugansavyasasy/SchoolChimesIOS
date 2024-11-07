//
//  JDTextField.swift
//  iOSUIMenuController
//
//  Created by Anupam Chugh on 11/08/18.
//  Copyright © 2018 JournalDev. All rights reserved.
//

import UIKit

class JDTextField : UITextField {
    
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    @objc public func onMenu1(sender: UIMenuItem) {
        print("onMenu1 textfield")
    }
    
    @objc public func onMenu2(sender: UIMenuItem) {
        print("onMenu2 textfield")
    }
    
    @objc public func onMenu3(sender: UIMenuItem) {
        print("onMenu3 textfield")
        let menuItem4: UIMenuItem = UIMenuItem(title: "Menu 4", action: #selector(onMenu4(sender:)))
        let myIndex = menuController?.menuItems?.firstIndex(where: {$0.title == "Menu 3"})
        menuController?.menuItems?.remove(at: myIndex!)
        menuController?.menuItems?.insert(menuItem4, at:  myIndex!)
        menuController?.update()
        
    }
    
    @objc public func onMenu4(sender: UIMenuItem) {
        let menuItem3: UIMenuItem = UIMenuItem(title: "Menu 3", action: #selector(onMenu3(sender:)))
        let myIndex = menuController?.menuItems?.firstIndex(where: {$0.title == "Menu 4"})
        menuController?.menuItems?.removeAll(where: {$0.title == "Menu 4"})
        menuController?.menuItems?.insert(menuItem3, at:  myIndex!)
        menuController?.update()
        print("onMenu4 textfield")
    }
    
    
    @objc public func customPaste(sender: UIMenuItem) {
        self.text = UIPasteboard.general.string
        menuController?.setMenuVisible(false, animated: true)
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any!) -> Bool {
        if [#selector(onMenu1(sender:)), #selector(onMenu2(sender:)), #selector(onMenu3(sender:)),#selector(onMenu4(sender:)),#selector(customPaste(sender:))].contains(action) {
            return true
        } else {
            return false
        }
    }
}
