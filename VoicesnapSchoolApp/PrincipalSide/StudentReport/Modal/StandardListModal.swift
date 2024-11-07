//
//  StandardListModal.swift
//  VoicesnapSchoolApp
//
//  Created by Apple on 17/03/23.
//  Copyright © Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper

class GetAllStandardsAndGroupsModal : Mappable {
    
    var SchoolId : Int!
    var StaffID : Int!
    var CountryID : Int!
    
    init() {}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        SchoolId <- map["SchoolId"]
        StaffID <- map["StaffID"]
        CountryID <- map["CountryID"]
    }
    
}

class GetAllStandardsAndGroupsList : Mappable {
    var StandardId : Int!
    var standardLevelId : Int!
    var Standard : String!
    var SectionNameData : [SectionNameDataList]!
    var SubjectNameData : [SubjectNameDataList]!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        StandardId <- map["StandardId"]
        standardLevelId <- map["standardLevelId"]
        Standard <- map["Standard"]
        SectionNameData <- map["Sections"]
        
    }
}

class SectionNameDataList : Mappable {
    var SectionId : Int!
    var mSectionId : Int!
    var SectionName : String!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        SectionId <- map["SectionId"]
        mSectionId <- map["mSectionId"]
        SectionName <- map["SectionName"]
        
    }
    
    
}

class SubjectNameDataList : Mappable {
    
    var SubjectId : Int!
    var SubjectName : String!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        SubjectId <- map["SubjectId"]
        SubjectName <- map["SubjectName"]
        
    }
    
    
}

