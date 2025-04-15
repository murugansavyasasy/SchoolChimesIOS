//
//  my_coupons_Response.swift
//  VoicesnapSchoolApp
//
//  Created by Lakshmanan on 04/04/25.
//  Copyright © 2025 SchoolChimes. All rights reserved.
//

import Foundation

import ObjectMapper


class MyCouponResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: CouponData?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}


class CouponData: Mappable {
    var totalPages: Int?
    var couponList: CouponList?

    required init?(map: Map) {}

    func mapping(map: Map) {
        totalPages <- map["total_pages"]
        couponList <- map["coupon_list"]
    }
}


class CouponList: Mappable {
    var currentPage: Int?
    var data: [Coupon]?
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

class Coupon: Mappable {
    var id: Int?
    var merchantName: String?
    var campaignName: String?
    var merchantId: Int?
    var merchantLogo: String?
    var aboutMerchant: String?
    var campaignType: String?
    var offerType: String?
    var discount: Int?
    var templateFiles: [String]?
    var thresholdAmount: String?
    var expiryDate: String?
    var expiryType: String?
    var couponValidFor: String?
    var howToUse: String?
    var termsAndConditions: String?
    var coverImage: String?
    var ctaURL: String?
    var offerText: String?
    var locationList: [Location]?
    var redeemedOn: String?
    var qrCode: String?
    var categoryName: String?
    var sourceLink: String?
    var industryName: String?
    var couponCode: String?
    var couponStatus: String?
    var expiresIn: Int?
    var isCTAvalid: Bool?
    var ctaName: String?
    var ctaRedirect: String?
    var offerToShow: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        merchantName <- map["merchant_name"]
        campaignName <- map["campaign_name"]
        merchantId <- map["merchant_id"]
        merchantLogo <- map["merchant_logo"]
        aboutMerchant <- map["about_merchant"]
        campaignType <- map["campaign_type"]
        offerType <- map["offer_type"]
        discount <- map["discount"]
        templateFiles <- map["template_files"]
        thresholdAmount <- map["threshold_amount"]
        expiryDate <- map["expiry_date"]
        expiryType <- map["expiry_type"]
        couponValidFor <- map["coupon_valid_for"]
        howToUse <- map["how_to_use"]
        termsAndConditions <- map["terms_and_conditions"]
        coverImage <- map["cover_image"]
        ctaURL <- map["cta_url"]
        offerText <- map["offer_text"]
        locationList <- map["location_list"]
        redeemedOn <- map["redeemed_on"]
        qrCode <- map["qr_code"]
        categoryName <- map["category_name"]
        sourceLink <- map["source_link"]
        industryName <- map["industry_name"]
        couponCode <- map["coupon_code"]
        couponStatus <- map["coupon_status"]
        expiresIn <- map["expires_in"]
        isCTAvalid <- map["isCTAvalid"]
        ctaName <- map["CTAname"]
        ctaRedirect <- map["CTAredirect"]
        offerToShow <- map["offer_to_show"]
    }
}

class Location: Mappable {
    var locationName: String?
    var latitude: String?
    var longitude: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        locationName <- map["location_name"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}

