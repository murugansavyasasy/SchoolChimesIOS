//
//  NotiResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 11/11/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

import ObjectMapper
class Notimodal : Mappable{
    
    var url : String!
    var duration : String!
    var ei1 : String!
    var ei2 : String!
    var ei3 : String!
    var ei4 : String!
    var ei5 : String!
    var start_time : String!
    var end_time : String!
    var retrycount : String!
    var phone : String!
    var receiver_id : String!
    var circular_id : String!
    var diallist_id : String!
    var call_status : String!
    
    init(){}
  
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        url <- map["url"]
        duration <- map["duration"]
        ei1 <- map["ei1"]
        ei2 <- map["ei2"]
        ei3 <- map["ei3"]
        ei4 <- map["ei4"]
        ei5 <- map["ei5"]
        start_time <- map["start_time"]
        phone <- map["phone"]
        start_time <- map["start_time"]
        receiver_id <- map["receiver_id"]
        circular_id <- map["circular_id"]
        diallist_id <- map["diallist_id"]
        call_status <- map["call_status"]
        retrycount <- map["retrycount"]
    }
    
    
    
    
    
}
class notiRes : Mappable{
    
    var Message : String!
    var Status : Int!
    
   
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Message <- map["Message"]
        Status <- map["Status"]
    }
    
    
    
    
    
}
