//
//  AwsResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/12/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

import ObjectMapper


class AwsResps: Mappable {
    
    
    var status : Int!
    var message : String!
    var data : AwsData!
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
    
    
    
}

class AwsData : Mappable {
    
    var presignedUrl : String!
    var fileUrl : String!
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        presignedUrl <- map["presignedUrl"]
        fileUrl <- map["fileUrl"]
    }
    
    
    
    
    
}


