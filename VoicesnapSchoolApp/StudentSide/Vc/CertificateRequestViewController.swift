//
//  CertificateRequestViewController.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import UIKit
import ObjectMapper
import DropDown

class CertificateRequestViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,UITextViewDelegate{
    
    @IBOutlet weak var selUrgLbl: UILabel!
    @IBOutlet weak var selCertLbl: UILabel!
    @IBOutlet weak var noRecordLbl: UILabel!
    
    @IBOutlet weak var noRecordVieww: UIView!
    
    @IBOutlet weak var adViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var reasonViewHide: UIView!
    @IBOutlet weak var reqDataShowView: UIView!
    @IBOutlet weak var selectCertificateLbl: UILabel!
    
    @IBOutlet weak var urgencyLbl: UILabel!
    
    @IBOutlet weak var reqCetLbl: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var selectCertificateView: UIView!
    @IBOutlet weak var text_view: UITextView!
    @IBOutlet weak var requestCertificateView: UIView!
    @IBOutlet weak var selectUrgencyView: UIView!
    
    @IBOutlet weak var actionCertiLbl: UILabel!
    
    @IBOutlet weak var actReqLBl: UILabel!
    var  paraentRequestList : [ParentRequestListData] = []
    let rowIdentifier =  "CertificatesTableViewCell"
    var certificate_data : [certificateData] = []
    var urgency_level : [String] = []
    
    //    var parentData : [ParentRequestListData] =[]
    
    var drop_down = DropDown()
    var SchoolIDString = String()
    let placeholder = "Reason for Certificate"
    var ChildIDString = String()
    var getadID : Int!
    
    var imgaeURl : String  = ""
    var AdName : String  = ""
    var imageCount : Int  = 0
    var firstImage : Int  = 0
    weak var timer: Timer?
    var ChildId  = String()
    var SchoolId  = String()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var menuId : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        actReqLBl.text = commonStringNames.CertificateOnly.translated()
        actionCertiLbl.text = commonStringNames.CertificateOnly.translated()
        reqCetLbl.text = commonStringNames.RequestCertificate.translated()
        selCertLbl.text = commonStringNames.SelectCertificate.translated()
        selUrgLbl.text = commonStringNames.SelectUrgencyLevel.translated()
        SchoolId = String(describing: appDelegate.SchoolDetailDictionary["SchoolID"]!)
        
        ChildId = String(describing: appDelegate.SchoolDetailDictionary["ChildID"]!)
        print("ChildId",ChildId)
        print("SchoolId",SchoolId)
        getRequestData()
        //        pickCertificates()
        
        tv.isHidden = true
        noRecordVieww.isHidden = true
        noRecordLbl.isHidden = true
        
        let segAttributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        segControl.setTitleTextAttributes(segAttributes as! [NSAttributedString.Key : Any], for: UIControl.State.selected)
        text_view.delegate = self
        text_view.text = placeholder
        
        let certificateGes = UITapGestureRecognizer(target: self, action: #selector(pickCertificates))
        selectCertificateView.addGestureRecognizer(certificateGes)
        
        
        let reqCertificateGes = UITapGestureRecognizer(target: self, action: #selector(createOtherRequest))
        requestCertificateView.addGestureRecognizer(reqCertificateGes)
        
        let urgencyGes = UITapGestureRecognizer(target: self, action: #selector(pickUrgencyLevel))
        selectUrgencyView.addGestureRecognizer(urgencyGes)
        
        
        let backGest = UITapGestureRecognizer(target: self, action: #selector(backVc))
        viewBack.addGestureRecognizer(backGest)
        
        async {
            //                    // 1
            await AdConstant.AdRes(memId: ChildId, memType: "student", menu_id: AdConstant.getMenuId as String as String, school_id: SchoolId)
            print("menu_id:\(AdConstant.getMenuId)")
            
            menuId = AdConstant.getMenuId as String
            
            
        }
        
        async {
            do {
                //
                menuId = AdConstant.getMenuId as String
                print("menu_id:\(AdConstant.getMenuId)")
                
                
                
                let AdModal = AdvertismentModal()
                AdModal.MemberId = ChildId
                AdModal.MemberType = "student"
                if AdConstant.mgmtVoiceType == "1" {
                    AdModal.MenuId = "0"
                }
                AdModal.MenuId = menuId
                AdModal.SchoolId = SchoolId
                
                
                let admodalStr = AdModal.toJSONString()
                
                
                print("admodalStr2222",admodalStr)
                AdvertismentRequest.call_request(param: admodalStr!) { [self]
                    
                    (res) in
                    
                    let adModalResponse : [AdvertismentResponse] = Mapper<AdvertismentResponse>().mapArray(JSONString: res)!
                    
                    
                    
                    for i in adModalResponse {
                        if i.Status.elementsEqual("1") {
                            print("AdConstantadDataListtt",AdConstant.adDataList.count)
                            
                            
                            
                            
                            AdConstant.adDataList.removeAll()
                            AdConstant.adDataList = i.data
                            
                            startTimer()
                            
                        }else{
                            
                        }
                        
                    }
                    
                    print("admodalStr_count", AdConstant.adDataList .count)
                    
                    
                    
                    
                }
                
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        
        
        let imgTap = AdGesture(target: self, action: #selector(viewTapped))
        adView.addGestureRecognizer(imgTap)
        
        
        tv.register(UINib(nibName: rowIdentifier, bundle: nil), forCellReuseIdentifier: rowIdentifier)
    }
    
    
    @IBAction func backVc() {
        dismiss(animated: true)
    }
    
    func startTimer() {
        if AdConstant.adDataList.count > 0 {
            
            let url : String =  AdConstant.adDataList[0].contentUrl!
            self.imgaeURl = AdConstant.adDataList[0].redirectUrl!
            self.AdName = AdConstant.adDataList[0].advertisementName!
            self.getadID = AdConstant.adDataList[0].id!
            self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            
            adView.isHidden = false
            adViewHeight.constant = 80
            
            if(self.firstImage == 0){
                self.imageCount =  1
            }
            else{
                self.imageCount =  0
            }
            
            let minC : Int = UserDefaults.standard.integer(forKey: ADTIMERINTERVAL)
            print("minC",minC)
            var AdSec = String(minC / 1000)
            print("minutesBefore",AdSec)
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(AdSec)!, repeats: true) { [weak self] _ in
                
                
                if(AdConstant.adDataList.count == self!.imageCount){
                    self!.imageCount = 0
                    self!.firstImage = 1
                }
                
                self!.imageCount = self!.imageCount + 1
                
                let url : String =  AdConstant.adDataList[self!.imageCount-1].contentUrl!
                self!.imgaeURl = AdConstant.adDataList[self!.imageCount-1].redirectUrl!
                self!.AdName = AdConstant.adDataList[self!.imageCount-1].advertisementName!
                self!.getadID = AdConstant.adDataList[self!.imageCount-1].id!
                
                self!.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
            }
        }else {
            adView.isHidden = true
            adViewHeight.constant = 0
        }
    }
    
    func stopTimer() {
        print("Stopped timer")
        timer?.invalidate()
    }
    
    @IBAction func viewTapped() {
        
        
        if imgaeURl.isEmpty != true {
            let vc = AdRedirectViewController(nibName: nil, bundle: nil)
            
            
            vc.advertisement_Name = AdName
            vc.redirect_urls = imgaeURl
            vc.adIdget = getadID
            vc.getMenuID = menuId
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
            
        }else{
            print("isEmpty")
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startTimer()
    }
    
    
    @IBAction func segAction(_ sender: UISegmentedControl) {
        
        
        if segControl.selectedSegmentIndex == 0 {
            tv.isHidden = true
            reasonViewHide.isHidden = false
            reqDataShowView.isHidden = false
            requestCertificateView.isHidden = false
            getRequestData()
        }else if segControl.selectedSegmentIndex == 1 {
            tv.isHidden = false
            reasonViewHide.isHidden = true
            requestCertificateView.isHidden = true
            reqDataShowView.isHidden = true
            getcertificateData()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paraentRequestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath) as! CertificatesTableViewCell
        
        
        let list : ParentRequestListData = paraentRequestList[indexPath.row]
        
        cell.conductTypeLbl.text = list.requested_for
        cell.createdOnLbl.text = list.created_on
        cell.statusLbl.text = list.is_issued_on_app
        cell.reasonLbl.text = list.reason
        
        print("list.certificate_url",list.certificate_url)
        if list.certificate_url  != "" && list.certificate_url != nil{
            cell.pdfView.isHidden = false
            cell.viewHeight.constant = 42
            cell.pdfView.isUserInteractionEnabled = true
            let pdfGes = PdfLoadGesture(target: self, action: #selector(pdfRedirect))
            pdfGes.pdfUrl = list.certificate_url
            print("list.certificate_url",list.certificate_url)
            cell.pdfView.addGestureRecognizer(pdfGes)
        }else{
            cell.viewHeight.constant = 0
            cell.pdfView.isHidden = true
            cell.pdfView.isUserInteractionEnabled = false
            print("empty Not working")
            
        }
        
        
        return cell
    }
    
    
    @IBAction func pdfRedirect(ges : PdfLoadGesture) {
        let vc = PdfVcViewController(nibName: nil, bundle: nil)
        vc.webViewUrl = ges.pdfUrl
        vc.schoolId = SchoolId
        vc.childId = ChildId
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let list : ParentRequestListData = paraentRequestList[indexPath.row]
        if list.certificate_url  != "" && list.certificate_url != nil{
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    
    
    
    
    func getRequestData() {
        
        noRecordVieww.isHidden = true
        noRecordLbl.isHidden = true
        
        
        CertificateTypesRequest.call_request(){
            
            [self] (res) in
            
            let certificateType : [CertificateTypsResponse] = Mapper<CertificateTypsResponse>().mapArray(JSONString: res)!
            
            
            for i in certificateType {
                certificate_data = i.certificate_data
                let getdata : certificateData  = certificate_data[0]
                
                selectCertificateLbl.text = getdata.certificate_name
                urgency_level = i.urgenctList
                
                urgencyLbl.text = urgency_level[0]
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func pickCertificates() {
        
        
        
        print("dropDownWorked")
        var certificate_names : [String] = []
        
        
        certificate_data.forEach { (certificate) in
            certificate_names.append(certificate.certificate_name)
            
        }
        
        drop_down.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            selectCertificateLbl.text = item
            
            
        }
        
        drop_down.dataSource = certificate_names
        drop_down.anchorView = selectCertificateView
        drop_down.bottomOffset = CGPoint(x: 0, y:(drop_down.anchorView?.plainView.bounds.height)!)
        drop_down.show()
        
    }
    
    
    func getcertificateData() {
        
        
        
        let parentReq = ParentRequestListModal()
        parentReq.student_id = ChildId
        
        var  parentReqStr = parentReq.toJSONString()
        
        ParentListRequest.call_request(param: parentReqStr!) {
            
            [self] (res) in
            
            let parentList : [ParentRequestListResponse] = Mapper<ParentRequestListResponse>().mapArray(JSONString: res)!
            
            
            for i in parentList {
                paraentRequestList = i.dataList
            }
            
            
            if paraentRequestList.count == 0 {
                noRecordVieww.isHidden = false
                noRecordLbl.isHidden = false
                noRecordLbl.text = "No Records"
            }else{
                noRecordVieww.isHidden = true
                noRecordLbl.isHidden = true
                noRecordLbl.text = ""
            }
            tv.dataSource = self
            tv.delegate = self
            tv.reloadData()
            
        }
        
    }
    
    
    
    
    
    @IBAction  func createOtherRequest() {
        
        if text_view.text.isEmpty == true || text_view.text == "Reason for Certificate" {
            
            let alert = UIAlertController(title: "Alert", message: "Please Enter the Reason", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            
            let otherReq = CreateOtherReqModal()
            otherReq.student_id = ChildId
            otherReq.instituteId = SchoolId
            otherReq.requested_for =  selectCertificateLbl.text
            otherReq.reason = text_view.text
            otherReq.urgency_level = urgencyLbl.text
            
            
            var  otherReqStr = otherReq.toJSONString()
            print("otherReqStr",otherReqStr)
            
            CreateOtherRequest.call_request(param: otherReqStr!) {
                
                [self] (res) in
                
                let otherReqResponse : [CreateOtherReqResponse] = Mapper<CreateOtherReqResponse>().mapArray(JSONString: res)!
                
                
                for i in otherReqResponse {
                    if i.Status.elementsEqual("1"){
                        _ = SweetAlert().showAlert("", subTitle: i.Message, style: .none, buttonTitle: "Ok", buttonColor: .gray){
                            (okClick) in
                            if okClick{
                                dismiss(animated: true)
                            }else{
                            }
                        }
                    }
                }
                
                
                
                
                
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if(text_view.text == placeholder)
        {
            text_view.text = ""
            text_view.textColor = UIColor.black
        }
        return true
    }
    
    
    @IBAction func pickUrgencyLevel() {
        
        print("drop")
        var urgency_levels_name : [String] = []
        
        urgency_level.forEach { (urgencyLvl) in
            
            urgency_levels_name.append(urgencyLvl)
        }
        
        drop_down.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            urgencyLbl.text = item
            
            
        }
        
        drop_down.dataSource = urgency_levels_name
        drop_down.anchorView = selectUrgencyView
        drop_down.bottomOffset = CGPoint(x: 0, y:(drop_down.anchorView?.plainView.bounds.height)!)
        drop_down.show()
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}



class PdfLoadGesture : UITapGestureRecognizer {
    var pdfUrl : String!
}
