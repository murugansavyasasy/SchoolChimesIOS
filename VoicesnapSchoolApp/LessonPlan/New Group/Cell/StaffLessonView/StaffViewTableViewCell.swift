//
//  StaffViewTableViewCell.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 09/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper


class StaffViewTableViewCell: UITableViewCell, UITableViewDataSource , UITableViewDelegate {
    
    

    
    @IBOutlet weak var listShowView: UIView!
    @IBOutlet weak var overAllView: UIViewX!
    
    @IBOutlet weak var demoLblData: UILabel!
    
   
   
    @IBOutlet weak var CompletedLbl: UILabel!
    @IBOutlet weak var InProgressLbl: UILabel!
    
    @IBOutlet weak var YettostartLbl: UILabel!
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var deleteView: UIView!
    
    
    @IBOutlet weak var yetToStartView: UIViewX!
    @IBOutlet weak var editView: UIViewX!
    
    
    @IBOutlet weak var yetToStartImg: UIImageView!
    @IBOutlet weak var inProgressView: UIViewX!
    
    @IBOutlet weak var completedView: UIViewX!
    
    @IBOutlet weak var completedImg: UIImageView!
    
    @IBOutlet weak var inprogressImg: UIImageView!
    @IBOutlet weak var inprogressLineView: UIView!
    @IBOutlet weak var completedLineView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
   
    var StaffId : String!
    var SchoolId : String!
    var SecID : String!
    var rowIdentifier = "ViewLessonInsideTableViewCell"
    var ViewLessonPlanViewData : [ViewLessonPlanForAppData] = []
    var ViewLessonPlanData : [ViewLessonPlanDataArray] = []
    var getVal = NSMutableArray()
    var demo : Int!
    
    
    
    var demoKey : String!
    var demoValue : String!
    
    
    var demolesson : [ViewLessonPlanDataArray] = []
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        YettostartLbl.text = commonStringNames.yetToStart.translated()
        InProgressLbl.text = commonStringNames.inProgress.translated()
        CompletedLbl.text = commonStringNames.Completed.translated()
       
        print("demoKey",demoKey)
        print("demoValue",demoValue)

        print("demolesson",demolesson)
        tv.dataSource = self
        tv.delegate = self

        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier: rowIdentifier)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("ViewLessonPlanData.count",ViewLessonPlanData.count)
        return ViewLessonPlanData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath)as! ViewLessonInsideTableViewCell

        
        

        let dataList : ViewLessonPlanDataArray = ViewLessonPlanData[indexPath.row]
        
        
       

       
       
      
        cell.valueLbl.text = dataList.value
        cell.keyLbl.text = dataList.name
        return cell
    }

    
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 40

    }
    
       

}






