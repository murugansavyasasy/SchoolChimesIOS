//
//  ScheduleCallViewController.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 22/04/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import FSCalendar
class ScheduleCallViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    
    @IBOutlet weak var overAllCaleView: UIView!
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tv: UITableView!
    
    
    
    @IBOutlet weak var timeDatePickView: FSCalendar!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var calendarView: UIView!
    
    
    
    @IBOutlet weak var initiateCallHourView: UIViewX!
    @IBOutlet weak var doNotDialMinView: UIViewX!
    
    
    @IBOutlet weak var doNotDialHourLbl: UILabel!
    
    @IBOutlet weak var initiateCallHour: UILabel!
    
    
    @IBOutlet weak var initiateCallMinView: UIViewX!
    @IBOutlet weak var doNotDialHourView: UIViewX!
    @IBOutlet weak var initiateCallMinLbl: UILabel!
    
    var url_time: String!
    var dateArr : [String] = []
    var display_date : String!
    var date = Date()
    var datePickerMode = NSString()
    let timeView = UIView()
    let timeViews = UIView()
    var popupLoading : KLCPopup = KLCPopup()
    let dateViews = UIView()
    let dateView = UIView()
    let timePicker = UIDatePicker()
    var dateRefId = "1"
    let rowId = "ScheduleCallTableViewCell"
    var timeId  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overAllCaleView.isHidden  = true
        
        timeDatePickView.delegate = self
        timeDatePickView.dataSource = self
        
        timeDatePickView.allowsMultipleSelection = true
        
        
        
        dateLbl.text = "Select Date"
        
        
        tv.estimatedRowHeight = 60
        
        let doNotCallGes = deleteGesture(target: self, action: #selector(doNotCallAction))
        doNotCallGes.id = 2
        doNotDialHourView.addGestureRecognizer(doNotCallGes)
        
        
        
        
        let initiateCallGes = deleteGesture(target: self, action: #selector(initiateCallAction))
        initiateCallGes.id = 1
        initiateCallHourView.addGestureRecognizer(initiateCallGes)
        
        let calendarGes = UITapGestureRecognizer(target: self, action: #selector(calendarAction))
        
        calendarView.addGestureRecognizer(calendarGes)
        
        
        tv.isHidden  = true
        
        
        tv.register(UINib(nibName: rowId, bundle: nil), forCellReuseIdentifier: rowId)
        
        
        let backGes = UITapGestureRecognizer(target: self, action: #selector(backAct))
        backView.addGestureRecognizer(backGes)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        
        if !dateArr.contains(result) {
            dateArr.append(result)
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        
        if let index = dateArr.firstIndex(of: result) {
            dateArr.remove(at: index)
        }
        
    }
    
    
    @IBAction func backAct() {
        dismiss(animated: true)
        
    }
    
    @IBAction func calendarAction() {
        
        overAllCaleView.isHidden  = false
        timeDatePickView.isHidden  = false
        
    }
    
    
    @IBAction func doNotCallAction() {
        
        timeId = "2"
        timeSS()
    }
    
    
    @IBAction func initiateCallAction() {
        
        //
        timeId = "1"
        
        timeSS()
        
    }
    
    
    func timeSS(){
        
        print("timeId1",timeId)
        RPickerTwo.selectDate(title: "Select time", cancelText: "Cancel", datePickerMode: .time, style: .Wheel, didSelectDate: {[weak self] (today_date) in
            
            
            self?.display_date = today_date.dateString("hh:mm:a")
            self?.url_time = today_date.dateString("a:mm:hh")
            
            if self!.timeId == "1"{
                self?.initiateCallHour.text = self!.display_date
            }
            else if self!.timeId == "2"{
                
                self?.doNotDialHourLbl.text = self!.display_date
            }
            
        })
        
        
    }
    
    
    @IBAction func doneAction(_ sender: Any) {
        
        overAllCaleView.isHidden  = true
        tv.isHidden  = false
        tv.delegate = self
        tv.dataSource = self
        tv.reloadData()
        
        
        
    }
    
    @IBAction func deleteAction(ges: deleteGesture) {
        
        dateArr.remove(at: ges.id )
        var dateFormat = "dd-MM-yyyy"
        
        
        let dateString = ges.datestring
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        // Convert string to date
        if let dates = dateFormatter.date(from: dateString!) {
            print("Converted Date:", dates)
            self.timeDatePickView.deselect(dates)
        } else {
            print("Failed to convert string to date.")
        }
        
        timeDatePickView.isHidden  = true
        
        tv.isHidden  = false
        tv.delegate = self
        tv.dataSource = self
        tv.reloadData()
        //
    }
    
    
    
    
    
    @IBAction func datePickAction(_ sender: UIDatePicker ) {
        
        
        
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let calendar = Calendar.current
        if let maxDate = calendar.date(byAdding: .day, value: 30, to: Date()) {
            return date >= Date() && date <= maxDate
        }
        return false
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if date < Date() || date > calendar.maximumDate {
            return .lightGray
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dateArrdateArr",dateArr.count)
        
        if dateArr.count == 0{
            
            dateLbl.text = "select Date"
        }
        return dateArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("tableViewtableViewtableView")
        let cell = tableView.dequeueReusableCell(withIdentifier: rowId, for: indexPath) as! ScheduleCallTableViewCell
        cell.dateLbl.text = dateArr[indexPath.row]
        
        
        
        let deleteGes = deleteGesture(target: self, action: #selector(deleteAction))
        deleteGes.id = indexPath.row
        deleteGes.datestring = dateArr[indexPath.row]
        cell.deleteView.addGestureRecognizer(deleteGes)
        dateLbl.text = dateArr[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



class deleteGesture : UITapGestureRecognizer {
    var id : Int!
    var datestring : String!
}
