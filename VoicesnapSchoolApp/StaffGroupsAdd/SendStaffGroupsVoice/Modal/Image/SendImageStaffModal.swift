//
//  SendImageStaffModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 05/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper



class SendImageStaffModal : Mappable {
   
    var SchoolID : String!
    var StaffID : String!
   
    var Description : String!
    var Message : String!
    
    var Duration : String!
    var isMultiple : String!
   
    var FileType : String!
    var GrpCode : [StaffGroupsImagePdfGrpCode]!
    var FileNameArray : [StaffGroupsImagePdfFileNameArray]!

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
        isMultiple <- map["isMultiple"]
        FileType <- map["FileType"]
        Duration <- map["Duration"]
        FileNameArray <- map["FileNameArray"]
    }
    
    
}







class StaffGroupsImagePdfGrpCode : Mappable {
    
  
    
    var TargetCode : String!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        TargetCode <- map["TargetCode"]
        
    }
    
    
}



class StaffGroupsImagePdfFileNameArray : Mappable {
    
  
    
    var FileName : String!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        FileName <- map["FileName"]
        
    }
    
    
}

class StaffImagePdfResponse: Mappable {
    
  
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
