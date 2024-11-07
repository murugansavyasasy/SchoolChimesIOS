//
//  ClassTimeTableModal.swift
//  VoicesnapSchoolApp
//
//  Created by APPLE on 27/01/23.
//  Copyright © 2023 Shenll-Mac-04. All rights reserved.
//

import Foundation
import ObjectMapper


class ClassTimeTableModal : Mappable {
   
   
    
    var SchoolId : Int!
    var ChildId : String!
    var DayId : String!
   

    init(){}
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        SchoolId <- map["SchoolId"]
        ChildId <- map["ChildId"]
        
        DayId <- map["DayId"]
       

    }
    
    
}


class ClassTimeTableRespose : Mappable {
   
           
    
    var Status : Int!
    var Message : String!
    var data : [ClassTimeTableData]!
   

    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
        data <- map["data"]
       

    }
    
    
}



class ClassTimeTableData: Mappable {

   
  
       

    var name : String!
    var fromTime : String!
    var toTime : String!
    var duration : String!
    var hourType : String!
    var subjectName : String!
    var staffName : String!
   

   
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
      
       
        name <- map["name"]
        fromTime <- map["fromTime"]
        toTime <- map["toTime"]
        duration <- map["duration"]
        hourType <- map["hourType"]
        subjectName <- map["subjectName"]
        staffName <- map["staffName"]
       

        
    }
    
    
}
