//
//  UpdateDetailsModal.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 01/12/23.
//  Copyright © 2023 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper


class UpdateDetailsModal : Mappable {
    
    var instituteid : String!
    var staff_role : String!
    var member_id : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        instituteid <- map["instituteid"]
        staff_role <- map["staff_role"]
        member_id <- map["member_id"]
        
    }
    
}

class UpdateDetailsResponse : Mappable {
    
    
    
    var message : String!
    var status : Int!
    var dataList : [UpdateDetailsData]!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        message <- map["message"]
        status <- map["status"]
        dataList <- map["data"]
        
        
    }
}




class UpdateDetailsData : Mappable {
    
    
    
    var id : Int!
    var update_name : String!
    var update_description : String!
    var redirect_link : String!
    var video_link : String!
    var downloadable_image : String!
    var isSelect : Bool!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        id <- map["id"]
        update_name <- map["update_name"]
        update_description <- map["update_description"]
        redirect_link <- map["app_redirect_link"]
        video_link <- map["video_link"]
        downloadable_image <- map["downloadable_image"]
    }
}




