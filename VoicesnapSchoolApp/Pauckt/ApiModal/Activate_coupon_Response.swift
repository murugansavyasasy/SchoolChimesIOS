//
//  Activate_coupon_Response.swift
//  VoicesnapSchoolApp
//
//  Created by Lakshmanan on 03/04/25.
//  Copyright © 2025 SchoolChimes. All rights reserved.
//

import Foundation
import ObjectMapper

class ActivateCoupenResponse : Mappable{
    
    var status : Bool?
    var message : String?
    var data : coupondetails?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}

class coupondetails : Mappable{
    
    var couponData : [coupons]?
    var merchant_logo : String?
    var offer : String?
    var redirect_url : String?
    var isCTAvalid : Bool?
    var CTAname : String?
    var CTAredirect : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        couponData <- map["coupons"]
        merchant_logo <- map["merchant_logo"]
        offer <- map["offer"]
        redirect_url <- map["redirect_url"]
        isCTAvalid <- map["isCTAvalid"]
        CTAname <- map["CTAname"]
        CTAredirect <- map["CTAredirect"]
    }
    
    class coupons : Mappable {
        
        var coupon_code : String?
        var qr_code : String?
        var expiry_date : String?
        
        required init?(map: ObjectMapper.Map) {}
        
        func mapping(map: Map) {
            
            coupon_code <- map["coupon_code"]
            qr_code <- map["qr_code"]
            expiry_date <- map["expiry_date"]
        }
    }
    
}

//{
//    "status": true,
//    "message": "Coupon Purchased Successfully",
//    "data": {
//        "coupons": [
//            {
//                "coupon_code": "zWZ0TIC3DK",
//                "qr_code": "https://pauket.s3.amazonaws.com/2025/01/campaign/coupons/zWZ0TIC3DK.png",
//                "expiry_date": "2026-06-01"
//            }
//        ],
//        "merchant_logo": "https://stage-api.pauket.com/merchant/logo/1715340044.png",
//        "offer": "10%",
//        "redirect_url": "https://stage.pauket.com/success/zWZ0TIC3DK",
//        "coupon_code": "zWZ0TIC3DK",
//        "isCTAvalid": true,
//        "CTAname": "Buy Now",
//        "CTAredirect": "www.pauket.com"
//    }
//}
