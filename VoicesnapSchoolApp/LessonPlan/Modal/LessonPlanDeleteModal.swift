//
//  LessonPlanDeleteModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 10/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation

import ObjectMapper

class LessonPlanDeleteModal : Mappable {
   
    
 
    var particular_id : String!
    var userId : String!
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        particular_id <- map["particular_id"]
        userId <- map["userId"]
     
    }
   
}


class LessonPlanDeleteResponse : Mappable {
    
  
       
    var status : Int!
    var message : String!
       
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
       
    }
   
}



