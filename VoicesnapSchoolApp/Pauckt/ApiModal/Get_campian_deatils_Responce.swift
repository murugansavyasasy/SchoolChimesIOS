//
//  Get_campian_deatils_Responce.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 25/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper

class CampaignResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: CampaignDetailsData?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}

class CampaignDetailsData: Mappable {
    var campaignDetails: CampaignDetails?

    required init?(map: Map) {}

    func mapping(map: Map) {
        campaignDetails <- map["campaign_details"]
    }
}

class CampaignDetails: Mappable {
    var campaignName: String?
    var expiryDate: String?
    var cover_image: String?
    var templateLes: String?
    var merchantName: String?
    var threshold_amount: String?
    var offer_text: String?
    var offerType: String?
    var discount: Int?
    var howToUse: String?
    var termsAndConditions: String?
    var templateLe: String?
    var merchant_logo: String?
    var campaign_type : String?
    var coupon_valid_for : Int?
    var customer_buys_value : String?
    var customer_gets_value : String?
    var template_file : String?
    var offer_to_show : String?
    var expiry_type : String?
    required init?(map: Map) {}

    func mapping(map: Map) {
        campaignName <- map["campaign_name"]
        expiryDate <- map["expiry_date"]
        cover_image <- map["cover_image"]
        templateLes <- map["template_les"]
        merchantName <- map["merchant_name"]
        threshold_amount <- map["threshold_amount"]
        offer_text <- map["offer_text"]
        offerType <- map["offer_type"]
        discount <- map["discount"]
        howToUse <- map["how_to_use"]
        termsAndConditions <- map["terms_and_conditions"]
        templateLe <- map["template_le"]
        merchant_logo <- map["merchant_logo"]
        campaign_type <- map["campaign_type"]
        coupon_valid_for <- map["coupon_valid_for"]
        customer_buys_value <- map["customer_buys_value"]
        customer_gets_value <- map["customer_gets_value"]
        template_file <- map["template_file"]
        offer_to_show <- map["offer_to_show"]
        expiry_type <- map["expiry_type"]
    }
}
