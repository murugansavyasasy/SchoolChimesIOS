//
//  getLessonPlanStaffReportResponse.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 02/05/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation

import ObjectMapper


class getLessonPlanStaffReportResponse : Mappable {
   
    var status : Int!
    var message : String!
    var getLessonPlanStaffReportData : [GetLessonPlanStaffReportResponseData]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
        getLessonPlanStaffReportData <- map["data"]
     
    }
   
}

class GetLessonPlanStaffReportResponseData : Mappable {
    
    
 
    var staffName : String!
    var className : String!
    var sectionName : String!
    var subjectName : String!
    var section_subject_id : Int!
    var completed_items : Int!
    var total_items : String!
    var percentage_value : Int!
    var itemsCompleted : String!
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        staffName <- map["staffName"]
        className <- map["className"]
        sectionName <- map["sectionName"]
        subjectName <- map["subjectName"]
        section_subject_id <- map["section_subject_id"]
        completed_items <- map["completed_items"]
        total_items <- map["total_items"]
        
        percentage_value <- map["percentage_value"]
        itemsCompleted <- map["itemsCompleted"]
        sectionName <- map["sectionName"]
        
    }
}




