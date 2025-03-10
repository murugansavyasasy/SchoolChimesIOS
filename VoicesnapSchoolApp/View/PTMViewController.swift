//
//  PTMViewController.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 02/07/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper
import DropDown
import Alamofire
struct Item {
    let title: String
    var isExpanded: Bool
}


struct TeacherSlot {
    
    var Name                                       : String!
    var className                                      : String!
    var data                                         : [GetTeachData]!
    
    init(name: String, classN: String) {
        self.Name = name
        self.className = classN
    }
}
struct GetTeachData  {
    
    var from_time                                    : String!
    var to_time                                      : String!
}

class PTMViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, sloSlectionDataDelegate{
    func getSelectedSlot(selectedIndexPath: [AvailableSlot]?) {
        self.availableSlot = selectedIndexPath ?? []
        var ids = [Int]()
        for i in 0..<availableSlot.count {  // Corrected to iterate `availableSlots`
            for j in 0..<availableSlot[i].slots.count {
                if availableSlot[i]
                    .slots[j].select == 1 && availableSlot[i].isBooked != true {
                    ids.append(availableSlot[i].slots[j].SoltId)  // Correct property name
                }
            }
        }
        
        DefaultsKeys.bookingSlotId = ids
        bookSlotBtn.isHidden = DefaultsKeys.bookingSlotId.isEmpty
        tv.reloadData()
        
    }
    
    
    
    @IBOutlet weak var scheduleLbl: UILabel!
    @IBOutlet weak var bookSlotBtn: UIButton!
    
    @IBOutlet weak var meetLbl: UILabel!
    
    @IBOutlet weak var tvLeading: NSLayoutConstraint!
    
    @IBOutlet weak var tvTralling: NSLayoutConstraint!
    @IBOutlet weak var dropDownLbl: UILabel!
    
    @IBOutlet weak var tvTop: NSLayoutConstraint!
    
    @IBOutlet weak var subviewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBack: UIView!
    
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var segment2: UIView!
    @IBOutlet weak var cv: UICollectionView!
    
    @IBOutlet weak var segment1: UIView!
    
    @IBOutlet weak var noRecordsLbl: UILabel!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var calanderHeightCon: NSLayoutConstraint!
    
    @IBOutlet weak var noRecordsView: UIView!
    
    @IBOutlet weak var actionTitleLbl: UILabel!
    var getStaffIdArr = [Int]()
    var getEventNameArr = [String]()
    let drop_down = DropDown()
    var selectedDate = Date()
    var totalSquares = [String]()
    var screenSize : CGRect!
    var screenWidth : CGFloat!
    var screenHeight : CGFloat!
    
    var currentYear: Int = Calendar.current.component(.year, from: Date())
    var currentMonth: Int = Calendar.current.component(.month, from: Date())
    var segmentId = 1
    var ClickID = 0
    var tvcellIdentifier = "SlotHistoryTableViewCell"
    var selectedCell:IndexPath?
    let daysInMonth = 30
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var givenDate = ["15","3","8"]
    var DateArr = [Int]()
    var DayArr = [String]()
    var monthNumberArr = [String]()
    var getStaffArr = [Int]()
    var rowNib = "CalendarCollectionViewCell"
    var selectedIndexPath: [String] = []
    var availableSlot:[AvailableSlot] = []
    var clickIdType  = 0
    var getTeacherData : [GetTeacherwiseSlotAvailabilityData] = []
    var slotHistoryForParentData : [SlotHistoryForParentResponseData] = []
    var items: [Item] = [
        Item(title: "Item 1", isExpanded: false),
        Item(title: "Item 2", isExpanded: false),
        Item(title: "Item 3", isExpanded: false),
        Item(title: "Item 4", isExpanded: false),
        Item(title: "Item 5", isExpanded: false),
        Item(title: "Item 6", isExpanded: false)
    ]
    
    var instituteId  = Int()
    var sectionId = Int()
    var staffId  = Int()
    var studentId  : Int!
    var ClassTeacherId  = 0
    var yearArr = [Int]()
    var teacherSlotIdentifier =  "StaffPtmTableViewCell"
    var HeaderTv = "TimeHeader"
    var cancelTvCell  = "cancelTableViewCell"
    var getSubjectId = 0
    var getSubjectIdArr =  [Int]()
    var getLoginClassId : Int!
    var getEventDate : String!
    var dropDownData : [SubjectListForStudentData] = []
    var studSlotData : [SlotAvailabilityForStudentsData] = []
    var eventDateArr = [String]()
    var eventCountArr = [String]()
    var duplicateStaffTimes: [Int: [(from_time: String, to_time: String)]] = [:]
    var clickId : Bool!
    var staffIdss : Int!
    let calendar = Calendar.current
    var dates = [Date]()
    var exNames : [Event] = []
    var slotdetails : [Slot] = []
    
    var groupedSlots: [GroupedSlots] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv.dataSource = self
        tv.delegate = self
        cv.dataSource = self
        cv.delegate = self
        
        bookSlotBtn.layer.cornerRadius = 5
        tvLeading.constant = 0
        tvTralling.constant = 0
        tv.isHidden=true
        DefaultsKeys.timesarr.removeAll()
        let userDefaults = UserDefaults.standard
        sectionId = userDefaults.integer(forKey: DefaultsKeys.SectionId)
        instituteId = userDefaults.integer(forKey: DefaultsKeys.SchoolD)
        staffId = userDefaults.integer(forKey: DefaultsKeys.StaffID)
        getLoginClassId = userDefaults.integer(forKey: DefaultsKeys.ClassID)
        var strChild = userDefaults.string(forKey: DefaultsKeys.chilId)
        actionTitleLbl.text = commonStringNames.ParentTeacherMeeting.translated()
        scheduleLbl.text = commonStringNames.ScheduleMeeting.translated()
        meetLbl.text = commonStringNames.MeetingHistory.translated()
        bookSlotBtn.setTitle(commonStringNames.BookSlot.translated(), for: .normal)
        studentId = Int(strChild!)
        
        
        cv.register(UINib(nibName: "PTMCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PTMCollectionViewCell")
        tv.register(UINib(nibName: cancelTvCell, bundle: nil), forCellReuseIdentifier: cancelTvCell)
        tv.register(UINib(nibName: tvcellIdentifier, bundle: nil), forCellReuseIdentifier: tvcellIdentifier)
        tv.register(UINib(nibName: teacherSlotIdentifier, bundle: nil), forCellReuseIdentifier: teacherSlotIdentifier)
        
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        selectedCell = IndexPath()
        let segments1 = UITapGestureRecognizer(target: self, action: #selector(seg1Vc))
        
        segment1.addGestureRecognizer(segments1)
        let segments2 = UITapGestureRecognizer(target: self, action: #selector(seg2Vc))
        
        segment2.addGestureRecognizer(segments2)
        segment1.backgroundColor = UIColor(named: "CheckBoxSelectColor")
        noRecordsView.isHidden = true
        noRecordsLbl.isHidden =  true
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        viewBack.addGestureRecognizer(backGesture)
        let dropDownGesture = UITapGestureRecognizer(target: self, action: #selector(DropDownVc))
        subView.addGestureRecognizer(dropDownGesture)
        slotAvailability(studId: studentId, instId: instituteId)
        cv.register(UINib(nibName: rowNib, bundle: nil), forCellWithReuseIdentifier: rowNib)
        generateDates()
        subjectListForStudent(studId: studentId, instId: instituteId)
        
        var todaysDate = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var DateInFormat = dateFormatter.string(from: todaysDate as Date)
        getEventDate = DateInFormat
        teacherWiseSlotAvailable(eventDate: getEventDate)
        tv.register(UINib(nibName: "TimeHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "TimeHeader")
        
    }
    
    
    
    func generateDates() {
        let currentDate = Date()
        for i in 0..<366 { // Including the current day
            if let futureDate = calendar.date(byAdding: .day, value: i, to: currentDate) {
                dates.append(futureDate)
                
            }
        }
        cv.reloadData()
    }
    
    
    @IBAction func DropDownVc(){
        
        var sub_names : [String] = []
        
        sub_names.append("All subjects")
        dropDownData.forEach { (field) in
            sub_names.append(field.subjectName)
            getSubjectIdArr.append(field.subjectId)
        }
        
        drop_down.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            dropDownLbl.text = item
            if item == "All subjects"{
             
            getSubjectId = 0
            ClassTeacherId = 0
            }
            else if item == "Class Teacher"{
             
            getSubjectId = 0
            ClassTeacherId = dropDownData.first?.classTeacherId ?? 0
             
            }
            else{
             
            if index < getSubjectIdArr.count {
            getSubjectId = getSubjectIdArr[index-1]
            ClassTeacherId = 0
            }
             
            }
           
            teacherWiseSlotAvailable(eventDate: getEventDate)
        }
        drop_down.dataSource = sub_names
        drop_down.anchorView = subView
        drop_down.bottomOffset = CGPoint(x: 0, y:(drop_down.anchorView?.plainView.bounds.height)!)
        drop_down.show()
        
    }
    
    @IBAction func backVc(){
        DefaultsKeys.bookingSlotId.removeAll()
        dismiss(animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dates.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rowNib, for: indexPath) as! CalendarCollectionViewCell
        
        let date = dates[indexPath.item]
        
        
        if ClickID == indexPath.row {
            cell.caleView.backgroundColor = .systemOrange
            cell.dayLbl.textColor = .white
            cell.dateLbl.textColor = .white
            cell.slotCountLbl.textColor = .white
            
        }
        else{
            cell.caleView.backgroundColor = UIColor(named: "NoDataColor")
            cell.dayLbl.textColor = .black
            cell.dateLbl.textColor = .black
            cell.slotCountLbl.textColor = .black
        }
        
        
        
        var boools = true
        
        for i in studSlotData{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" // Set your desired format
            let dateString = dateFormatter.string(from: date)
            
            if i.eventDate == dateString{
                boools = false
                print("dateString",dateString)
                cell.slotCountLbl.isHidden = boools
                
                cell.slotCountLbl.text = "Available slots " + i.count
                
            }else{
                
                cell.slotCountLbl.isHidden = boools
            }
            
        }
        
        
        
        let dateFormatter = DateFormatter()
        // Input format
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        
        
        dateFormatter.dateFormat = "yyyy"
        let formattedDate1 = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "MMM"
        let formattedDate2 = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "d"
        let formattedDate = dateFormatter.string(from: date)
        
        cell.monthLbl.text =  formattedDate2.translated()
        cell.dateLbl.text = formattedDate + "," + formattedDate1
        
        return cell
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dropDownLbl.text = "All subjects"
        DefaultsKeys.bookingSlotId.removeAll()
        bookSlotBtn.isHidden = true 
        getSubjectId = 0
        ClassTeacherId = 0
        ClickID = indexPath.row
        let selectedDate = dates[indexPath.item]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // Set your desired format
        let dateString = dateFormatter.string(from: selectedDate)
        getEventDate = dateString
        teacherWiseSlotAvailable(eventDate : getEventDate)
        
        cv.dataSource = self
        cv.delegate = self
        cv.reloadData()
        
        
    }
    
    
    
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 100)
    }
    
    
    
    @IBAction func seg1Vc(){
        
        tvLeading.constant = 0
        tvTralling.constant = 0
        segmentId = 1
        segment1.backgroundColor = UIColor(named: "CheckBoxSelectColor")
        segment2.backgroundColor = .white
        calanderHeightCon.constant = 130
        
        subView.isHidden = false
        calendarView.isHidden = false
        subviewHeight.constant = 40
        tvTop.constant = 20
        teacherWiseSlotAvailable(eventDate: getEventDate)
        noRecordsView.isHidden = true
        tv.isHidden = false
        bookSlotBtn.isHidden = false
        
    }
    @IBAction func seg2Vc(){
        segmentId = 2
        
        tvLeading.constant = 30
        tvTralling.constant = 30
        subView.isHidden = true
        calendarView.isHidden = true
        slotHistoryForParent()
        print("calanderHeightCon.constant",calanderHeightCon.constant)
        calanderHeightCon.constant = 0
        subviewHeight.constant = -20
        print("calanderHeightt",calanderHeightCon.constant)
        
        tvTop.constant = -20
        segment2.backgroundColor = UIColor(named: "CheckBoxSelectColor")
        segment1.backgroundColor = .white
        if let headerView = tv.tableHeaderView {
            headerView.isHidden = true
        }
        
        tv.tableHeaderView = nil
        bookSlotBtn.isHidden = true
        tv.isHidden = false
        tv.dataSource = self
        tv.delegate = self
        tv.reloadData()
        
    }
    
    
    
    //
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if segment1.backgroundColor == UIColor(named: "CheckBoxSelectColor") {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TimeHeader") as! TimeHeader
            headerView.meetingLbl.text = exNames[section].eventName
            headerView.modeLbl.text = exNames[section].event_mode
            headerView.nameAndSubjectLbl.text = exNames[section].subjectName + " - " + exNames[section].staff_name
            headerView.holeView.layer.cornerRadius = 8
            headerView.holeView.layer.masksToBounds = true
            headerView.holeView.layer.shadowColor = UIColor.black.cgColor
            headerView.holeView.layer.shadowOpacity = 0.5
            headerView.holeView.layer.shadowOffset = CGSize(width: 4, height: 4)
            headerView.holeView.layer.shadowRadius = 5
            headerView.holeView.layer.masksToBounds = false
            
            return headerView
        }else{
            let view = UIView()
            return view
        }
        
    }
    
    
    
    func timesBetween(start: String, end: String, intervalMinutes: Int) -> [Date] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        guard let startDate = dateFormatter.date(from: start),
              let endDate = dateFormatter.date(from: end) else {
            print("Invalid time format")
            return []
        }
        
        var times: [Date] = []
        var currentTime = startDate
        
        while currentTime <= endDate {
            times.append(currentTime)
            
            guard let nextTime = Calendar.current.date(byAdding: .minute, value: intervalMinutes, to: currentTime) else {
                break
            }
            
            currentTime = nextTime
        }
        
        return times
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if segment1.backgroundColor == UIColor(named: "CheckBoxSelectColor") {
            return  exNames.count
            
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segment1.backgroundColor == UIColor(named: "CheckBoxSelectColor") {
            return 1
        }else{
            return slotHistoryForParentData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("TVcellForRowAtcellForRowAt")
        
        if segment1.backgroundColor == UIColor(named: "CheckBoxSelectColor") {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cancelTvCell, for: indexPath) as! cancelTableViewCell
            
            let event = exNames[indexPath.section]
            cell.configure1(with: availableSlot, selectedIndex: indexPath.section)
            cell.sloSlectionDataDelegate = self
            cell.events = exNames
            cell.cv.isUserInteractionEnabled = true
            cell.backView.backgroundColor = .white
            cell.backView.layer.shadowColor = UIColor.black.cgColor
            cell.backView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.backView.layer.shadowRadius = 5
            cell.backView.layer.shadowOpacity = 0.3
            cell.backView.layer.cornerRadius = 10  //
            for i in event.slots{
                if i.isBooked == 1{
                    cell.cv.isUserInteractionEnabled = false
                    cell.backView.backgroundColor = .systemGray5
                }
            }
            
            return cell
            
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: teacherSlotIdentifier, for: indexPath) as! StaffPtmTableViewCell
            
            cell.backView.layer.cornerRadius = 20
            cell.backView.layer.masksToBounds = true
            cell.backView.layer.shadowColor = UIColor.black.cgColor
            cell.backView.layer.shadowOpacity = 0.5
            cell.backView.layer.shadowOffset = CGSize(width: 4, height: 4)
            cell.backView.layer.shadowRadius = 1
            cell.backView.layer.masksToBounds = false
            cell.statusview.layer.masksToBounds = true
            cell.statusview.layer.shadowColor = UIColor.white.cgColor
            cell.statusview.layer.shadowOpacity = 0.5
            cell.statusview.layer.shadowOffset = CGSize(width: 4, height: 4)
            cell.statusview.layer.shadowRadius = 5
            cell.statusview.layer.masksToBounds = false
            
            var slotHistort : SlotHistoryForParentResponseData = slotHistoryForParentData[indexPath.row]
            
            cell.cancelAndReponeView.isHidden = true
            
            if slotHistort.status == "Upcoming" {
                
                cell.cancelView.isHidden = false
                
            }else{
                
                cell.cancelView.isHidden = true
                
            }
            
            
            let cancelGes = CanelSlotGesture(target: self, action: #selector(slotCancelAct))
            
            cancelGes.slotId = Int(slotHistort.slot_id)
            cell.cancelView.addGestureRecognizer(cancelGes)
            
            cell.eventName.text = slotHistort.purpose
            
            cell.studentName.text = slotHistort.staff_name
            
            cell.statusLbl.text = slotHistort.status
            
            cell.dateAndTimeLbl.text = slotHistort.slot_date
            
            cell.zoomLbl.text =  " Mode - " + slotHistort.mode
            if slotHistort.status == "Completed" {
                cell.statusLbl.textColor = UIColor(named: "completed")
            } else if slotHistort.status == "Available" {
                cell.statusLbl.textColor = .systemCyan
            } else if slotHistort.status == "Upcoming" {
                cell.statusLbl.textColor = .systemCyan
            }else if slotHistort.status == "Expired" {
                cell.statusLbl.textColor = UIColor(named: "Expried")
            }else if slotHistort.status == "Cancelled" {
                cell.statusLbl.textColor = UIColor(named: "Expried")
            }else{
                cell.statusLbl.textColor = UIColor(named: "Expried")
            }
            if slotHistort.event_link == ""{
                
                cell.eventLink.isHidden = true
                
            }else{
                
                cell.eventLink.isHidden = false
                
                cell.eventLink.isUserInteractionEnabled = true
                let click = LinkSClicks(target: self, action: #selector(linkClickVC))
                click.link = slotHistort.event_link
                cell.eventLink.addGestureRecognizer(click)
                
                
            }
            
            
            let eventDate = slotHistort.slot_date
            let dateFormatter = DateFormatter()
            // Input format
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if let date = dateFormatter.date(from: eventDate!) {
                
                dateFormatter.dateFormat = "E, MMM d, yyyy"
                let formattedDate = dateFormatter.string(from: date)
                
                cell.dateAndTimeLbl.text = formattedDate + "," + slotHistort.slot_time
                print(formattedDate)
            } else {
                print("Invalid date format")
            } // date converstion End
            
            return cell
            
        }
        
    }
    
    
    
    @IBAction func linkClickVC(ges: LinkSClicks){
        print("linkClickVC")
        openZoomLink(eventLink: ges.link)
    }
    
    func openZoomLink(eventLink: String) {
        // Encode the URL string to handle spaces and special characters
        guard let encodedLink = eventLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedLink) else {
            print("Invalid URL")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            // The app is installed, open the link in the app
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // The app is not installed, redirect to the App Store
            let appStoreLink = "https://apps.apple.com/us/app/zoom-cloud-meetings/id546505307" // Zoom's App Store URL
            if let appStoreURL = URL(string: appStoreLink) {
                UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let selectedSlotCount = availableSlot[indexPath.section].slots.count
        
//        if segment1.backgroundColor == UIColor(named: "CheckBoxSelectColor") {
//            return CGFloat(selectedSlotCount * 34)
//        } else {
            return UITableView.automaticDimension
//        }
    }
    
    func groupSlotsByStaffEventSubject(apiResponse: GetTeacherwiseSlotAvailabilityResponse) -> [Event] {
        
        var eventDict: [String: Event] = [:]
        for slotData in apiResponse.data {
            
            let key = "\(slotData.staff_id)-\(slotData.event_name)-\(slotData.subject_name)"
            let slot = Slot(fromTime: slotData.from_time, toTime: slotData.to_time, slotId: slotData.slot_id,isBooked: slotData.is_booked, isSelected: false)
            if var event = eventDict[key] {
                event.slots.append(slot)
                eventDict[key] = event
            } else {
                let newEvent = Event(staffId: slotData.staff_id, eventName: slotData.event_name, subjectName: slotData.subject_name, staff_name: slotData.staff_name, event_mode: slotData.event_mode, slots: [slot])
                eventDict[key] = newEvent
            }
            
        }
        return Array(eventDict.values)
        
    }
    
    func processAPIResponse(_ responseData: [SlotModel]) {
        var slotDict: [String: [SlotModel]] = [:]
        
        for slot in responseData {
            let key = "\(slot.eventName)-\(slot.staffID)-\(slot.subjectName)"
            slotDict[key, default: []].append(slot)
        }
        
        groupedSlots = slotDict.map { key, value in
            let components = key.split(separator: "-")
            return GroupedSlots(
                eventName: String(components[0]),
                staffID: Int(components[1]) ?? 0,
                subjectName: String(components[2]),
                slots: value
            )
        }
        
        tv.reloadData()
    }
    
    
    
    @objc func slotClick(gets : CanelSlotGesture ) {
        teacherWiseSlotAvailable(eventDate: gets.slotDate)
    }
    
    func teacherWiseSlotAvailable(eventDate : String) {
        
        duplicateStaffTimes.removeAll()
        
        print("CONDTION")
        
        DefaultsKeys.date.removeAll()
        
        let param : [String : Any] =
        
        [
            
            "event_date": eventDate,
            
            "student_id": studentId!,
            
            "subject_id": getSubjectId,
            
            "class_teacher_id": ClassTeacherId,
            
            "institute_id": instituteId
            
        ]
        
        print(param)
        
        GetTeacherWiseSlotAvailabilityRequest.call_request(param: param){ [self]
            
            (res) in
            
            
            
            let teacherWiseSlotResponse : GetTeacherwiseSlotAvailabilityResponse = Mapper<GetTeacherwiseSlotAvailabilityResponse>().map(JSONString: res)!
            
            availableSlot.removeAll()
            if teacherWiseSlotResponse.Status == 1  {
                let groupedEvents = groupSlotsByStaffEventSubject(apiResponse: teacherWiseSlotResponse)
                for i in 0..<groupedEvents.count {
                    var times = [SlotTime]()  // Correct type for SlotTime array
                    var isBooked = false
                    for j in 0..<groupedEvents[i].slots.count {
                        let timeString = "\(groupedEvents[i].slots[j].fromTime) - \(groupedEvents[i].slots[j].toTime)"
                        if groupedEvents[i].slots[j].isBooked == 1{
                            isBooked = true
                            times.append(SlotTime(time: timeString, select: 1, SoltId: groupedEvents[i].slots[j].slotId)) // Correct `SlotTime` appending logic
                        }else{
                            
                            times.append(SlotTime(time: timeString, select: 0, SoltId: groupedEvents[i].slots[j].slotId))
                        }
                    }
                    availableSlot.append(AvailableSlot(id: i, isBooked:isBooked, slots: times)) // Correct structure creation
                }
                exNames = groupedEvents
                tv.isHidden = false
                noRecordsView.isHidden = true
                noRecordsLbl.isHidden =  true
                markOverlappingSlots()
                tv.reloadData()
                cv.reloadData()
            }else{
                bookSlotBtn.isHidden = true
                noRecordsView.isHidden = false
                noRecordsLbl.isHidden =  false
                noRecordsLbl.text = teacherWiseSlotResponse.Message
                tv.isHidden = true
            }
        }
    }
    // Step 1: Identify the selected slot with select = 1
    func markOverlappingSlots() {
        for (sectionIndex, slots) in availableSlot.enumerated() {
            for (rowIndex, slot) in slots.slots.enumerated() {
                if slot.select == 1 { // Found the selected slot
                    let selectedTimeRange = slot.time.components(separatedBy: " - ")
                    
                    guard let selectedFrom = convertToDate(selectedTimeRange.first ?? ""),
                          let selectedTo = convertToDate(selectedTimeRange.last ?? "") else {
                        return
                    }
                    
                    // Step 2: Check for overlaps in the entire array
                    for (innerSectionIndex, innerSlots) in availableSlot.enumerated() {
                        for (innerRowIndex, innerSlot) in innerSlots.slots.enumerated() {
                            let slotTimeRange = innerSlot.time.components(separatedBy: " - ")
                            
                            guard let slotFrom = convertToDate(slotTimeRange.first ?? ""),
                                  let slotTo = convertToDate(slotTimeRange.last ?? "") else {
                                continue
                            }
                            
                            // Skip marking the selected slot itself
                            if innerSlot.select == 1 {
                                continue
                            }
                            
                            // Overlapping condition
                            if (slotFrom < selectedTo) && (slotTo > selectedFrom) {
                                availableSlot[innerSectionIndex].slots[innerRowIndex].select = 2
                            } else if availableSlot[innerSectionIndex].slots[innerRowIndex].select == 2 {
                                availableSlot[innerSectionIndex].slots[innerRowIndex].select = 0
                            }
                        }
                    }
                    return // Break out of the loop once the selected slot is found
                }
            }
        }
    }
    
    func convertToDate(_ timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.date(from: timeString)
    }
    
    func subjectListForStudent(studId : Int,instId : Int) {
        
        let param : [String : Any] =
        
        [
            "student_id": studId,
            "institute_id": instId
        ]
        SubjectListForStudentRequest.call_request(param: param){ [self]
            
            (res) in
            let teacherWiseSlotResponse : SubjectListForStudentResponse = Mapper<SubjectListForStudentResponse>().map(JSONString: res)!
            if teacherWiseSlotResponse.Status == 1  {
                dropDownData = teacherWiseSlotResponse.data
                bookSlotBtn.isHidden = false
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
            }else{
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }
        }
    }
    
    func slotAvailability(studId : Int,instId : Int) {
        
        let param : [String : Any] =
        
        [
            "student_id": studId,
            "institute_id": instId
            
        ]
        SlotAvailablityForStudentRequest.call_request(param: param){ [self]
            
            (res) in
            let slotAvailabilityResponse : SlotAvailabilityForStudentsResponse = Mapper<SlotAvailabilityForStudentsResponse>().map(JSONString: res)!
            if slotAvailabilityResponse.Status == 1  {
                
                
                studSlotData = slotAvailabilityResponse.data
                
                cv.dataSource = self
                cv.delegate = self
                cv.reloadData()
            }else{
                cv.dataSource = self
                cv.delegate = self
                cv.reloadData()
            }
            
        }
    }
    
    func bookingSlot() {
        let bookingSlotsForStudModal = BookingSlotsForStudModal()
        bookingSlotsForStudModal.student_id = studentId
        bookingSlotsForStudModal.slot_id  = DefaultsKeys.bookingSlotId
        bookingSlotsForStudModal.institute_id = instituteId
        var  bookingSlotsForStudModalStr = bookingSlotsForStudModal.toJSONString()
        BookSlotsForStudentRequest.call_request(param: bookingSlotsForStudModalStr!) {
            [self] (res) in
            let bookingSlotsForStudRes : BookingSlotsForStudentsResponse = Mapper<BookingSlotsForStudentsResponse>().map(JSONString: res)!
            if bookingSlotsForStudRes.Status == 1 {
                DefaultsKeys.bookingSlotId.removeAll()
                
                let refreshAlert = UIAlertController(title: "", message: bookingSlotsForStudRes.Message, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                    
                    dismiss(animated: true)
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction  func slotCancelAct(ges : CanelSlotGesture){
        let alertController = UIAlertController(title: commonStringNames.Alert.translated(),
                                                message: "Reason for Cancel",
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            
            textField.placeholder = "Reason"
            
            textField.textColor = .blue
            
            textField.clearButtonMode = .whileEditing
            
            textField.borderStyle = .roundedRect
            
        }
        let okAction = UIAlertAction(title: commonStringNames.OK.translated(), style: .default) { [self] action in
            
            if let textFields = alertController.textFields,
               
                let nameField = textFields.first {
                
                
                
                if nameField.text != "" {
                    cancelSlot(slotId: ges.slotId,SlotReason: nameField.text!)
                }else{
                    self.view.makeToast("Enter Reason")
                }
            }
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func cancelAndClose() {
        
        
        let cancelSlotsForStudModal = CancelAndCloseSlotByStaffModal()
        cancelSlotsForStudModal.slot_id = 49
        
        cancelSlotsForStudModal.staff_id = staffId
        
        cancelSlotsForStudModal.institute_id = instituteId
        var  cancelSlotsForStudModalStr = cancelSlotsForStudModal.toJSONString()
        CancelSlotByParentRequest.call_request(param: cancelSlotsForStudModalStr!) {
            [self] (res) in
            let cancelSlotsForStudRes : CancelSlotsForStudentsResponse = Mapper<CancelSlotsForStudentsResponse>().map(JSONString: res)!
        }
    }
    
    func slotHistoryForParent() {
        let param : [String : Any] =
        
        [
            "student_id": studentId!,
            "section_id": sectionId,
            "class_id":  getLoginClassId!,
            "institute_id": instituteId
        ]
        SlotHistoryForStudentRequest.call_request(param: param){ [self]
            
            (res) in
            let slotHistoryResponse : SlotHistoryForParentResponse = Mapper<SlotHistoryForParentResponse>().map(JSONString: res)!
            if slotHistoryResponse.Status == 1  {
                slotHistoryForParentData = slotHistoryResponse.data
                noRecordsView.isHidden = true
                noRecordsLbl.isHidden =  true
                if let headerView = tv.tableHeaderView {
                    headerView.isHidden = true
                }
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
            }else{
                if let headerView = tv.tableHeaderView {
                    headerView.isHidden = true
                }
                noRecordsView.isHidden = false
                noRecordsLbl.isHidden =  false
                noRecordsLbl.text = slotHistoryResponse.Message
                
            }
        }
    }
    
    
    
    func cancelSlot(slotId : Int,SlotReason : String) {
        
        let cancelSlotsForStudModal = CancelSlotsForStudModal()
        cancelSlotsForStudModal.student_id = studentId
        
        cancelSlotsForStudModal.slot_id = slotId
        
        cancelSlotsForStudModal.cancelled_reason = SlotReason
        
        cancelSlotsForStudModal.institute_id = instituteId
        var  cancelSlotsForStudModalStr = cancelSlotsForStudModal.toJSONString()
        CancelSlotByParentRequest.call_request(param: cancelSlotsForStudModalStr!) {
            
            [self] (res) in
            let cancelSlotsForStudRes : CancelSlotsForStudentsResponse = Mapper<CancelSlotsForStudentsResponse>().map(JSONString: res)!
            
            if cancelSlotsForStudRes.Status == 1 {
                let alert = UIAlertController(title: "", message: cancelSlotsForStudRes.Message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion:{ [self] in
                    
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()
                    alert.view.superview?.isUserInteractionEnabled = true
                    
                })
            }else{
                let alert = UIAlertController(title: commonStringNames.Alert.translated(), message: cancelSlotsForStudRes.Message, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: commonStringNames.OK.translated(), style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion:{ [self] in
                    tv.dataSource = self
                    tv.delegate = self
                    tv.reloadData()
                    alert.view.superview?.isUserInteractionEnabled = true
                })
            }
        }
    }
    
    
    
    @IBAction func bookSlotAct(_ sender: Any) {
        if DefaultsKeys.bookingSlotId.count == 0{
            
            let refreshAlert = UIAlertController(title: "", message: "Select time", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                
                
            }))
            present(refreshAlert, animated: true, completion: nil)
            
        }else{
            let refreshAlert = UIAlertController(title: "", message: "Are you sure do you want to Book Slot?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] (action: UIAlertAction!) in
                
                bookingSlot()
                
            }))
            
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    override open var shouldAutorotate: Bool
    
    {
        return false
        
    }
}

class CanelSlotGesture : UITapGestureRecognizer {
    var slotId : Int!
    var slotDate : String!
    var ViewColorChange : UIView!
    var pos : Int!
    var selectClickId : Int!
}


class Slot: Codable {
    let fromTime: String
    let toTime: String
    let slotId: Int
    let isBooked: Int
    var isSelected: Bool = false
    init(fromTime: String, toTime: String, slotId: Int, isBooked: Int, isSelected: Bool) {
        self.fromTime = fromTime
        self.toTime = toTime
        self.slotId = slotId
        self.isBooked = isBooked
        self.isSelected = isSelected
    }
}

struct Event: Codable {
    
    let staffId: Int
    let eventName: String
    let subjectName: String
    let staff_name: String
    let event_mode: String
    var slots: [Slot]
    
}
// Define the ApiResponse model

struct SlotData: Codable {
    let event_link: String
    let event_name: String
    let from_time: String
    let is_booked: Int
    let my_booking: Int
    let slot_id: Int
    let staff_id: Int
    let subject_name: String
    let to_time: String
}

struct ApiResponse: Codable {
    let Message: String
    let Status: Int
    let data: [SlotData]
}

class LinkSClicks : UITapGestureRecognizer{
    var link  : String!
    var slotid : Int!
}



struct SlotModel: Codable {
    let slotID: Int
    let fromTime: String
    let toTime: String
    let isBooked: Int
    let staffID: Int
    let staffName: String
    let subjectName: String
    let eventName: String
    let eventMode: String
    var isSelected: Bool = false  // To track selection
}

struct GroupedSlots {
    let eventName: String
    let staffID: Int
    let subjectName: String
    var slots: [SlotModel]
}
struct AvailableSlot{
    let id:Int
    var isBooked:Bool
    var slots:[SlotTime]
    
}
struct SlotTime{
    let time:String
    var select:Int
    var SoltId : Int
}
