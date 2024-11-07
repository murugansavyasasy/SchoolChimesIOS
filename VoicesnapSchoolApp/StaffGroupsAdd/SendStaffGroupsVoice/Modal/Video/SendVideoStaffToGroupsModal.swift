//
//  SendVideoStaffToGroupsModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 07/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper



class SendVideoStaffToGroupsModal : Mappable {
    
    
    
    var SchoolId : String!
    var Title : String!
    
    var Description : String!
    var ProcessBy : String!
    var Iframe : String!
    var URL : String!
    var videoFileSize : String!
    
    var GrpCode : [StaffGroupsVideoGrpCode]!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        SchoolId <- map["SchoolId"]
        Title <- map["Title"]
        
        Description <- map["Description"]
        ProcessBy <- map["ProcessBy"]
        Iframe <- map["Iframe"]
        URL <- map["URL"]
        videoFileSize <- map["videoFileSize"]
        GrpCode <- map["GrpCode"]
        
    }
    
    
}







class StaffGroupsVideoGrpCode : Mappable {
    
    
    
    var TargetCode : String!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        TargetCode <- map["TargetCode"]
        
    }
    
    
}



class StaffVideoResponse: Mappable {
    
    
    var Message : String!
    var result : String!
    
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        Message <- map["Message"]
        result <- map["result"]
        
        
    }
    
    
}
