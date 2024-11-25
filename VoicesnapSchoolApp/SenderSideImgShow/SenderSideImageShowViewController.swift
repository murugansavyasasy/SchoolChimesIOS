//
//  SenderSideImageShowViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/25/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit

class SenderSideImageShowViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tv: UITableView!
    var selectedImgArr : [Int] = []
    
    var rowId = "selectedImageShowTableViewCell"
    var selectedImages: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.delegate = self
        tv.dataSource = self
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        
        
        
        tv.register(UINib(nibName: rowId, bundle: nil), forCellReuseIdentifier: rowId)

        // Do any additional setup after loading the view.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowId, for: indexPath) as! selectedImageShowTableViewCell
        cell.img.image = selectedImages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    

}
