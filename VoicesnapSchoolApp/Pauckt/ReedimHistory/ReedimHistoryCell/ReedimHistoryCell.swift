//
//  ReedimHistoryCell.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import UIKit

class ReedimHistoryCell: UICollectionViewCell {

    @IBOutlet weak var ticketViews: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        addScallopedEdge(to: ticketViews)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        addScallopedEdge(to: ticketViews)
        
        ticketViews.layer.cornerRadius = 12
        ticketViews.layer.shadowColor = UIColor.black.cgColor
        ticketViews.layer.shadowOpacity = 0.1
        ticketViews.layer.shadowOffset = CGSize(width: 0, height: 2)
        ticketViews.layer.shadowRadius = 4
    }
    
    // Function to create the ticket shape
    private func addScallopedEdge(to view: UIView) {
        let path = UIBezierPath()
        let scallopRadius: CGFloat = 10
        let scallopCount = 10
        let rect = view.bounds
        let scallopWidth = rect.width / CGFloat(scallopCount)
        
        // Start from the top left
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Top edge with scallops
        for i in 0..<scallopCount {
            let x = CGFloat(i) * scallopWidth + (scallopWidth / 2)
            path.addArc(withCenter: CGPoint(x: x, y: 0),
                        radius: scallopRadius,
                        startAngle: .pi,
                        endAngle: 0,
                        clockwise: true)
        }
        
        // Move to top-right corner
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        
        // Bottom edge (flat)
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        // Close the path
        path.close()
        
        // Apply shape
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemYellow.cgColor
        view.layer.mask = shapeLayer
    }
}



   

