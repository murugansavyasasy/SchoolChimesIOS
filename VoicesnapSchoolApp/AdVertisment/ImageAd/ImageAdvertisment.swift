//
//  ImageAdvertisment.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 28/11/22.
//  Copyright © 2022 Shenll-Mac-04. All rights reserved.
//

import Foundation
import UIKit

class ImageAdvertisment {
    
    
    
    var imageView : UIImageView!
    
    
    func imgAdv () {
    
    imageView.animationImages = [
                                   UIImage(named: "BookIcon")!,
                                   UIImage(named: "ArrowIcon")!,
                                   UIImage(named: "ChangeLoginTypeButton")!]

                imageView.animationDuration = 5.0
                imageView.startAnimating()

    }
}
