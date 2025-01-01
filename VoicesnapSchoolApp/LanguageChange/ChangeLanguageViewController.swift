//
//  ChangeLanguageViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 12/27/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

struct language{
    let language:String
    var selected:Bool
}
//language(language: "Tamil", selected: false),


class ChangeLanguageViewController: UIViewController {
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var tv: UITableView!
    var arrUserData: NSArray = []
    var Items = [language(language: "English", selected: false),
                 
                 language(language: "Hindi", selected: false),
                 language(language: "Thai", selected: false)]
    
    var Language = ["English","हिंदी","ไทย"]
    var rowId = "ChangeLanguageTableViewCell"
    var languageCode = "en"
    var index = 0
    var  Buttontext = ["Confirm","पुष्टि करें","ยืนยัน"]
    var ParentSelectedLoginIndex = 0
    
    var selectedLanguage: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = UserDefaults.standard.integer(forKey: "index")
        Items[index].selected = true
        tv.dataSource =  self
        
        print("langtesteCode",DefaultsKeys.languageCode)
        tv.delegate =  self
        
        tv.register(UINib(nibName: rowId, bundle: nil), forCellReuseIdentifier: rowId)
    }
    
    
    @IBAction func closeAct(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    @IBAction func confirmAct(_ sender: UIButton) {
        
        UserDefaults.standard.set(index, forKey: "index")
        let userDefault = UserDefaults.standard
        
        TranslationManager.shared.setLanguage(languageCode)
        userDefault.set(languageCode, forKey: DefaultsKeys.languageCode)
        
        // Apply the language immediately
        userDefault.synchronize()
        
        print("langualanguageCodede",languageCode)
        print("languageCode",DefaultsKeys.languageCode)
//      p  dismiss(animated: true)
        
        
      //  UserDefaults.standard.set(index, forKey: "index")
//        if #available(iOS 13.0, *) {
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                  let window = windowScene.windows.first else { return }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewController = storyboard.instantiateInitialViewController()
//            window.rootViewController = initialViewController
//            window.makeKeyAndVisible()
//        } else {
//            guard let window = UIApplication.shared.keyWindow else { return }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewController = storyboard.instantiateInitialViewController()
//            window.rootViewController = initialViewController
//            window.makeKeyAndVisible()
//        }
        
//        UserDefaults.standard.set(index, forKey: "index")
//            let userDefault = UserDefaults.standard
//            TranslationManager.shared.setLanguage(languageCode)
//            userDefault.set(languageCode, forKey: DefaultsKeys.languageCode)
//            userDefault.synchronize()
//
//            print("languageCode", languageCode)
//
//            // Reload the entire application
            guard let window = UIApplication.shared.keyWindow else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateInitialViewController()
            window.rootViewController = initialViewController
            window.makeKeyAndVisible()

            // Optional: Add a transition animation
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)

    }
    
}
@available(iOS 14.0, *)
extension ChangeLanguageViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowId , for: indexPath) as! ChangeLanguageTableViewCell
        
        if index == indexPath.row{
            
            confirmBtn.setTitle(Buttontext[index], for: .normal)
            confirmBtn.titleLabel?.textAlignment = .center
            confirmBtn.titleLabel?.adjustsFontSizeToFitWidth = true
            cell.checkImg.image = UIImage(named: "checked_Tick")
            cell.langIconImg.tintColor = .systemOrange
            
        }else{
            
            cell.checkImg.image = UIImage(named: "CheckCircle")
            cell.langIconImg.tintColor = .lightGray
        }
        
        
        if Items[indexPath.row].selected == true{
            selectedLanguage = Items[indexPath.row].language
        }
        
        
        cell.changeLang.text = Items[indexPath.row].language
        cell.defalutLang.text = Language[indexPath.row]
        cell.langIconImg.image = UIImage(named: Items[indexPath.row].language)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        selectedLanguage = Items[indexPath.row].language
        Items[indexPath.row].selected = true
        index = indexPath.row
        
        let userDefault = UserDefaults.standard
        
        //        if selectedLanguage == "Tamil" {
        //            languageCode = "ta-IN"
        //        }
        if selectedLanguage == "Thai" {
            languageCode = "th"
        } else if selectedLanguage == "Hindi" {
            languageCode = "hi"
        } else if selectedLanguage == "English" {
            languageCode = "en"
        }
    
        
        tv.reloadData()
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  75
    }
    
    
    
    
}
