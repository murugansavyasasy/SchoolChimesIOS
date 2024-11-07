//
//  StudentReportModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 16/03/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class StudentReportModal : Mappable {
    var class_id : String!
    var section_id : String!
    var institute_id : String!
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        class_id <- map["class_id"]
        section_id <- map["section_id"]
        institute_id <- map["institute_id"]
    }
}




class StudentReportResponse : Mappable {
    var status : Int!
    var message : String!
    var studentData : [StudentData]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
        studentData <- map["data"]
        
    }
    
}

class StudentData : Mappable {
    
    var classTeacher : String!
    var fatherName : String!
    var studentId : Int!
    var studentName : String!
    var primaryMobile : String!
    var admissionNo : String!
    var gender : String!
    var dob : String!
    var classId : Int!
    var className : String!
    var sectionId : String!
    var sectionName : String!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        classTeacher <- map["classTeacher"]
        fatherName <- map["fatherName"]
        studentId <- map["studentId"]
        studentName <- map["studentName"]
        primaryMobile <- map["primaryMobile"]
        admissionNo <- map["admissionNo"]
        gender <- map["gender"]
        dob <- map["dob"]
        classId <- map["classId"]
        className <- map["className"]
        sectionId <- map["sectionId"]
        sectionName <- map["sectionName"]
        
    }
}

