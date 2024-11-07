//
//  SendStaffGroupsVoiceModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 04/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper



class SendStaffGroupsVoiceModal : Mappable {
    
    
    
    var SchoolId : String!
    var StaffId : String!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        SchoolId <- map["SchoolId"]
        StaffId <- map["StaffId"]
        
    }
    
    
}



class SendStaffGroupsVoiceResponse : Mappable {
    
    
    
    var GroupID : String!
    var GroupName : String!
    
    var isSelected : Bool!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        GroupID <- map["GroupID"]
        GroupName <- map["GroupName"]
        
    }
    
    
}
