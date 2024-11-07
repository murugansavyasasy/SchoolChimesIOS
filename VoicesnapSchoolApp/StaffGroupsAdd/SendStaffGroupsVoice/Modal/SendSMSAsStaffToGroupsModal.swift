//
//  SendSMSAsStaffToGroupsModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 04/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper



class SendSMSAsStaffToGroupsModal : Mappable {
    
    
    
    var SchoolID : String!
    var StaffID : String!
    
    var Description : String!
    var Message : String!
    var GrpCode : [StaffGroupsVoiceGrpCode]!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        SchoolID <- map["SchoolID"]
        StaffID <- map["StaffID"]
        
        Description <- map["Description"]
        Message <- map["Message"]
        GrpCode <- map["GrpCode"]
        
    }
    
    
}







class StaffGroupsVoiceGrpCode : Mappable {
    
    
    
    var TargetCode : String!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        TargetCode <- map["TargetCode"]
        
    }
    
    
}



class StaffSmsResponse: Mappable {
    
    
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
