//
//  AdvertismentModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 29/11/22.
//  Copyright © 2022 Shenll-Mac-04. All rights reserved.
//

import Foundation
import ObjectMapper


class AdvertismentModal : Mappable {
    
    
    
    var MemberId                      : String!
    var MemberType                    : String!
    var MenuId                        : String!
    var SchoolId                      : String!
    
    init(){}
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        MemberId                      <- map["MemberId"]
        MemberType                    <- map["MemberType"]
        MenuId                        <- map["MenuId"]
        SchoolId                      <- map["SchoolId"]
    }
}



class AdvertismentResponse : Mappable {
    
    
   
    
    var Status                        : String!
    var Message                       : String!
    var data                          : [MenuData]!
    
    init(){}
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        Status                        <- map["Status"]
        Message                       <- map["Message"]
        data                          <- map["data"]
    }
       
}
        

class MenuData : Mappable {



        
    var id                            : Int!
    var advertisementName             : String!
    var contentUrl                    : String?
    var redirectUrl                   : String!
        
    init(){}
    required init?(map: Map) {
        mapping(map: map)
        
    }
        
    func mapping(map: Map) {
        id                            <- map["id"]
        advertisementName             <- map["advertisementName"]
        contentUrl                    <- map["contentUrl"]
        redirectUrl                   <- map["redirectUrl"]
        }
    }
