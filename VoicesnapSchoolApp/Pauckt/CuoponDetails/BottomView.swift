//
//  BottomView.swift
//  rewardDesign
//
//  Created by admin on 18/02/25.
//

import UIKit
protocol AddCoupen{
    func addpucket()
}
class BottomView: UIViewController,UITableViewDelegate,UITableViewDataSource, AddCoupen{
    func addpucket() {
        coupenAdded = true
        tv.reloadData()
    }
    private var confettiLayer: CAEmitterLayer?
    private var isAnimating = true
    private let confetti1: ConfettiView = .right
    @IBOutlet weak var tv: UITableView!
    var coupendetail = [CoupenDetail(name: "things to remember", contentDetail: "Loren ipsum dolor sit amet,consectetur adipiscing elit,send do eiusmod tempor incididunt", isSelected: false),CoupenDetail(name: "Terms&", contentDetail: "Loren ipsum dolor sit amet,consectetur adipiscing elit,send do eiusmod tempor incididunt", isSelected: false)]
    var coupenAdded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tv.register(UINib(nibName: "CoupenDetailTVC", bundle: nil), forCellReuseIdentifier: "CoupenDetailTVC")
        tv.register(UINib(nibName: "ActivateCoupenTVC", bundle: nil), forCellReuseIdentifier: "ActivateCoupenTVC")
        tv.register(UINib(nibName: "AddCoupenTVC", bundle: nil), forCellReuseIdentifier: "AddCoupenTVC")
        tv.register(UINib(nibName: "ExperiedDetailTVC", bundle: nil), forCellReuseIdentifier: "ExperiedDetailTVC")
        tv.register(UINib(nibName: "AddSuccessTVC", bundle: nil), forCellReuseIdentifier: "AddSuccessTVC")
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return coupenAdded ? 3 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coupenAdded {
            return section == 2 ? coupendetail.count : 1
        } else {
            return section == 1 ? coupendetail.count : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if coupenAdded {
                return tableView.dequeueReusableCell(withIdentifier: "ExperiedDetailTVC", for: indexPath) as! ExperiedDetailTVC
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CoupenDetailTVC", for: indexPath) as! CoupenDetailTVC
                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.width, bottom: 0, right: 0)
                cell.layoutMargins = .zero
                return cell
            }
            
        case 1:
            if coupenAdded {
                return tableView.dequeueReusableCell(withIdentifier: "AddSuccessTVC", for: indexPath) as! AddSuccessTVC
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ActivateCoupenTVC", for: indexPath) as! ActivateCoupenTVC
                let coupon = coupendetail[indexPath.row]
                cell.img.image = coupon.isSelected ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
                cell.contentTxt.text =  coupon.contentDetail
                cell.contentTxt.isHidden = !coupon.isSelected
                cell.titleLbl.text = coupon.name
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivateCoupenTVC", for: indexPath) as! ActivateCoupenTVC
            let coupon = coupendetail[indexPath.row]
            cell.img.image = coupon.isSelected ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            cell.contentTxt.text = coupon.contentDetail
            cell.contentTxt.isHidden = !coupon.isSelected
            cell.titleLbl.text = coupon.name
            return cell
        default:
            return UITableViewCell() // Default fallback to avoid crash
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            coupendetail[indexPath.row].isSelected.toggle()
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if coupenAdded{
            return UITableView.automaticDimension
        }else{
            return indexPath.section != 0 ? UITableView.automaticDimension : 130
        }
    }
 
    
    @IBAction func Add(_ sender: UIButton) {
        coupenAdded = true
        tv.reloadData()
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
}
struct CoupenDetail{
    let name:String
    let contentDetail:String
    var isSelected:Bool
}
