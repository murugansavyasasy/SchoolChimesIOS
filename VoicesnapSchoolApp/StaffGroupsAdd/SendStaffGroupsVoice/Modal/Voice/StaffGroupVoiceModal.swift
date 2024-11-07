//
//  StaffGroupVoiceModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 09/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation



import UIKit
import ObjectMapper



class StaffGroupVoiceModal : Mappable {
    
    
    
    
    
    var SchoolID : String!
    var StaffID : String!
    
    var Description : String!
    var Duration : String!
    
    
    
    var GrpCode : [StaffVoiceGrpCode]!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        SchoolID <- map["SchoolID"]
        StaffID <- map["StaffID"]
        
        Description <- map["Description"]
        Duration <- map["Duration"]
        
        
        GrpCode <- map["GrpCode"]
        
    }
    
    
}







class StaffVoiceGrpCode : Mappable {
    
    
    
    var TargetCode : String!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        TargetCode <- map["TargetCode"]
        
    }
    
    
}



class StaffVoiceResponse: Mappable {
    
    
    var Message : String!
    var Status : String!
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        Message <- map["Message"]
        Status <- map["Status"]
        
        
    }
    
    
}
