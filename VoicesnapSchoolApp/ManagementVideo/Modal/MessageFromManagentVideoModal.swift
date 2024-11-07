//
//  MessageFromManagentVideoModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 10/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper



class MessageFromManagentVideoModal : Mappable {
    
    
    
    
    var SchoolId : String!
    var MemberId : String!
    var CircularDate : String!
    var videoType : String!
    var CountryID : String!
    
    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        SchoolId <- map["SchoolId"]
        MemberId <- map["MemberId"]
        
        CircularDate <- map["CircularDate"]
        videoType <- map["Type"]
        
        
        CountryID <- map["CountryID"]
        
    }
    
    
}



class MessageFromManagentVideoResponse: Mappable {
    
    
    
    var ID : String!
    var URL : String!
    var Date : String!
    var Time : String!
    var Subject : String!
    var AppReadStatus : String!
    var Query : String!
    var Question : String!
    var Status : String!
    var Message : String!
    var is_Archive : Bool!
    
    var Title : String!
    var Description : String!
    var VimeoUrl : String!
    var VimeoId : String!
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        ID <- map["ID"]
        URL <- map["URL"]
        Date <- map["Date"]
        Time <- map["Time"]
        Subject <- map["Subject"]
        AppReadStatus <- map["AppReadStatus"]
        Query <- map["Query"]
        Question <- map["Question"]
        Status <- map["Status"]
        Message <- map["Message"]
        is_Archive <- map["is_Archive"]
        
        Title <- map["Title"]
        Description <- map["Description"]
        VimeoUrl <- map["VimeoUrl"]
        VimeoId <- map["VimeoId"]
        
        
    }
    
    
}
