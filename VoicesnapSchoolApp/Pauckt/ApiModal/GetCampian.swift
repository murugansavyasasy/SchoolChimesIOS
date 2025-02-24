//
//  GetCampian.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 21/02/25.
//  Copyright © 2025 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - CampaignsResponse
class CampaignsResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: CampaignData?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - CampaignData
class CampaignData: Mappable {
    var totalCount: Int?
    var campaigns: CampaignPagination?

    required init?(map: Map) {}

    func mapping(map: Map) {
        totalCount <- map["total_count"]
        campaigns <- map["campaigns"]
    }
}

// MARK: - CampaignPagination
class CampaignPagination: Mappable {
    var currentPage: Int?
    var data: [Campaign]?
    var firstPageURL: String?
    var from: Int?
    var nextPageURL: String?
    var path: String?
    var perPage: Int?
    var prevPageURL: String?
    var to: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        currentPage <- map["current_page"]
        data <- map["data"]
        firstPageURL <- map["first_page_url"]
        from <- map["from"]
        nextPageURL <- map["next_page_url"]
        path <- map["path"]
        perPage <- map["per_page"]
        prevPageURL <- map["prev_page_url"]
        to <- map["to"]
    }
}

// MARK: - Campaign
class Campaign: Mappable {
    var sourceLink: String?
    var campaignName: String?
    var campaignType: String?
    var thumbnail: String?
    var expiryDate: String?
    var endDate: String?
    var offerType: String?
    var discount: Int?
    var merchantName: String?
    var categoryName: String?
    var categoryImage: String?
    var merchantLogo: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        sourceLink <- map["source_link"]
        campaignName <- map["campaign_name"]
        campaignType <- map["campaign_type"]
        thumbnail <- map["thumbnail"]
        expiryDate <- map["expiry_date"]
        endDate <- map["end_date"]
        offerType <- map["offer_type"]
        discount <- map["discount"]
        merchantName <- map["merchant_name"]
        categoryName <- map["category_name"]
        categoryImage <- map["category_image"]
        merchantLogo <- map["merchant_logo"]
    }
}
