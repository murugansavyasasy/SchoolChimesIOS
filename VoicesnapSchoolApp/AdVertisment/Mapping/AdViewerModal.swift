//
//  AdViewerModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 01/06/23.
//  Copyright © 2023 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class AdViewerModal : Mappable {
    
    
    var memberId : String!
    var adId : Int!
    var schoolId : String!
    var menuId : Int!
    var member_type : String!
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        memberId <- map["memberId"]
        adId <- map["adId"]
        schoolId <- map["schoolId"]
        menuId <- map["menuId"]
        member_type <- map["member_type"]
        
        
        
    }
    
    
    
    
    
    
}


class AdViewerResponse : Mappable {
    
    
    
    
    var Status : String!
    var Message : String!
    
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
        
        
        
    }
    
    
    
    
    
    
}
