//
//  ParticularDataEditRsponse.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


        

class ParticularDataEditRsponse : Mappable {
   
    var status : Int!
    var message : String!
    var particularEditData : [ParticularDataEditData]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
        particularEditData <- map["data"]
     
    }
   
}


class ParticularDataEditData : Mappable {
    
 
       
       
    var id : Int!
    var name : String!
        var field_type : String!
        var field_id : Int!
        var value : String!
    var isdisable : Int!
    var field_data : [ParticularEditFieldData]!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        field_type <- map["field_type"]
     
        field_id <- map["field_id"]
        value <- map["value"]
        
        field_data <- map["field_data"]
        isdisable <- map["isdisable"]
    }
   
}



class ParticularEditFieldData : Mappable {
    
    
    
    var value : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        value <- map["value"]
        
        
    }
    
}
