//
//  GetDataToEditStaffLessonPlanAppResponse.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 02/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper

      

class GetDataToEditStaffLessonPlanAppResponse : Mappable {
   
    var status : Int!
    var message : String!
    var getDataToEditStaffLessonPlanAppData : [GetDataToEditStaffLessonPlanAppData]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
        getDataToEditStaffLessonPlanAppData <- map["data"]
     
    }
   
}


class GetDataToEditStaffLessonPlanAppData : Mappable {
    
       
       
    var id : Int!
    var alias_name : String!
        var field_type : Int!
        var field_id : Int!
        var field_value : Int!
    var isdisable : Int!
    var field_data : [FieldData]!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        alias_name <- map["alias_name"]
        field_type <- map["field_type"]
     
        field_id <- map["field_id"]
        field_value <- map["field_value"]
        
        field_data <- map["field_data"]
        isdisable <- map["isdisable"]
    }
   
}



class FieldData : Mappable {
    
    
    
    var value : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        value <- map["value"]
        
        
    }
    
}
