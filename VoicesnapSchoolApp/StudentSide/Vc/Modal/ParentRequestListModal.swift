//
//  ParentRequestListModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class ParentRequestListModal : Mappable {
    
    var student_id : String!
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        student_id <- map["student_id"]
        
        
    }
    
}

class ParentRequestListResponse : Mappable {
    
    
    
    
    var Status : String!
    var Message : Int!
    var dataList : [ParentRequestListData]!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        dataList <- map["data"]
        
        
    }
}




class ParentRequestListData : Mappable {
    
    
    var certificate_url : String!
    var requested_for : String!
    var reason : String!
    var urgency_level : String!
    var created_on : String!
    var is_issued_on_app : String!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        certificate_url <- map["certificate_url"]
        requested_for <- map["requested_for"]
        reason <- map["reason"]
        urgency_level <- map["urgency_level"]
        created_on <- map["created_on"]
        is_issued_on_app <- map["is_issued_on_app"]
    }
}




