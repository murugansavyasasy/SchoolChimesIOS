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
    var templateLes: String?
    var merchantName: String?
    var offerType: String?
    var discount: Int?
    var howToUse: String?
    var termsAndConditions: String?
    var templateLe: String?
    var merchant_logo: String?
    var isSelected : Bool?
    required init?(map: Map) {}

    func mapping(map: Map) {
        campaignName <- map["campaign_name"]
        expiryDate <- map["expiry_date"]
        templateLes <- map["template_les"]
        merchantName <- map["merchant_name"]
        offerType <- map["offer_type"]
        discount <- map["discount"]
        howToUse <- map["how_to_use"]
        termsAndConditions <- map["terms_and_conditions"]
        templateLe <- map["template_le"]
        merchant_logo <- map["merchant_logo"]
    }
}
