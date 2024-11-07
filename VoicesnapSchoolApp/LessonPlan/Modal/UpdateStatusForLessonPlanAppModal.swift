//
//  UpdateStatusForLessonPlanAppModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 02/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class UpdateStatusForLessonPlanAppModal : Mappable {
    
    var institute_id : String!
    var user_id : String!
    var particular_id : String!
    var value : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        institute_id <- map["institute_id"]
        user_id <- map["user_id"]
        particular_id <- map["particular_id"]
        value <- map["value"]
     
    }
   
}

class UpdateStatusForLessonPlanAppResponse : Mappable {
    
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
