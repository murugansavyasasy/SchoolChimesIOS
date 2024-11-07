//
//  CertificateTypsResponse.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 18/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class CertificateTypsResponse : Mappable {
    
    
    var Status : String!
    var Message : String!
    var certificate_data : [certificateData]!
    
    var urgenctList : [String]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Status <- map["Status"]
        Message <- map["Message"]
        certificate_data <- map["data"]
        urgenctList <- map["urgenctLevelList"]
        
    }
    
}

class certificateData : Mappable {
    
    
    
    var certificate_name : String!
    var id : Int!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        certificate_name <- map["certificate_name"]
        id <- map["id"]
        
        
        
    }
}


class urgenctLevelList : Mappable {
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
        
    }
}
