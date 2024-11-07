//
//  CreateOtherReqModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 18/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper



class CreateOtherReqModal : Mappable {
    
    
    
    
    var instituteId : String!
    var student_id : String!
    var requested_for : String!
    var reason : String!
    var urgency_level : String!
    var is_issued_on_app : String!
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        instituteId <- map["instituteId"]
        student_id <- map["student_id"]
        requested_for <- map["requested_for"]
        reason <- map["reason"]
        urgency_level <- map["urgency_level"]
    }
}






class CreateOtherReqResponse : Mappable {
    
    
    
    
    var Status : String!
    var Message : String!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
        
    }
}




