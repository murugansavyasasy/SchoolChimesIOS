//
//  LessonUpdateModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 11/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class LessonUpdateModal : Mappable {
    
    
                

    
    var institute_id : Int!
    var user_id : Int!
    var particular_id : Int!
    var keyValueArr : [UpdateKeyValueArray]!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        institute_id <- map["institute_id"]
        user_id <- map["user_id"]
        particular_id <- map["particular_id"]
        keyValueArr <- map["keyValueArray"]
     
    }
   
}

class UpdateKeyValueArray : Mappable {
    
    var field_id : Int!
    var value : String!
   
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        field_id <- map["field_id"]
        value <- map["value"]
       
     
    }
   
}


class LessonUpdateModalResponse : Mappable {
    
    var status : Int!
    var message : String!
  
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
       
     
    }
   
}
