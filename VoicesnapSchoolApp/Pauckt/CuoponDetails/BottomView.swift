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
        tv.reloadData()
    }
    private var confettiLayer: CAEmitterLayer?
    private var isAnimating = true
    private let confetti1: ConfettiView = .right
    @IBOutlet weak var tv: UITableView!
//    var coupendetail = [CoupenDetail(name: "things to remember", contentDetail: "Loren ipsum dolor sit amet,consectetur adipiscing elit,send do eiusmod tempor incididunt", isSelected: false),CoupenDetail(name: "Terms & Conditions", contentDetail: "Loren ipsum dolor sit amet,consectetur adipiscing elit,send do eiusmod tempor incididunt", isSelected: false)]
    
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
    var coupenAdded = false
    var campian : [CampaignDetails] = []
    var source_link : String?
    var DataArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reedimFullView.isHidden = true
        qrCodeView.isHidden = true
        GoToMyPauket.isHidden = true
        youCanClaimStack.isHidden = true
        temsAndCondionsLbl.isHidden = true
        howTouseLbl.isHidden = true
        activatePageView.layer.cornerRadius = 20
        GetcampaigsDetails()
        
        let temsAndCondionTapGesture = UITapGestureRecognizer(target: self, action: #selector(dropClick))
        temsAndCondtionImage.addGestureRecognizer(temsAndCondionTapGesture)
        
        let howtoUSe = UITapGestureRecognizer(target: self, action: #selector(HowTouse))
        howtoUseDropImage.addGestureRecognizer(howtoUSe)
    }
    
    
    @IBAction func dropClick() {
        
        temsAndCondionsLbl.isHidden.toggle()
        
    }
    
    @IBAction func HowTouse() {
        
        howTouseLbl.isHidden.toggle()
        
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
    
    @IBAction func Add(_ sender: UIButton) {
        coupenAdded = true
//        tv.reloadData()
        reedimFullView.isHidden = false
        qrCodeView.isHidden = false
        GoToMyPauket.isHidden = false
        youCanClaimStack.isHidden = false
        temsAndCondionsLbl.isHidden = false
        howTouseLbl.isHidden = false
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
    
    
    func GetcampaigsDetails(){
        
        let param : [String : Any] =
        ["source_link": "kjlPFMkQlr"]
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
                for i in campian{
                    
                    i.isSelected = false
                }
                
                let htmlString = campian[0].termsAndConditions
                let plainText = convertHTMLToText(htmlString: htmlString ?? "")
                print(plainText)
                temsAndCondionsLbl.text = plainText
                
                let htmlString1 = campian[0].howToUse
                let plainText1 = convertHTMLToText(htmlString: htmlString1 ?? "")
                howTouseLbl.text = plainText1

                activateDiscound.text = String(campian[0].discount ?? 0) + "%" + "Off"
                activateValidateLbl.text = "Valid Until " + (campian[0].expiryDate ?? "")
                activateImageView.layer.cornerRadius = 5
                
                
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
