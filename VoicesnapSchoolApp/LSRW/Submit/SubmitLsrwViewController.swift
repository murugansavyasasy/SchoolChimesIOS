//
//  SubmitLsrwViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/20/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import DropDown

class SubmitLsrwViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    var dropDown  = DropDown()
  
    @IBOutlet weak var uploadFileImg: UIImageView!
    @IBOutlet weak var uploadFileLbl: UILabel!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var voicePlayView: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var imgPdfPathShowView: UIView!
    @IBOutlet weak var overAllTextView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var voiceeTapView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var recordlbl: UILabel!
    @IBOutlet weak var voiceOverAllVie: UIView!
    @IBOutlet weak var contentTextViw: UITextView!
    @IBOutlet weak var voiceRecordBtn: UIButton!
    @IBOutlet weak var changeImgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgPathLbl: UILabel!
    @IBOutlet weak var imageOverAllView: UIView!
    @IBOutlet weak var dropDownView: UIViewX!
    @IBOutlet weak var dropDownTextLbl: UILabel!
    
    
    var items = ["Text", "Voice", "Image","Pdf","Video"]
    var rowId = "FileAttachmentTableViewCell"
    
    var pathArr : [String] = []
    var fileArr : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        overAllTextView.isHidden = true
        contentTextViw.isHidden = false
        voiceOverAllVie.isHidden = true
        imgPdfPathShowView.isHidden = true
        imageOverAllView.isHidden = true
        dropDownView.isHidden = false
        
        addBtn.setTitle("Add Content", for: .normal)
        
        
        tv.register(UINib(nibName: rowId, bundle: nil), forCellReuseIdentifier: rowId)
        
        let selectMonth = UITapGestureRecognizer(target: self, action: #selector(selectMonthViewClick))
        dropDownView.addGestureRecognizer(selectMonth)
        
        
        
    }


    
    @IBAction func selectMonthViewClick(){
        
        
        let myArray = items
        
        dropDown.dataSource = myArray//4
        dropDown.anchorView = dropDownView //5
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.direction = .bottom
        DropDown.appearance().backgroundColor = UIColor.white
        dropDown.show() //7
        
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
          
            
            dropDownTextLbl.text = item
            
           
            
            if item == "Text" {
                
                overAllTextView.isHidden = false
                contentTextViw.isHidden = false
                voiceOverAllVie.isHidden = true
                imgPdfPathShowView.isHidden = true
                imageOverAllView.isHidden = true
                addBtn.setTitle("Add Content", for: .normal)

            } else if item == "Image" {
                
                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = true
                imgPdfPathShowView.isHidden = true
                uploadFileLbl.text = "Upload Image"
                imageOverAllView.isHidden = false
                addBtn.setTitle("Add File Attachments", for: .normal)
                uploadFileImg.image = UIImage(named: "ImageIcon")
                changeImgView.isHidden = false
                
                
            } else if item == "Pdf" {
                
                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = true
                uploadFileLbl.text = "Browse File"
                imgPdfPathShowView.isHidden = true
                imageOverAllView.isHidden = false
                addBtn.setTitle("Add File Attachments", for: .normal)
                uploadFileImg.image = UIImage(named: "pdfImage")
                changeImgView.isHidden = false

                
            } else if item == "Voice" {
                
                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = false
                imgPdfPathShowView.isHidden = true
                imageOverAllView.isHidden = false
                voicePlayView.isHidden = true
                addBtn.setTitle("Add File Attachments", for: .normal)
                
            } else if item == "Video" {
                
                overAllTextView.isHidden = true
                contentTextViw.isHidden = true
                voiceOverAllVie.isHidden = true
                imgPdfPathShowView.isHidden = true
                imageOverAllView.isHidden = true
                uploadFileLbl.text = "Upload Video"
                addBtn.setTitle("Add File Attachments", for: .normal)
                uploadFileImg.image = UIImage(named: "p23")
                changeImgView.isHidden = false


                
                
            }
            
           
        }
        
        
    }

    @IBAction func addFileAttachmentBtnAction(_ sender: UIButton) {
        
        
        if dropDownTextLbl.text == "Text" {
            pathArr.append(contentTextViw.text)
            print("pathArrpathArr",pathArr.count)
            contentTextViw.text = ""
            fileArr.append("")
            tv.delegate = self
            tv.dataSource = self
            tv.reloadData()
            
        }else  if dropDownTextLbl.text == "Image" {
            pathArr.append(contentTextViw.text)
        }else  if dropDownTextLbl.text == "Pdf" {
            pathArr.append(contentTextViw.text)
        }else  if dropDownTextLbl.text == "Voice" {
            pathArr.append(contentTextViw.text)
        }
        
        
       

    }
    
    
    
    
    @IBAction func voiceRecordBtnAction(_ sender: UIButton) {
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("pathArrcount",pathArr.count)
        return pathArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowId, for: indexPath) as! FileAttachmentTableViewCell
        
        cell.contentFilePathLbl.text = pathArr[indexPath.row]
        
//     img   cell.contentFilePathLbl.text = fileArr[indexPath.row]
        
        
        
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(selectMonthViewClick))
        dropDownView.addGestureRecognizer(closeGesture)
        
        
        
        
        return  cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
}


struct  FileAttach {
    
    
    let pathLbl: String!
    let img: String!
    
}
   
