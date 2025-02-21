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
    private var isAnimating = false
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
    func startConfetti(from point: CGPoint) {
        guard let window = UIApplication.shared.windows.first else { return }
        guard !isAnimating else { return }
        
        isAnimating = true
        
        let confettiLayer = CAEmitterLayer()
        self.confettiLayer = confettiLayer
        
        // Start from the given point
        confettiLayer.emitterPosition = point
        confettiLayer.emitterShape = .point
        
        let colors: [UIColor] = [.red, .blue, .yellow, .green]
        let shapes = ["confetti_circle", "confetti_square", "confetti_star", "confetti_thread"]
        
        var risingCells: [CAEmitterCell] = []
        
        for color in colors {
            for shape in shapes {
                let cell = CAEmitterCell()
                cell.birthRate = 4
                cell.lifetime = 1.5
                cell.velocity = 350
                cell.velocityRange = 15
                cell.emissionLongitude = .pi * 1.5 // Move slightly to the left
                cell.emissionRange = .pi / 4 // Add variation
                cell.scale = 0.4
                cell.spin = -1.5 // Rotate from right to left
                cell.spinRange = 1.0 // Add variation to rotation
                cell.yAcceleration = 20
                cell.contents = self.createConfettiImage(color: color, shape: shape)
                risingCells.append(cell)
            }
        }
        
        confettiLayer.emitterCells = risingCells
        window.layer.addSublayer(confettiLayer)
        
        // Delay before explosion effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            confettiLayer.emitterPosition = CGPoint(x: window.bounds.midX, y: point.y - 250) // Move explosion to center

            var explosionCells: [CAEmitterCell] = []
            for color in colors {
                for shape in shapes {
                    let cell = CAEmitterCell()
                    cell.birthRate = 4
                    cell.lifetime = 1.5
                    cell.velocity = 350
                    cell.velocityRange = 15
                    cell.emissionLongitude = .pi * 1.5 // Move slightly to the left
                    cell.emissionRange = .pi / 4 // Add variation
                    cell.scale = 0.4
                    cell.spin = -1.5 // Rotate from right to left
                    cell.spinRange = 1.0 // Add variation to rotation
                    cell.yAcceleration = 20
                    cell.contents = self.createConfettiImage(color: color, shape: shape)
                    explosionCells.append(cell)
                }
            }
            confettiLayer.emitterCells = explosionCells
            

                
                // Stop confetti effect after falling
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    confettiLayer.birthRate = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        confettiLayer.removeFromSuperlayer()
                        self.confettiLayer = nil
                        self.isAnimating = false
                    }
                }
            }
    }
    
    func startSpiralConfetti() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        guard !isAnimating else { return }
        isAnimating = true
        window.layer.masksToBounds = true
        
        let confettiLayer = CAEmitterLayer()
        self.confettiLayer = confettiLayer
        
        let startX = window.bounds.midX
        let startY = window.bounds.midY
        let startPosition = CGPoint(x: startX, y: startY)
        
        confettiLayer.emitterPosition = startPosition
        confettiLayer.emitterShape = .point
        
        let colors: [UIColor] = [.red, .blue, .yellow, .green, .purple, .cyan]
        let shapes = ["confetti_circle", "confetti_square", "confetti_star", "confetti_thread"]
        
        var spiralCells: [CAEmitterCell] = []
        
        for (index, color) in colors.enumerated() {
            let baseAngle = CGFloat(index) * .pi / 3
            
            for shape in shapes {
                let cell = CAEmitterCell()
                
                cell.birthRate = 5
                cell.lifetime = 6.0
                cell.scale = 0.4
                cell.scaleRange = 0.2
                
                // Spiral movement settings
                let velocity: CGFloat = 250
                let velocityRange: CGFloat = 80
                
                cell.velocity = velocity
                cell.velocityRange = velocityRange
                
                // Shoots upward initially
                cell.emissionLongitude = -(.pi / 2)
                cell.emissionRange = .pi / 6
                
                // Spread effect horizontally
                let xAccel = 100 * cos(baseAngle)
                cell.xAcceleration = xAccel
                
                // Gravity pulling confetti downward
                cell.yAcceleration = 150
                
                // Add rotation
                cell.spin = 5.0
                cell.spinRange = 2.0
                
                // Assign shape and color
                cell.contents = createConfettiImage(color: color, shape: shape)
                
                // Smooth fade out effect
                cell.alphaSpeed = -0.3
                cell.scaleSpeed = -0.1
                
                spiralCells.append(cell)
            }
        }
        
        confettiLayer.emitterCells = spiralCells
        window.layer.addSublayer(confettiLayer)
        
        // **Optimize Path Calculation**
        let pathAnimation = CAKeyframeAnimation(keyPath: "emitterPosition")
        let path = CGMutablePath()
        
        let spreadRadius: CGFloat = window.bounds.width / 2
        let numberOfSpirals: CGFloat = 3
        let pointsPerSpiral: CGFloat = 80
        
        let topY: CGFloat = -50
        let bottomY: CGFloat = window.bounds.height + 50
        
        var radiusFactor: CGFloat = 0.0
        let spiralAngleStep = (.pi * 2) / pointsPerSpiral
        
        for i in 0...Int(numberOfSpirals * pointsPerSpiral) {
            let angle = CGFloat(i) * spiralAngleStep
            radiusFactor = CGFloat(i) / (pointsPerSpiral * numberOfSpirals)
            let radius = spreadRadius * radiusFactor
            
            let x = startX + radius * cos(angle)
            let y = startY - radiusFactor * (startY - topY)
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        // Falling effect
        path.addLine(to: CGPoint(x: startX, y: bottomY))
        
        pathAnimation.path = path
        pathAnimation.duration = 5.0
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pathAnimation.repeatCount = 1
        
        confettiLayer.add(pathAnimation, forKey: "spiralSpreadPath")
        
        // Cleanup confetti after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            confettiLayer.birthRate = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                confettiLayer.removeFromSuperlayer()
                self.confettiLayer = nil
                self.isAnimating = false
            }
        }
    }


    func createConfettiImage(color: UIColor, shape: String) -> CGImage? {
        let width: CGFloat = CGFloat.random(in: 20...40) // Randomized width
        let height: CGFloat = shape == "confetti_thread" ? width * 6 : width // Adjusted aspect ratio
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(color.cgColor)
        
        switch shape {
        case "confetti_circle":
            context.fillEllipse(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        case "confetti_square":
            context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        
        case "confetti_star":
            let path = UIBezierPath()
            let center = CGPoint(x: width / 2, y: height / 2)
            let radius = width / 2
            let points = 5
            
            for i in 0..<points * 2 {
                let angle = CGFloat(i) * .pi / CGFloat(points)
                let pointRadius = i % 2 == 0 ? radius : radius / 2
                let point = CGPoint(
                    x: center.x + pointRadius * cos(angle),
                    y: center.y + pointRadius * sin(angle)
                )
                if i == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.close()
            context.addPath(path.cgPath)
            context.fillPath()
        
        case "confetti_thread":
            let path = UIBezierPath()
            let startPoint = CGPoint(x: width / 2, y: 0)
            path.move(to: startPoint)

            let segments = 6
            let curlFactor: CGFloat = width / 3
            let segmentHeight = height / CGFloat(segments)
            
            for i in 0..<segments {
                let xOffset = (i % 2 == 0) ? curlFactor : -curlFactor
                let controlPoint = CGPoint(
                    x: width / 2 + xOffset,
                    y: CGFloat(i) * segmentHeight + (segmentHeight / 2)
                )
                let endPoint = CGPoint(
                    x: width / 2,
                    y: CGFloat(i + 1) * segmentHeight
                )
                path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
            }
            
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(2)
            context.addPath(path.cgPath)
            context.strokePath()
        
        default:
            context.fill(CGRect(x: 0, y: 0, width: width / 2, height: height))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()
        return image
    }
    
    
    @IBAction func Add(_ sender: UIButton) {
        coupenAdded = true
        tv.reloadData()
////        startConfetti(from: view.center)
//        startSpiralConfetti()
//        isAnimating = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            self.isAnimating = true
//            // Optional: Remove old confetti layer
//            self.confettiLayer?.removeFromSuperlayer()
//            self.confettiLayer = nil
//        }
//        
        if let window = UIApplication.shared.windows.first {
//            confetti.translatesAutoresizingMaskIntoConstraints = false
            confetti1.translatesAutoresizingMaskIntoConstraints = false
            
//            window.addSubview(confetti)
            window.addSubview(confetti1)

            NSLayoutConstraint.activate([
//                confetti.topAnchor.constraint(equalTo: window.topAnchor),
//                confetti.rightAnchor.constraint(equalTo: window.rightAnchor),
//                confetti.leftAnchor.constraint(equalTo: window.leftAnchor),
//                confetti.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                
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
//    private let confetti: ConfettiView = .top
    private let confetti1: ConfettiView = .right
}
struct CoupenDetail{
    let name:String
    let contentDetail:String
    var isSelected:Bool
}
