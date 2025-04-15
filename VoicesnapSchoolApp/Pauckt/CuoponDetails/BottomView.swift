//
//  BottomView.swift
//  rewardDesign
//
//  Created by admin on 18/02/25.
//

import UIKit
import ObjectMapper
protocol AddCoupen{
    func addpucket()
}
class BottomView: UIViewController, AddCoupen{
    func addpucket() {
        coupenAdded = true
       // tv.reloadData()
    }
    private var confettiLayer: CAEmitterLayer?
    private var isAnimating = true
    private let confetti1: ConfettiView = .right

    @IBOutlet weak var ActiveBrrandLogoImg: UIImageView!
    @IBOutlet weak var ActiveBrandName: UILabel!
    @IBOutlet weak var ActiveCategoryLbl: UILabel!
    @IBOutlet weak var ActiveOfferDetailsLbl: UILabel!
    @IBOutlet weak var QrcodeImage: UIImageView!
    @IBOutlet weak var ActiveEpiryDateLbl: UILabel!
    @IBOutlet weak var ActivatedUsageDetails: UILabel!
    @IBOutlet weak var CouponCopyBtn: UIButton!
    @IBOutlet weak var CouponCodeFld: UITextField!
    @IBOutlet weak var CategoryLbl: UILabel!
    @IBOutlet weak var temsAndCondtionImage: UIImageView!
    @IBOutlet weak var howtoUseDropImage: UIImageView!
    @IBOutlet weak var GoToMyPauket: UIButton!
    @IBOutlet weak var branchYoucanClaimLbl: UILabel!
    @IBOutlet weak var activateImageView: UIImageView!
    @IBOutlet weak var activateValidateLbl: UILabel!
    @IBOutlet weak var howTouseLbl: UILabel!
    @IBOutlet weak var temsAndCondionsLbl: UILabel!
    @IBOutlet weak var activateCouponLocationLbl: UILabel!
    @IBOutlet weak var activateCuponTitleLbl: UILabel!
    @IBOutlet weak var activateDiscound: UILabel!
    @IBOutlet weak var temsAndCondionStack: UIStackView!
    @IBOutlet weak var howTouseStack: UIStackView!
    @IBOutlet weak var youCanClaimStack: UIStackView!
    @IBOutlet weak var reedimFullView: UIView!
    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var activatePageView: UIView!
    @IBOutlet weak var BranchesClaimHorizontal: UIStackView!
    @IBOutlet weak var BranchesDropdownImg: UIImageView!
    @IBOutlet weak var BranchesYouCanClaimDefLbl: UILabel!
    @IBOutlet weak var HowtoUseHorizontal: UIStackView!
    @IBOutlet weak var TermsAndCondHorizontal: UIStackView!
    @IBOutlet weak var OrdernowBtn: UIButton!
    @IBOutlet weak var ActivateBtn: UIButton!
    
    @IBOutlet weak var HowtouseDefLbl: UILabel!
    
    @IBOutlet weak var TermsAndCondDefLbl: UILabel!
    
    
    var coupenAdded = false
    var campian : [CampaignDetails] = []
    var source_link : String?
    var DataArray : [String] = []
    var category : String?
    var Coupon : [coupondetails] = []
    var sourceLink : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reedimFullView.isHidden = true
        qrCodeView.isHidden = true
        GoToMyPauket.isHidden = true
        youCanClaimStack.isHidden = true
        temsAndCondionsLbl.isHidden = true
        howTouseLbl.isHidden = true
        branchYoucanClaimLbl.isHidden = true
        OrdernowBtn.isHidden = true
        activatePageView.layer.cornerRadius = 20
        
        OrdernowBtn.layer.cornerRadius = 20
        GoToMyPauket.layer.cornerRadius = 20
        GoToMyPauket.layer.borderWidth = 1
        GoToMyPauket.layer.borderColor = UIColor.black.cgColor
        
        ActiveBrandName.setFont(style: .body, size: 15)
        ActiveCategoryLbl.setFont(style: .body, size: 13)
        ActiveOfferDetailsLbl.setFont(style: .title, size: 17)
        ActiveEpiryDateLbl.setFont(style: .body, size: 13)
        CategoryLbl.setFont(style: .body, size: 15)
        activateDiscound.setFont(style: .title, size: 15)
        activateCuponTitleLbl.setFont(style: .body, size: 14)
        activateCouponLocationLbl.setFont(style: .body, size: 13)
        activateValidateLbl.setFont(style: .body, size: 13)
        
        ActivatedUsageDetails.setFont(style: .body, size: 14)
        BranchesYouCanClaimDefLbl.setFont(style: .body, size: 15)
        branchYoucanClaimLbl.setFont(style: .body, size: 15)
        howTouseLbl.setFont(style: .body, size: 15)
        branchYoucanClaimLbl.setFont(style: .body, size: 15)
        HowtouseDefLbl.setFont(style: .body, size: 15)
        TermsAndCondDefLbl.setFont(style: .body, size: 15)
        temsAndCondionsLbl.setFont(style: .body, size: 15)
        
        OrdernowBtn.setTitleFont(style: .secondary, size: 14)
        GoToMyPauket.setTitleFont(style: .secondary, size: 14)
        ActivateBtn.setTitleFont(style: .secondary, size: 14)
        
        CouponCodeFld.isEnabled = false
        
        GetcampaigsDetails()
        
        CategoryLbl.text = category
        
        let temsAndCondionTapGesture = UITapGestureRecognizer(target: self, action: #selector(dropClick))
        temsAndCondionStack.addGestureRecognizer(temsAndCondionTapGesture)
        
        let howtoUSe = UITapGestureRecognizer(target: self, action: #selector(HowTouse))
        howTouseStack.addGestureRecognizer(howtoUSe)
        
        let BranchesCanTap = UITapGestureRecognizer(target: self, action: #selector(BranchesClaim))
        youCanClaimStack.addGestureRecognizer(BranchesCanTap)
        
        addDashedBorder(to: CouponCodeFld)
    }
    
    func addDashedBorder(to textField: UITextField) {
        let border = CAShapeLayer()
        border.strokeColor = UIColor.systemGreen.cgColor
        border.lineDashPattern = [4, 4] // 4 points dashed, 4 points space
        border.frame = textField.bounds
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: textField.bounds, cornerRadius: textField.layer.cornerRadius).cgPath
        textField.layer.addSublayer(border)
    }

    
    @IBAction func CopyBtnAct(_ sender: Any) {
        
        guard let text = CouponCodeFld.text, !text.isEmpty else {
                    print("Text field is empty")
                    return
                }

                // Copy the text to the clipboard
                UIPasteboard.general.string = text
                print("Text copied to clipboard: \(text)")
    }
    
    @IBAction func dropClick() {
        
        temsAndCondionsLbl.isHidden.toggle()
        
    }
    
    @IBAction func HowTouse() {
        
        howTouseLbl.isHidden.toggle()
        
    }
    
    @IBAction func BranchesClaim() {
        
        branchYoucanClaimLbl.isHidden.toggle()
        
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return coupenAdded ? 3 : 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if coupenAdded {
//            return section == 2 ? DataArray.count : 1
//        } else {
//            return section == 1 ? DataArray.count : 1
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            if coupenAdded {
//                return tableView.dequeueReusableCell(withIdentifier: "ExperiedDetailTVC", for: indexPath) as! ExperiedDetailTVC
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "CoupenDetailTVC", for: indexPath) as! CoupenDetailTVC
//                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.width, bottom: 0, right: 0)
//                cell.layoutMargins = .zero
//                return cell
//            }
//            
//        case 1:
//            if coupenAdded {
//                return tableView.dequeueReusableCell(withIdentifier: "AddSuccessTVC", for: indexPath) as! AddSuccessTVC
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ActivateCoupenTVC", for: indexPath) as! ActivateCoupenTVC
//                let coupon = campian[indexPath.row]
//                cell.img.image = coupon.isSelected ?? false ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
//                let htmlString = coupon.termsAndConditions ?? ""
//                let plainText = convertHTMLToText(htmlString: htmlString)
//                print(plainText)
//                cell.contentTxt.text = plainText
//                cell.contentTxt.isHidden = !(coupon.isSelected ?? false)
//                cell.titleLbl.text = "Tems & Conditions"
//                return cell
//            }
//            
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivateCoupenTVC", for: indexPath) as! ActivateCoupenTVC
//            let coupon = campian[indexPath.row]
//            cell.img.image = coupon.isSelected ?? false ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
//            let htmlString = coupon.howToUse ?? ""
//            let plainText = convertHTMLToText(htmlString: htmlString)
//            print(plainText)
//            cell.contentTxt.text = plainText
//            cell.contentTxt.isHidden = !(coupon.isSelected ?? false)
//            cell.titleLbl.text = "How to Use"
//            
//            
//            return cell
//        default:
//            return UITableViewCell() // Default fallback to avoid crash
//        }
//        
//        
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section != 0 {
//            campian[indexPath.row].isSelected?.toggle()
//            tableView.reloadData()
//        }
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if coupenAdded{
//            return UITableView.automaticDimension
//        }else{
//            return indexPath.section != 0 ? UITableView.automaticDimension : 130
//        }
//    }
// 
    
    func convertHTMLToText(htmlString: String) -> String {
        guard let data = htmlString.data(using: .utf8) else { return "" }

        if let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil) {
            return attributedString.string
        }
        return ""
    }
    
    
    @IBAction func OrdernowBtnAct(_ sender: Any) {
    }
    
    @IBAction func MypaucketBtnAct(_ sender: Any) {
        
        
    }
    @IBAction func Add(_ sender: UIButton) {
        coupenAdded = true
        ActivateCoupon()
//        tv.reloadData()
        reedimFullView.isHidden = false
        qrCodeView.isHidden = false
        GoToMyPauket.isHidden = false
        youCanClaimStack.isHidden = false
       // OrdernowBtn.isHidden = false
        ActivateBtn.isHidden = true
        activatePageView.isHidden = true
        confeeti()
         }
    func confeeti(){
        if isAnimating {
            self.isAnimating = false
            if let window = UIApplication.shared.windows.first {
                confetti1.translatesAutoresizingMaskIntoConstraints = false
                window.addSubview(confetti1)
                
                NSLayoutConstraint.activate([
                    confetti1.topAnchor.constraint(equalTo: window.topAnchor),
                    confetti1.rightAnchor.constraint(equalTo: window.rightAnchor),
                    confetti1.leftAnchor.constraint(equalTo: window.leftAnchor),
                    confetti1.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                ])
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                    let impactEngine = UIImpactFeedbackGenerator(style: .heavy)
                    impactEngine.impactOccurred()
                    //                confetti.emit()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        let impactEngine = UIImpactFeedbackGenerator(style: .heavy)
                        impactEngine.impactOccurred()
                        self.confetti1.emit()
                    }
                }
            }
        }
    }
    
    func ActivateCoupon(){
        let param : [String : Any] =
        ["source_link": sourceLink ?? "","mobile_no": 9275501443677]
        
        let headers: [String: Any] = [
            "api-key": "b9634e2c3aa9b6fdc392527645c43871",
            "Partner-Name": "voicesnaps"
        ]
        
        Activate_coupon_Request.call_request(param: param, headers: headers ){ [self]
            (res) in
            
            let GetActivateCoupon : ActivateCoupenResponse = Mapper<ActivateCoupenResponse>().map(JSONString: res)!
            
            if GetActivateCoupon.status == true {
                if let couponDetails = GetActivateCoupon.data, let coupons = couponDetails.couponData, !coupons.isEmpty {
                    let firstCoupon = coupons[0]
                    
                    ActiveBrandName.text = campian[0].merchantName
                    ActiveCategoryLbl.text = category
                    
                    let dateString = firstCoupon.expiry_date
                    let inputFormatter = DateFormatter()
                    inputFormatter.dateFormat = "yyyy-MM-dd"

                    if let date = inputFormatter.date(from: dateString ?? "") {
                        let calendar = Calendar.current
                        let day = calendar.component(.day, from: date)
                        let daySuffix: String
                        switch day {
                        case 1, 21, 31:
                            daySuffix = "st"
                        case 2, 22:
                            daySuffix = "nd"
                        case 3, 23:
                            daySuffix = "rd"
                        default:
                            daySuffix = "th"
                        }
                        
                        let monthFormatter = DateFormatter()
                        monthFormatter.dateFormat = "MMMM" // Get the month name
                        let month = monthFormatter.string(from: date)
                        
                        let formattedDate = "\(day)\(daySuffix) \(month)"
                        ActiveEpiryDateLbl.text = "Expires on " + formattedDate
                    }

                        
                    ActiveOfferDetailsLbl.text = "Get " + couponDetails.offer! + " Off"
                        
                        
                    ActiveBrrandLogoImg.sd_setImage(with: URL(string: campian[0].merchant_logo ?? ""), placeholderImage: UIImage(named: "placeHolder.png"), options: SDWebImageOptions.refreshCached)
                    
                    QrcodeImage.sd_setImage(with: URL(string: firstCoupon.qr_code ?? ""), placeholderImage: UIImage(named: "placeHolder.png"), options: SDWebImageOptions.refreshCached)
                    
                    CouponCodeFld.text = firstCoupon.coupon_code
                    
                    ActivatedUsageDetails.text = campian[0].howToUse                }
                
            } else{
                print("Coupon activation failed: \(GetActivateCoupon.message ?? "Unknown error")")
            }
        }
    }
    
    
    func GetcampaigsDetails(){
        
        let param : [String : Any] =
        ["source_link": sourceLink]
        print("paramparamm,nc",param)
        let headers: [String: Any] = [
            "api-key": "b9634e2c3aa9b6fdc392527645c43871",
            "Partner-Name": "voicesnaps"
        ]
        
        Get_Campaign_details_Request.call_request(param: param,headers: headers ){ [self]
            (res) in
            
            print("resres",res)
            let getattendace : CampaignResponse = Mapper<CampaignResponse>().map(JSONString: res)!
            
            if getattendace.status == true  {
                
                
                campian.append((getattendace.data?.campaignDetails)!)
//                for i in campian{
//                    
//                    i.isSelected = false
//                }
                
                let htmlString = campian[0].termsAndConditions
                let plainText = convertHTMLToText(htmlString: htmlString ?? "")
                print(plainText)
                temsAndCondionsLbl.text = plainText
                
                let htmlString1 = campian[0].howToUse
                let plainText1 = convertHTMLToText(htmlString: htmlString1 ?? "")
                howTouseLbl.text = plainText1

                activateDiscound.text = campian[0].offer_to_show
                
                if campian[0].expiry_type == "valid_for" {
                    activateValidateLbl.text = "Valid for " + String(campian[0].coupon_valid_for ?? 0) + "days"
                }else{
                    activateValidateLbl.text = "Valid Until " + (campian[0].expiryDate ?? "")
                }
               
                activateImageView.layer.cornerRadius = 5
                activateCuponTitleLbl.text = campian[0].merchantName
                
                activateImageView.sd_setImage(with: URL(string: campian[0].merchant_logo ?? ""), placeholderImage: UIImage(named: "placeHolder.png"), options: SDWebImageOptions.refreshCached)
            }else{
                
            }
        }
        
    }
    
    
}
struct CoupenDetail{
    let name:String
    let contentDetail:String
    var isSelected:Bool
}
